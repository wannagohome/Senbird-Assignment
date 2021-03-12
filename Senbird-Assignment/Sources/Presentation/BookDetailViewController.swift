//
//  BookDetailViewController.swift
//  Senbird-Assignment
//
//  Created by Jinho Jang on 2021/03/11.
//

import UIKit

protocol BookDetailViewControllable: class {
    func show(bookDetail: BookDetail, completionHandler: (() -> Void)?)
    func showAlert(with title: String, completionHandler: (() -> Void)?)
    func getNote(_ note: String?)
}

extension BookDetailViewControllable {
    func showAlert(with title: String, completionHandler: (() -> Void)? = nil) {
        self.showAlert(with: title, completionHandler: completionHandler)
    }
    func show(bookDetail: BookDetail, completionHandler: (() -> Void)? = nil) {
        self.show(bookDetail: bookDetail, completionHandler: completionHandler)
    }
}

final class BookDetailViewController:
    UIViewController,
    BookDetailViewControllable {
    
    var viewModel: BookDetailViewModelProtocol?
    let bookTextView = UITextView()
    let noteLabel = UILabel()
    let noteTextView = UITextView()
    var detailHeight: NSLayoutConstraint?
    
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
        self.setAttributes()
        self.view.backgroundColor = .white
        self.noteTextView.delegate = self
    }
    
    func getNote(_ note: String?) {
        self.noteTextView.text = note
    }
    
    func show(bookDetail: BookDetail,
              completionHandler: (() -> Void)? = nil) {
        DispatchQueue.main.async { [weak self] in
            let attributedString = NSMutableAttributedString(string: bookDetail.description)
            attributedString.addAttribute(.link, value: bookDetail.url, range: (bookDetail.description as NSString).range(of: bookDetail.url))
            
            self?.bookTextView.attributedText = attributedString
            self?.adjustTextViewHeight()
        }
    }
    
    func showAlert(with title: String, completionHandler: (() -> Void)?) {
        DispatchQueue.main.async {
            let alert = UIAlertController(title: title, message: nil, preferredStyle: .alert)
            let action = UIAlertAction(title: "dismiss", style: .default)
            alert.addAction(action)
            self.present(alert, animated: true)
            completionHandler?()
        }
    }
    
    private func adjustTextViewHeight() {
        let fixedWidth = bookTextView.frame.size.width
        let newSize = bookTextView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.greatestFiniteMagnitude))
        self.detailHeight?.constant = newSize.height
        self.view.layoutIfNeeded()
    }
    
    private func setAttributes() {
        self.bookTextView.isEditable = false
        self.noteLabel.text = "Note :"
        self.noteLabel.font = .boldSystemFont(ofSize: 19)
    }
    
    private func setupLayout() {
        self.view.addSubview(self.bookTextView)
        self.view.addSubview(self.noteLabel)
        self.view.addSubview(self.noteTextView)
        
        self.bookTextView.translatesAutoresizingMaskIntoConstraints = false
        self.noteLabel.translatesAutoresizingMaskIntoConstraints = false
        self.noteTextView.translatesAutoresizingMaskIntoConstraints = false

        self.bookTextView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
        self.bookTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
        self.bookTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.detailHeight = self.bookTextView.heightAnchor.constraint(equalToConstant: 200)
        self.detailHeight?.isActive = true
        
        self.noteLabel.topAnchor.constraint(equalTo: self.bookTextView.bottomAnchor, constant: 15).isActive = true
        self.noteLabel.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        self.noteLabel.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        
        self.noteTextView.topAnchor.constraint(equalTo: self.noteLabel.bottomAnchor).isActive = true
        self.noteTextView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 15).isActive = true
        self.noteTextView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
        self.noteTextView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
}

extension BookDetailViewController: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        self.viewModel?.setNote(textView.text)
    }
}
