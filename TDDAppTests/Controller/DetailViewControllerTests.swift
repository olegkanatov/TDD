//
//  DetailViewControllerTests.swift
//  TDDAppTests
//
//  Created by Oleg Kanatov on 8.11.21.
//

import XCTest
@testable import TDDApp
import CoreLocation

class DetailViewControllerTests: XCTestCase {
    
    var sut: DetailViewController!

    override func setUpWithError() throws {
        
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: String(describing: DetailViewController.self)) as? DetailViewController
        
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testHasTitleLabel() {
        
        XCTAssertNotNil(sut.titleLabel)
        XCTAssertTrue(sut.titleLabel.isDescendant(of: sut.view))
    }
    
    func testHasDescriptionLabel() {
    
        XCTAssertNotNil(sut.descriptionLabel)
        XCTAssertTrue(sut.descriptionLabel.isDescendant(of: sut.view))
    }
    
    func testHasDateLabel() {
    
        XCTAssertNotNil(sut.dateLabel)
        XCTAssertTrue(sut.dateLabel.isDescendant(of: sut.view))
    }
    
    func testHasMapView() {
    
        XCTAssertNotNil(sut.mapView)
        XCTAssertTrue(sut.mapView.isDescendant(of: sut.view))
    }
    
    func testHasLocationLabel() {
    
        XCTAssertNotNil(sut.locationLabel)
        XCTAssertTrue(sut.locationLabel.isDescendant(of: sut.view))
    }
    
    func setupTaskAddAppearanceTransition() {
        let coordinate = CLLocationCoordinate2D(latitude: 53.9024716, longitude: 27.5618225)
        let location = Location(name: "Baz", coordinate: coordinate)
        let date = Date(timeIntervalSince1970: 1546304194)
        let task = Task(title: "Foo", description: "Bar", date: date, location: location)
        
        sut.task = task
        sut.beginAppearanceTransition(true, animated: true)
        sut.endAppearanceTransition()
        
    }
    
    func testSettingTaskSetsTitleLabel() {
        
        setupTaskAddAppearanceTransition()
        
        XCTAssertEqual(sut.titleLabel.text, "Foo")
    }
    
    func testSettingTaskSetsDescriptionLabel() {
        
        setupTaskAddAppearanceTransition()
        
        XCTAssertEqual(sut.descriptionLabel.text, "Bar")
    }
    
    func testSettingTaskSetsLocationLabel() {
        
        setupTaskAddAppearanceTransition()
        
        XCTAssertEqual(sut.locationLabel.text, "Baz")
    }
    
    func testSettingTaskSetsDateLabel() {
        
        setupTaskAddAppearanceTransition()
        
        XCTAssertEqual(sut.dateLabel.text, "01.01.19")
    }
    
    func testSettingTaskSetsMapView() {
        
        setupTaskAddAppearanceTransition()
        
        XCTAssertEqual(sut.mapView.centerCoordinate.latitude, 53.9024716, accuracy: 0.001)
        XCTAssertEqual(sut.mapView.centerCoordinate.longitude, 27.5618225, accuracy: 0.001)
    }
}
