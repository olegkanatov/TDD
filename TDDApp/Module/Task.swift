//
//  Task.swift
//  TDDApp
//
//  Created by Oleg Kanatov on 3.11.21.
//

import Foundation

struct Task {
    
    let title: String
    let description: String?
    private(set) var date: Date?
    let location: Location?
    
    init(title: String, description: String? = nil, location: Location? = nil) {
        self.title = title
        self.description = description
        self.date = Date()
        self.location = location
    }
}
