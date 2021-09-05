//
//  GoogleDriveService.swift
//  Palette
//
//  Created by Ashwin on 31/08/21.
//

import Foundation
import Moya

var testAccessToken = ""

struct GoogleDriveSearchResult: Decodable {
    let id: String
    let name: String?
    let kind: String?
    let mimeType: String?
    let webViewLink: String?
    let thumbnailLink: String?
    let createdTime: String?
    let modifiedTime: String?
}

enum GoogleDriveService {
    case files(searchQuery: String)
}

extension GoogleDriveService: TargetType {
    
    var baseURL: URL { return URL(string: "https://www.googleapis.com/drive/v3")! }
    
    var path: String {
        switch self {
        case .files:
            return "/files"
        }
    }
    
    var method: Moya.Method {
        return .get
    }
    
    var task: Task {
        switch self {
        case let .files(searchQuery):
            return .requestParameters(parameters: [
                                        "q": "name contains '\(searchQuery)'",
                                        "fields": "files(id,name,kind,mimeType,webViewLink,thumbnailLink,createdTime,modifiedTime)"
            ], encoding: URLEncoding.queryString)
        }
    }
    
    var sampleData: Data {
        return Data()
    }
    
    var headers: [String: String]? {
        return [
            "Accept": "application/json",
            "Authorization": "Bearer \(testAccessToken)"
        ]
    }
}
