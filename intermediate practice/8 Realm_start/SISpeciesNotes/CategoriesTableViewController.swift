//
//  CategoriesTableViewController.swift
//  SISpeciesNotes
//
//  Created by 星夜暮晨 on 2015-04-30.
//  Copyright (c) 2015 益行人. All rights reserved.
//

import UIKit
import RealmSwift

class CategoriesTableViewController: UITableViewController {

    // MARK: - 属性
    
//    let realm = try! Realm()
//    lazy var categories: Results<CategoryModel > = { self.realm.objects(CategoryModel) }()
    var categories = []
    let realm = try? Realm()
    var selectedCategory:CategoryModel!
    // MARK: - 控制器生命周期
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.populateDefaultCategories()
        print(realm?.configuration.fileURL)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table View Data Source
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Int(categories.count)
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CategoryCell", forIndexPath: indexPath) 
        cell.textLabel?.text = categories[indexPath.row].name
        return cell
    }
    
    override func tableView(tableView: UITableView, willSelectRowAtIndexPath indexPath: NSIndexPath) -> NSIndexPath? {
        selectedCategory = self.categories[indexPath.row] as! CategoryModel
        return indexPath

        
    }
    
    private func populateDefaultCategories(){

        guard let realm = realm else {return}
        let fetchResults = realm.objects(CategoryModel)
        self.categories = Array(fetchResults)
        
        if categories.count == 0 {
        try! realm.write {
            for category in Categories.allValues {
                let newCategory = CategoryModel()
                newCategory.name = category
                realm.add(newCategory)
            }
            
        }
    }
    }

//    func populateDefaultCategories() {
//        
//        if categories.count == 0 { // 1
//            
//            try! realm.write() { // 2
//                
//                let defaultCategories = ["Birds", "Mammals", "Flora", "Reptiles", "Arachnids" ] // 3
//                
//                for category in defaultCategories { // 4
//                    let newCategory = CategoryModel()
//                    newCategory.name = category
//                    self.realm.add(newCategory)
//                }
//            }
//            
//            categories = realm.objects(CategoryModel) // 5
//        }
//    }
    
    
    
    
    
    
    
}
