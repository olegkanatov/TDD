//
//  String + extensions.swift
//  TDDApp
//
//  Created by Oleg Kanatov on 8.11.21.
//

import Foundation

extension String {
    
    var percentEncoded: String {
        let allowedCharacters = CharacterSet(charactersIn: "!@#$%^&*()-+=[]\\}{,./?><").inverted
        guard let encodedString = self.addingPercentEncoding(withAllowedCharacters: allowedCharacters) else {
            fatalError()
        }
        return encodedString
    }
}
