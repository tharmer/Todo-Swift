//
//  CacheProtocol.swift
//  ToDo
//
//  Created by Terry Harmer on 25/01/2016.
//  Copyright © 2016 Terry Harmer. All rights reserved.
//

import Foundation

protocol CacheProtocol {
    
    func loadObjectForKey(key: String) -> AnyObject?
    
    func saveObject(object: AnyObject, key: String)
    
}