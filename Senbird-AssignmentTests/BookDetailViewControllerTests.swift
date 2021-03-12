//
//  BookDetailViewControllerTests.swift
//  Senbird-AssignmentTests
//
//  Created by Jinho Jang on 2021/03/12.
//

import Foundation
import XCTest
@testable import Senbird_Assignment

final class BookDetailViewControllerTests: XCTestCase {
    var viewModel: BookDetailViewModel!
    var viewController: BookDetailViewController!
    var networkManager: NetworkManagerStub!
    var service: Service!
    let testISBN13: String = "123"
    
    override func setUp() {
        super.setUp()
        self.networkManager = NetworkManagerStub()
        self.service = Service(networkManager: self.networkManager)
        self.viewModel = BookDetailViewModel(service: self.service,
                                             state: .init(isbn13: self.testISBN13))
        self.viewController = BookDetailViewController(viewModel: self.viewModel)
        self.viewController.loadViewIfNeeded()
    }
    
    func testShowBookDetail() {
        let book: BookDetail = .init(error: "", title: "123", subtitle: "", authors: "", publisher: "", isbn10: "", isbn13: "", pages: "", year: "", rating: "", desc: "", price: "", image: "", url: "")
        self.viewController.show(bookDetail: book) {
            XCTAssertTrue(self.viewController.bookTextView.attributedText.string.contains("123"))
        }
    }
    
    func testAlert_afterReceiveErrorMessage() {
        self.viewController.showAlert(with: "123") {
            XCTAssertNotNil(self.viewController.presentedViewController)
        }
    }
}
