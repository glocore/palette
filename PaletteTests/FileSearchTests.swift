//
//  FileSearchTests.swift
//  PaletteTests
//
//  Created by Ashwin on 29/07/21.
//

@testable import Palette
import XCTest

/**
 Couldn't write tests because spotlight does not index the temporary test files before they are queried in the tests. FileSearch currently does not support live updates, either.
 */
class FileSearchTests: XCTestCase {
    var fileSearch: FileSearch?
    var temporaryDirectory: String!
    
    struct FileMetadata {
        var name: String
        var url: URL
    }
    var temporaryFiles: [FileMetadata]!
    
    
    override func setUp() {
        super.setUp()
        
        temporaryDirectory = NSTemporaryDirectory()
        let temporaryFileNames = [UUID().uuidString, UUID().uuidString]
        temporaryFiles = temporaryFileNames.map { fileName in
            FileMetadata(name: fileName, url: URL(fileURLWithPath: temporaryDirectory).appendingPathComponent(fileName))
        }
        
        let fileContent = "Test String"
        do {
            try temporaryFiles.forEach { file in
                try fileContent.write(to: file.url, atomically: true, encoding: .utf8)
            }
        } catch {
            XCTFail("Failed to write test files. Reason: \(error)")
        }
        
        
        let temporaryDirectoryUrl = URL(fileURLWithPath: temporaryDirectory)
        fileSearch = FileSearch(searchScopes: [temporaryDirectoryUrl])
    }
    
    override func tearDown() {
        fileSearch = nil
        
        do {
            let fileManager = FileManager.default
            
            try temporaryFiles.forEach { file in
                if fileManager.fileExists(atPath: file.url.path) {
                    try fileManager.removeItem(at: file.url)
                    XCTAssertFalse(fileManager.fileExists(atPath: file.url.path))
                }
            }
        } catch {
            XCTFail("Error while deleting temporary files: \(error)")
        }
        
        super.tearDown()
    }
}
