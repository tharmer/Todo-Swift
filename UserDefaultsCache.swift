//
//  UserDefaultsCache.swift
//  ToDo
//
//  Created by Terry Harmer on 25/01/2016.
//  Copyright © 2016 Terry Harmer. All rights reserved.
//

import Foundation

class UserDefaultsCache: CacheProtocol{
    
    func loadObjectForKey(key: String) -> AnyObject? {
      //print("load")
      return NSUserDefaults.standardUserDefaults().objectForKey(key)
        
    }
    
    
    func saveObject(object: AnyObject, key: String) {
        
        NSUserDefaults.standardUserDefaults().setObject(object, forKey: key)
        NSUserDefaults.standardUserDefaults().synchronize()
    }
    
    
    
}