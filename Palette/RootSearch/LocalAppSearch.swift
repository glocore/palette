//
//  LocalAppSearch.swift
//  Palette
//
//  Created by Ashwin on 23/08/21.
//

import Foundation

protocol LocalAppSearchDelegate {
    func localAppResultsDidUpdate(_ newResults: [ResultItem]) -> Void
}

class LocalAppSearch {
    var localAppSearchDelegate: LocalAppSearchDelegate?
    
    private let searchScopes = [
        "/Applications",
        "/System/Applications", // system apps such as System Preferences, TextEdit, etc.
        "/System/Library/CoreServices/Applications", // misc. system utilities
        "/Applications/Xcode.app/Contents/Applications", // companion apps added by Xcode, such as Instruments, FileMerge, etc.
        "/Developer/Applications",
        "/System/Library/PreferencePanes", // shortcuts to each screen in system preferences
        "/Library/PreferencePanes", // pref. panes added by third party software
    ]
    
    var metadataQuery = NSMetadataQuery()
    
    init() {
        registerNotifications()
        metadataQuery.searchScopes = searchScopes
    }
    
    deinit {
        metadataQuery.stop()
    }
    
    func updateQuery(to queryString: String) {
        guard queryString.count > 0 else { return }
        
        metadataQuery.predicate = NSPredicate(format: "%K CONTAINS[cdnl] %@", argumentArray: [NSMetadataItemFSNameKey, queryString])
        metadataQuery.start()
    }
    
    func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(onQueryDidFinishGathering), name: NSNotification.Name.NSMetadataQueryDidFinishGathering, object: metadataQuery)
        NotificationCenter.default.addObserver(self, selector: #selector(onQueryGatheringProgress), name: NSNotification.Name.NSMetadataQueryGatheringProgress, object: metadataQuery)
    }
    
    @objc func onQueryDidFinishGathering() {
        metadataQuery.stop()
    }
    
    @objc func onQueryGatheringProgress() {
        var searchResults = [ResultItem]()
        let resultCount = metadataQuery.resultCount > 50 ? 50 : metadataQuery.resultCount
        for index in 0..<resultCount {
            let item = metadataQuery.result(at: index) as! NSMetadataItem
            let displayName = item.value(forAttribute: NSMetadataItemDisplayNameKey) as? String
            let path = item.value(forAttribute: NSMetadataItemPathKey) as? String
            
            guard let displayName = displayName, let path = path else { continue }
            
            searchResults.append(ResultItem(displayName: displayName, shortDescription: path))
        }
        
        localAppSearchDelegate?.localAppResultsDidUpdate(searchResults)
        
        if(metadataQuery.resultCount >= 50) {
            metadataQuery.stop()
        }
    }
}
