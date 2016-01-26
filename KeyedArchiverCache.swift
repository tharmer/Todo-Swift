//
//  KeyedArchiverCache.swift
//  ToDo
//
//  Created by Terry Harmer on 25/01/2016.
//  Copyright © 2016 Terry Harmer. All rights reserved.
//

import Foundation

class KeyedArchiverCache: CacheProtocol {
    func loadObjectForKey(key: String) -> AnyObject? {
        
        let path = self.archivePath(key)
        return NSKeyedUnarchiver.unarchiveObjectWithFile(path)
    }
    
    func saveObject(object: AnyObject, key: String) {
        
        let path = self.archivePath(key)
        
        NSKeyedArchiver.archiveRootObject(object, toFile: path)
        
    }
    
    //MARK: Utilities
    
    private func archivePath(key: String) ->String     {
        
        let path = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0]
        
        var URL = NSURL(string: path as String)!
        
        URL = URL.URLByAppendingPathComponent(key)
        URL = URL.URLByAppendingPathExtension("archive")
        
        return URL.absoluteString as String
    
    }
}