//
//  SearchViewModel.swift
//  Senbird-Assignment
//
//  Created by Jinho Jang on 2021/03/11.
//

import Foundation

protocol SearchViewModelProtocol {
    var state: SearchViewState { get }
    
    func search(with keyword: String?)
}

struct SearchViewState {
    var searchResult: SearchResult?
}

final class SearchViewModel: SearchViewModelProtocol {
    let service: Service
    var state: SearchViewState
    weak var viewControllable: SearchViewControllable?
    
    init(service: Service = Service(),
         state: SearchViewState = SearchViewState()) {
        self.service = service
        self.state = state
    }
    
    func search(with keyword: String?) {
        guard let keyword = keyword else { return }
        
        self.service.search(keyword: keyword) { result in
            switch result {
            case .success(let result):
                guard result.books.isEmpty == false else {
                    self.viewControllable?.showAlert(with: NetworkError.noBooks.message)
                    return
                }
                self.state.searchResult = result
                self.viewControllable?.reloadTable()
            case .failure(let error):
                self.viewControllable?.showAlert(with: error.message)
            }
        }
    }
}
