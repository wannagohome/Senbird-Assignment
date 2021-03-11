//
//  BookDetailViewController.swift
//  Senbird-Assignment
//
//  Created by Jinho Jang on 2021/03/11.
//

import UIKit

protocol BookDetailViewControllable: class {
    func show(bookDetail: BookDetail)
    func showAlert(with title: String, completionHandler: (() -> Void)?)
}

extension BookDetailViewControllable {
    func showAlert(with title: String, completionHandler: (() -> Void)? = nil) {
        self.showAlert(with: title, completionHandler: completionHandler)
    }
}

final class BookDetailViewController:
    UIViewController,
    BookDetailViewControllable {
    
    var viewModel: BookDetailViewModelProtocol?
    let textView = UITextView()
    
    init(viewModel: BookDetailViewModelProtocol) {
        defer {
            self.viewModel?.viewControllable = self
        }
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupLayout()
        self.textView.isEditable = false
    }
    
    func show(bookDetail: BookDetail) {
        DispatchQueue.main.async {
            self.textView.text = bookDetail.description
        }
    }
    
    func showAlert(with title: String, completionHandler: (() -> Void)?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "dismiss", style: .default)
            alert.addAction(action)
            self.present(alert, animated: true, completion: completionHandler)
        }
    }
    
    private func setupLayout() {
        self.view.addSubview(self.textView)
        
        self.textView.translatesAutoresizingMaskIntoConstraints = false

        self.textView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.textView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.textView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.textView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}
