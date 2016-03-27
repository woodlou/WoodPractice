//
//  AnimalTableViewController.swift
//  IndexedTableDemo
//
//  Created by Simon Ng on 17/11/14.
//  Copyright (c) 2014 AppCoda. All rights reserved.
//

import UIKit

class AnimalTableViewController: UITableViewController {
    
    let animals = ["Bear", "Black Swan", "Buffalo", "Camel", "Cockatoo", "Dog", "Donkey", "Emu", "Giraffe", "Greater Rhea", "Hippopotamus", "Horse", "Koala", "Lion", "Llama", "Manatus", "Meerkat", "Panda", "Peacock", "Pig", "Platypus", "Polar Bear", "Rhinoceros", "Seagull", "Tasmania Devil", "Whale", "Whale Shark", "Wombat"]
    
    let animalIndexTitles = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"]
    
    
    
    var animalsDict = [String:[String]]()
    var animalSectionTitles = [String]()
    func createAnimalDict(){
        for animal in animals{
            //提取第一个字母做key
            let animalKey = animal.substringToIndex(animal.startIndex.advancedBy(1))
            if var animalValues = animalsDict[animalKey]{
                animalValues.append(animal)
                animalsDict[animalKey] = animalValues
            }else {
              animalsDict[animalKey] = [animal]
            }
        }
        animalSectionTitles = [String](animalsDict.keys)
        animalSectionTitles = animalSectionTitles.sort({ $0 < $1 })
        
        
    }
    
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createAnimalDict()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return animalSectionTitles.count
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return animalSectionTitles[section]
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // Return the number of rows in the section.
        let animalKey = animalSectionTitles[section]
        if let animalValues = animalsDict[animalKey]{
            return animalValues.count
        }
        return 0
    }

    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) 

        // Configure the cell...
        
        let animalKey = animalSectionTitles[indexPath.section]
        if let animalVlaues = animalsDict[animalKey]{
            
        cell.textLabel?.text = animalVlaues[indexPath.row]
        
        
        // Convert the animal name to lower case and 
        // then replace all occurences of a space with an underscore
        let imageFilename = animalVlaues[indexPath.row].lowercaseString.stringByReplacingOccurrencesOfString(" ", withString: "_", options: [], range: nil)
        cell.imageView?.image = UIImage(named: imageFilename)
        
        }
        return cell
    }
    
    override func sectionIndexTitlesForTableView(tableView: UITableView) -> [String]? {
        return animalIndexTitles
    }
    
    override func tableView(tableView: UITableView, sectionForSectionIndexTitle title: String, atIndex index: Int) -> Int {
        guard let index = animalSectionTitles.indexOf(title) else{
            return -1
        }
        return index
    }

    
    
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let headerView = view as! UITableViewHeaderFooterView
        headerView.textLabel?.textColor = UIColor.blueColor()
        headerView.textLabel?.font = UIFont(name: "Avenir", size: 25.0)
    }
    
    
    
    
    
}
