//
//  SpeciesModel.swift
//  SISpeciesNotes
//
//  Created by wood lou on 16/5/2.
//  Copyright © 2016年 益行人. All rights reserved.
//

import UIKit
import RealmSwift

class SpeciesModel: Object {
    
    dynamic var name = ""
    dynamic var speciesDescription: String?
    dynamic var latitude: Double = 0
    dynamic var longitude: Double = 0
    dynamic var created = NSDate()
    dynamic var category: CategoryModel?
    
    
    
    
// Specify properties to ignore (Realm won't persist these)
    
//  override static func ignoredProperties() -> [String] {
//    return []
//  }
}
