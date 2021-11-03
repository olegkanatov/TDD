//
//  Task.swift
//  TDDApp
//
//  Created by Oleg Kanatov on 3.11.21.
//

import Foundation

struct Task {
    
    var title: String
    var description: String?
    private(set) var date: Date?
    
    init(title: String, description: String? = nil) {
        self.title = title
        self.description = description
        self.date = Date()
    }
}
