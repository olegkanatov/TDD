//
//  TaskTests.swift
//  TDDAppTests
//
//  Created by Oleg Kanatov on 3.11.21.
//

import XCTest
@testable import TDDApp

class TaskTests: XCTestCase {

    func testInitTaskWithTitle() {
        
        let task = Task(title: "Foo") // Foo Bar Baz
        
        XCTAssertNotNil(task)
    }
    
    func testInitTaskWithTitleAndDescription() {
        
        let task = Task(title: "Foo", description: "Bar") // Foo Bar Baz
        
        XCTAssertNotNil(task)
    }
    
    func testWhenGivenTitleSetsTitle() {
        
        let task = Task(title: "Foo")
        
        XCTAssertEqual(task.title, "Foo")
    }
    
    func testWhenGivenDescriptionSetsDescription() {
        
        let task = Task(title: "Foo", description: "Bar")
        
        XCTAssertTrue(task.description == "Bar")
    }
    
    func testTaskInitsWithDate() {
        
        let task = Task(title: "Foo")
        
        XCTAssertNotNil(task.date)
    }
}
