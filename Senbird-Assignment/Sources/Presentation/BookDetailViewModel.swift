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
    
    func setNote(_ note: String?)
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
            guard let self = self else { return }
            switch result {
            case .success(let result):
                self.viewControllable?.show(bookDetail: result)
                self.viewControllable?.getNote(UserDefaults.standard.string(forKey: self.state.isbn13))
            case .failure(let error):
                self.viewControllable?.showAlert(with: error.message)
            }
        }
    }
    
    func setNote(_ note: String?) {
        UserDefaults.standard.set(note, forKey: self.state.isbn13)
    }
}
