//
//  APIClientTests.swift
//  TDDAppTests
//
//  Created by Oleg Kanatov on 8.11.21.
//

import XCTest
@testable import TDDApp

class APIClientTests: XCTestCase {
    
    var sut: APIClient!
    var mockURLSession: MockURLSession!

    override func setUpWithError() throws {
        
        mockURLSession = MockURLSession()
        sut = APIClient()
        sut.urlSession = mockURLSession
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func userLogin() {
        
        let complitionHandler = {(token: String?, error: Error?) in }
        sut.login(withName: "name", password: "%qwerty", complitionHandler: complitionHandler)
    }
    
    func testLoginUsesCorrectHost() {
        
        userLogin()
        
        XCTAssertEqual(mockURLSession.urlComponents?.host, "todoapp.com")
    }
    
    func testLoginUsesCorrectPath() {
        
        userLogin()
        
        XCTAssertEqual(mockURLSession.urlComponents?.path, "/login")
    }
    
    func testLoginUsesExpectedQueryParameters() {
        
        userLogin()
        
        guard let quaryItems = mockURLSession.urlComponents?.queryItems else {
            XCTFail()
            return
        }
        
        let urlQuaryItemName = URLQueryItem(name: "name", value: "name")
        let urlQuaryItemPassword = URLQueryItem(name: "password", value: "%qwerty")
        
        XCTAssertTrue(quaryItems.contains(urlQuaryItemName))
        XCTAssertTrue(quaryItems.contains(urlQuaryItemPassword))
    }

}

extension APIClientTests {
    
    class MockURLSession: URLSessionProtocol {
        
        var url: URL?
        
        var urlComponents: URLComponents? {
            guard let url = url else {
                return nil
            }
            return URLComponents(url: url, resolvingAgainstBaseURL: true)
        }
        
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            
            self.url = url
            
            return URLSession.shared.dataTask(with: url)
        }
    }
}
