//
//  SearchViewModel.swift
//  Senbird-Assignment
//
//  Created by Jinho Jang on 2021/03/11.
//

import Foundation

protocol SearchViewModelProtocol {
    var state: SearchViewState { get }
    var viewControllable: SearchViewControllable? { get set }
    
    func search(with keyword: String?)
    func loadNextPage()
}

struct SearchViewState {
    var searchResult: SearchResult?
    var searchKeyword: String?
    var page: Int = 1
    var isLoading: Bool = false
}

final class SearchViewModel: SearchViewModelProtocol {
    let service: ServiceProtocol
    var state: SearchViewState
    weak var viewControllable: SearchViewControllable?
    
    init(service: ServiceProtocol = Service(),
         state: SearchViewState = SearchViewState()) {
        self.service = service
        self.state = state
    }
    
    func search(with keyword: String?) {
        guard let keyword = keyword,
              !self.state.isLoading else {
            return
        }
        
        self.state.searchKeyword = keyword
        self.state.isLoading = true
        self.state.page = 1
        self.service.search(keyword: keyword) { [weak self] result in
            switch result {
            case .success(let result):
                guard result.books.isEmpty == false else {
                    self?.viewControllable?.showAlert(with: NetworkError.noBooks.message)
                    return
                }
                self?.state.searchResult = result
                self?.viewControllable?.reloadTable()
            case .failure(let error):
                self?.viewControllable?.showAlert(with: error.message)
            }
            self?.state.isLoading = false
        }
    }
    
    func loadNextPage() {
        guard !self.state.isLoading else { return }
        guard let keyword = self.state.searchKeyword else { return }
        
        self.state.isLoading = true
        self.state.page += 1
        self.service.search(keyword: keyword, page: self.state.page) { [weak self] result in
            switch result {
            case .success(let result):
                guard result.books.isEmpty == false else {
                    self?.viewControllable?.showAlert(with: NetworkError.noBooks.message)
                    return
                }
                self?.state.searchResult?.books.append(contentsOf: result.books)
                self?.viewControllable?.reloadTable()
            case .failure(let error):
                self?.viewControllable?.showAlert(with: error.message)
            }
            self?.state.isLoading = false
        }
    }
}
