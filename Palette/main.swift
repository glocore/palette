//
//  main.swift
//  Palette
//
//  Created by Ashwin on 31/08/21.
//

import Cocoa

// Reference: https://stackoverflow.com/a/54239088
autoreleasepool {
 let delegate = AppDelegate()
 // NSApplication delegate is a weak reference,
 // so we have to make sure it's not deallocated.
 withExtendedLifetime(delegate, {
     let application = NSApplication.shared
     application.delegate = delegate
     application.run()
     application.delegate = nil
 })
}
