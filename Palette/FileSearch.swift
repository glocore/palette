//
//  FileSearch.swift
//  Palette
//
//  Created by Ashwin on 28/07/21.
//

import Foundation
import AVFoundation

let defaultSearchScopes = [
    "/Applications",
    NSString("~").expandingTildeInPath
    
]

class LocalFileSearchResult: NSObject {
    @objc dynamic var displayName: String?
    @objc dynamic var path: String?
    
    init(displayName: String?, path: String?) {
        self.displayName = displayName
        self.path = path
    }
}

class LocalFileSearch {
    typealias OnResultsUpdate = ([LocalFileSearchResult]) -> Void
    
    var mdQuery: MDQuery?
    var onResultsUpdate: OnResultsUpdate
    
    init(onResultsUpdate: @escaping OnResultsUpdate) {
        self.onResultsUpdate = onResultsUpdate
        
        print(NSString("~").expandingTildeInPath)
    }
    
    deinit {
        if(mdQuery != nil) {
            MDQueryStop(mdQuery)
        }

        mdQuery = nil
    }
    
    func updateQueryString(to queryString: String) {
        let queryStringSanitised = QuerySanitiser().sanitise(queryString)
        guard queryStringSanitised.count > 0 else { return }
        
        if(mdQuery != nil) {
            MDQueryStop(mdQuery)
        }
        
        mdQuery = MDQueryCreate(kCFAllocatorDefault, "kMDItemDisplayName == \"*\(queryString)*\"cd" as CFString, nil, nil)
        MDQuerySetSearchScope(mdQuery, defaultSearchScopes as CFArray, 0)
        MDQuerySetMaxCount(mdQuery, 50)
        MDQueryExecute(mdQuery, CFOptionFlags(kMDQuerySynchronous.rawValue))
        
        let count = MDQueryGetResultCount(mdQuery);
        print("count: \(count)")
        
        var results = [LocalFileSearchResult]()
        
        /* Reference: https://gist.github.com/dagronf/3d03094a7ee79c1f91607f4c365fba91 */
        
        for i in 0 ..< count {
            let rawPtr = MDQueryGetResultAtIndex(mdQuery, i)
            let item = Unmanaged<MDItem>.fromOpaque(rawPtr!).takeUnretainedValue()
            
            
            let result = LocalFileSearchResult(displayName: nil, path: nil)
            
            if let displayName = MDItemCopyAttribute(item, kMDItemDisplayName) as? String {
                result.displayName = displayName
            }
            
            if let path = MDItemCopyAttribute(item, kMDItemPath) as? String {
                result.path = path
            }
            
            results.append(result)
        }
        
        onResultsUpdate(results)
    }
}


class MDQSearch {
    typealias OnResultsUpdate = ([LocalFileSearchResult]) -> Void
    
    var onResultsUpdate: OnResultsUpdate
    var metadataQuery = NSMetadataQuery()
    
    init(onResultsUpdate: @escaping OnResultsUpdate) {
        self.onResultsUpdate = onResultsUpdate
        registerNotifications()
//        metadataQuery.searchScopes = [NSString("~/Documents").expandingTildeInPath]
//        metadataQuery.sortDescriptors = [NSSortDescriptor(key: kMDItemLastUsedDate as String?, ascending: false)]
    }
    
    deinit {
        metadataQuery.stop()
    }
    
    func updateQuery(to queryString: String) {
        guard queryString.count > 0 else { return }
        
        metadataQuery.predicate = NSPredicate(format: "%K CONTAINS[cd] %@", argumentArray: [NSMetadataItemDisplayNameKey, queryString])
        metadataQuery.start()
    }
    
    func registerNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(onQueryDidFinishGathering), name: NSNotification.Name.NSMetadataQueryDidFinishGathering, object: metadataQuery)
        NotificationCenter.default.addObserver(self, selector: #selector(onQueryGatheringProgress), name: NSNotification.Name.NSMetadataQueryGatheringProgress, object: metadataQuery)
        NotificationCenter.default.addObserver(self, selector: #selector(onQueryDidUpdate), name: NSNotification.Name.NSMetadataQueryDidUpdate, object: metadataQuery)
    }
    
    @objc func onQueryDidUpdate() {
        print("QueryDidUpdate")
    }
    
    @objc func onQueryDidFinishGathering() {
        print("QueryDidFinishGathering")
        metadataQuery.stop()
        
        print("result count: \(metadataQuery.resultCount)")
    }
    
    @objc func onQueryGatheringProgress() {
        print("QueryGatheringProgress")
        
        print(metadataQuery.resultCount)
        
        if(metadataQuery.resultCount > 0) {
            var searchResults = [LocalFileSearchResult]()
            let resultCount = metadataQuery.resultCount > 50 ? 50 : metadataQuery.resultCount
            for index in 0..<resultCount {
                let item = metadataQuery.result(at: index) as! NSMetadataItem
                let displayName = item.value(forAttribute: NSMetadataItemDisplayNameKey) as? String
                let path = item.value(forAttribute: NSMetadataItemPathKey) as? String
                
                searchResults.append(LocalFileSearchResult(displayName: displayName, path: path))
            }
            
            self.onResultsUpdate(searchResults)
        }
        
        if(metadataQuery.resultCount >= 50) {
            metadataQuery.stop()
            
            print("result count: \(metadataQuery.resultCount)")
        }
    }
}
