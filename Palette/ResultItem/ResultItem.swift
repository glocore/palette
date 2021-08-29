//
//  ResultItem.swift
//  Palette
//
//  Created by Ashwin on 23/08/21.
//

import Foundation

class ResultItem: NSObject {
    @objc dynamic var displayName: String
    @objc dynamic var shortDescription: String?
    
    init(displayName: String, shortDescription: String?) {
        self.displayName = displayName
        self.shortDescription = shortDescription
    }
}
