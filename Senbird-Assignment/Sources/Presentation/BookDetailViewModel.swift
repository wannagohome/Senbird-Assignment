//
//  BookDetailViewModel.swift
//  Senbird-Assignment
//
//  Created by Jinho Jang on 2021/03/12.
//

import Foundation

protocol BookDetailViewModelProtocol {
    var state: BookDetailViewState { get }
    var viewControllable: BookDetailViewControllable? { get set }
}

struct BookDetailViewState {
    let isbn13: String
}

final class BookDetailViewModel: BookDetailViewModelProtocol {
    let service: ServiceProtocol
    var state: BookDetailViewState
    weak var viewControllable: BookDetailViewControllable?
    
    init(service: ServiceProtocol = Service(),
         state: BookDetailViewState) {
        self.service = service
        self.state = state
        self.getDetail()
    }
    
    private func getDetail() {
        self.service.getDetail(isbn13: self.state.isbn13) { [weak self] result in
            switch result {
            case .success(let result):
                self?.viewControllable?.show(bookDetail: result)
            case .failure(let error):
                self?.viewControllable?.showAlert(with: error.message)
            }
        }
    }
}
