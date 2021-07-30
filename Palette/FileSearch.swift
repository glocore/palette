//
//  FileSearch.swift
//  Palette
//
//  Created by Ashwin on 28/07/21.
//

import Foundation

let defaultSearchScopes = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)

class FileSearch {
    private let searchScopes: [URL]
    private let metadataQuery: NSMetadataQuery
    var results = [NSMetadataItem]()
    
    init(searchScopes: [URL] = defaultSearchScopes) {
        self.searchScopes = searchScopes
        metadataQuery = NSMetadataQuery()
        prepareMetadataQuery()
        addNotificationObservers()
    }
    
    deinit {
        metadataQuery.stop()
    }
    
    func updateQueryString(to queryString: String) {
        guard queryString.count > 0 else { return }
        
        metadataQuery.stop()
        metadataQuery.predicate = NSPredicate(format: "%K CONTAINS[cd] %@", argumentArray: [NSMetadataItemFSNameKey, queryString])
        metadataQuery.enableUpdates()
        metadataQuery.start()
    }
    
    private func prepareMetadataQuery() {
        metadataQuery.searchScopes = searchScopes
        metadataQuery.predicate = NSPredicate(format: "%K LIKE '*'", argumentArray: [NSMetadataItemFSNameKey])
        metadataQuery.start()
    }
    
    private func addNotificationObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(handleMetadataQueryDidStartGatheringNotification), name: NSNotification.Name.NSMetadataQueryDidStartGathering, object: metadataQuery)
        NotificationCenter.default.addObserver(self, selector: #selector(handleMetadataQueryDidFinishGatheringNotification), name: NSNotification.Name.NSMetadataQueryDidFinishGathering, object: metadataQuery)
        NotificationCenter.default.addObserver(self, selector: #selector(handleMetadataQueryDidUpdateNotification), name: NSNotification.Name.NSMetadataQueryDidUpdate, object: metadataQuery)
    }
    
    @objc private func handleMetadataQueryDidStartGatheringNotification() {
        print("startGatheringNotification")
    }
    
    @objc private func handleMetadataQueryDidFinishGatheringNotification() {
        metadataQuery.disableUpdates()
        let queryResults: [NSMetadataItem] = metadataQuery.results as? [NSMetadataItem] ?? [NSMetadataItem]()
        print("finishGatheringNotification: \(metadataQuery.resultCount) results")
        
        results = queryResults
    }
    
    @objc private func handleMetadataQueryDidUpdateNotification() {
        // ignore notification
    }
}
