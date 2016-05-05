//
//  CategoryModel.swift
//  SISpeciesNotes
//
//  Created by wood lou on 16/5/2.
//  Copyright © 2016年 益行人. All rights reserved.
//

import RealmSwift
import UIKit

class CategoryModel: Object {
    
    dynamic var name = Categories.Uncategorized.rawValue
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
