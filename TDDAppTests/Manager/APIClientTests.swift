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
        
        mockURLSession = MockURLSession(data: nil, urlResponce: nil, responceError: nil)
        sut = APIClient()
        sut.urlSession = mockURLSession
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func userLogin() {
        
        let completionHandler = {(token: String?, error: Error?) in }
        sut.login(withName: "name", password: "%qwerty", completionHandler: completionHandler)
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
    
    // token -> Data -> complitionHander -> DataTask -> UrlSession
    func testSuccessfullLoginCreatesToken() {
        
        let jsonDataStub = "{\"token\": \"tokenString\"}".data(using: .utf8)
        mockURLSession = MockURLSession(data: jsonDataStub, urlResponce: nil, responceError: nil)
        sut.urlSession = mockURLSession
        
        let tokenExpectation = expectation(description: "Token_expectation")
        
        var caughtToken: String?
        sut.login(withName: "login", password: "password") { token, _ in
            caughtToken = token
            tokenExpectation.fulfill()
        }
        waitForExpectations(timeout: 1) { _ in
            XCTAssertEqual(caughtToken, "tokenString")
        }
    }
    
    func testLoginInvalidJSONReturnsError() {
        
        mockURLSession = MockURLSession(data: Data(), urlResponce: nil, responceError: nil)
        sut.urlSession = mockURLSession
        
        let errorExpectation = expectation(description: "Error expectation")
        
        var caughtError: Error?
        sut.login(withName: "login", password: "password") { _, error in
            caughtError = error
            errorExpectation.fulfill()
        }
        waitForExpectations(timeout: 1) { _ in
           XCTAssertNotNil(caughtError)
        }
    }
    
    func testLoginWhenDataIsNilReturnsError() {
        
        mockURLSession = MockURLSession(data: nil, urlResponce: nil, responceError: nil)
        sut.urlSession = mockURLSession
        
        let errorExpectation = expectation(description: "Error expectation")
        
        var caughtError: Error?
        sut.login(withName: "login", password: "password") { _, error in
            caughtError = error
            errorExpectation.fulfill()
        }
        waitForExpectations(timeout: 1) { _ in
           XCTAssertNotNil(caughtError)
        }
    }
    
    func testLoginWhenResponseErrorReturnsError() {
        let jsonDataStub = "{\"token\": \"tokenString\"}".data(using: .utf8)
        let error = NSError(domain: "Server error", code: 404, userInfo: nil)
        mockURLSession = MockURLSession(data: jsonDataStub, urlResponce: nil, responceError: error)
        sut.urlSession = mockURLSession
        let errorExpectation = expectation(description: "Error expectation")
        
        var caughtError: Error?
        sut.login(withName: "login", password: "password") { _, error in
            caughtError = error
            errorExpectation.fulfill()
        }
        waitForExpectations(timeout: 1) { _ in
            XCTAssertNotNil(caughtError)
        }
    }

}

extension APIClientTests {
    
    class MockURLSession: URLSessionProtocol {
        
        var url: URL?
        
        private let mockDataTask: MockURLSessionDataTask
        
        var urlComponents: URLComponents? {
            guard let url = url else {
                return nil
            }
            return URLComponents(url: url, resolvingAgainstBaseURL: true)
        }
        
        init(data: Data?, urlResponce: URLResponse?, responceError: Error?) {
            mockDataTask = MockURLSessionDataTask(data: data, urlResponce: urlResponce, responceError: responceError)
        }
        
        func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
            
            self.url = url
            
//            return URLSession.shared.dataTask(with: url)
            mockDataTask.complitionHandler = completionHandler
            return mockDataTask
        }
    }
    
    class MockURLSessionDataTask: URLSessionDataTask {
        
        private let data: Data?
        private let urlResponce: URLResponse?
        private let responceError: Error?
        
        typealias ComplitionHandler = (Data?, URLResponse?, Error?) -> Void
        
        var complitionHandler: ComplitionHandler?
        
        init(data: Data?, urlResponce: URLResponse?, responceError: Error?) {
            
            self.data = data
            self.urlResponce = urlResponce
            self.responceError = responceError
        }
        
        override func resume() {
            
            DispatchQueue.main.async {
                
                self.complitionHandler?(
                    
                    self.data,
                    self.urlResponce,
                    self.responceError
                )
            }
        }
    }
}
