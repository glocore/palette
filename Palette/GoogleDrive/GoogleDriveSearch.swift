//
//  GoogleDriveSearch.swift
//  Palette
//
//  Created by Ashwin on 31/08/21.
//

import Foundation
import Moya


protocol GoogleDriveSearchDelegate {
    func googleDriveSearchResultsDidUpdate(_ newResults: [ResultItem]) -> Void
}

class GoogleDriveSearch {
    private var googleDriveServiceProvider = MoyaProvider<GoogleDriveService>()
    var googleDriveSearchDelegate: GoogleDriveSearchDelegate?
    
    func search(query: String) -> Cancellable {
        return googleDriveServiceProvider.request(.files(searchQuery: query), completion: { result in
            switch result {
            case let .success(moyaResponse):
                print("statusCode: \(moyaResponse.statusCode)")
                do {
                    let filteredResponse = try moyaResponse.filterSuccessfulStatusCodes()
                    let results = try filteredResponse.map([GoogleDriveSearchResult].self, atKeyPath: "files", using: JSONDecoder(), failsOnEmptyData: false)
                    print("results: \(results.count)")
                    
                    var newResults = [ResultItem]()
                    results.forEach { result in
                        newResults.append(ResultItem(displayName: result.name!, shortDescription: nil))
                    }
                    self.googleDriveSearchDelegate?.googleDriveSearchResultsDidUpdate(newResults)
                } catch {
                    print("error: \(error)")
                }
            
            case let .failure(error):
                print(error)
            }
        })
    }
}
