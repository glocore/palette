//
//  QuerySanitiser.swift
//  Palette
//
//  Created by Ashwin on 30/07/21.
//

import Foundation

class QuerySanitiser {
    func sanitise(_ string: String) -> String {
        let result = string.trimmingCharacters(in: [" "])
        
        return result
    }
}
