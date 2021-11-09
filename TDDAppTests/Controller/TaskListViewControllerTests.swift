//
//  TaskListViewControllerTests.swift
//  TDDAppTests
//
//  Created by Oleg Kanatov on 4.11.21.
//

import XCTest
@testable import TDDApp

class TaskListViewControllerTests: XCTestCase {
    
    var sut: TaskListViewController!

    override func setUpWithError() throws {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        
        let vc = storyboard.instantiateViewController(withIdentifier: String(describing: TaskListViewController.self))
        sut = vc as? TaskListViewController
        
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testWhenViewIsLoadedTableViewNoteNil() {
        
        XCTAssertNotNil(sut.tableView)
    }
    
    func testWhenViewIsLoadedDataProviderIsNotNil() {
        
        XCTAssertNotNil(sut.dataProvider)
    }
    
    func testWhenViewIsLoadedTableViewDelegateIsSet() {
        
        XCTAssertTrue(sut.tableView.delegate is DataProvider)
    }
    
    func testWhenViewIsLoadedTableViewDataSourceIsSet() {
        
        XCTAssertTrue(sut.tableView.dataSource is DataProvider)
    }
    
    func testWhenViewIsLoadedTableViewDelegateEqualsTableViewDataSource() {
        
        XCTAssertEqual(sut.tableView.delegate as? DataProvider, sut.tableView.dataSource as? DataProvider)
    }
    
    func testTaskListViewControllerHasAddBarButtonWithSelfAsTarget() {
        
        let target = sut.navigationItem.rightBarButtonItem?.target
        
        XCTAssertEqual(target as? TaskListViewController, sut)
    }
    
    func presentingNewTaskViewController() -> NewTaskViewController {
        
        guard
            let newTaskButton = sut.navigationItem.rightBarButtonItem,
            let action = newTaskButton.action else {

                return NewTaskViewController()
            }
        
        UIApplication.shared.keyWindow?.rootViewController = sut
        sut.performSelector(onMainThread: action, with: newTaskButton, waitUntilDone: true)
        
        let newTaskViewController = sut.presentedViewController as! NewTaskViewController
        return newTaskViewController
    }
    
    func testAddNewTaskPresentsNewTaskViewController() {
        
        let newTaskViewController = presentingNewTaskViewController()
        
        XCTAssertNotNil(newTaskViewController.titleTextField)
    }
    
    func testSharesSameTaskManagerWithNewTaskViewController() {

        let newTaskViewController = presentingNewTaskViewController()
        
        XCTAssertTrue(newTaskViewController.taskManager === sut.dataProvider.taskManager)
    }
}
