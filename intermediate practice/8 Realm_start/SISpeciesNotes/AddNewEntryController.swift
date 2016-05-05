//
//  AddNewEntryController.swift
//  SISpeciesNotes
//
//  Created by 星夜暮晨 on 2015-04-29.
//  Copyright (c) 2015 益行人. All rights reserved.
//

import UIKit
import RealmSwift

class AddNewEntryController: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    let realm = try? Realm()
    // MARK: - 属性
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var categoryTextField: UITextField!
    @IBOutlet weak var descriptionTextView: UITextView!
    var selectedCategory: CategoryModel!
    var species: SpeciesModel!
    
    
    /// 当前所选中的标记信息
    var selectedAnnotation: SpeciesAnnotation!
    
    // MARK: - 控制器生命周期
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - UITextFieldDelegate
    
    func textFieldDidBeginEditing(textField: UITextField) {
        self.performSegueWithIdentifier("Categories", sender: self)
    }
    
    // MARK: - 按钮动作
    
    @IBAction func unwindFromCategories(segue: UIStoryboardSegue) {
        let categoriesController = segue.sourceViewController as! CategoriesTableViewController
        selectedCategory = categoriesController.selectedCategory
        categoryTextField.text = selectedCategory.name
        
    }
    
    // MARK: - 文本栏输入验证
    
    private func validateFields() -> Bool {
        if nameTextField.text!.isEmpty || descriptionTextView.text.isEmpty || selectedCategory == nil  {
            let alertController = UIAlertController(title: "验证错误", message: "所有的文本栏都不能为空", preferredStyle: .Alert)
            let alertAction = UIAlertAction(title: "确认", style: .Destructive, handler: {
                (alert: UIAlertAction) -> Void in
                alertController.dismissViewControllerAnimated(true, completion: nil)
            })
            alertController.addAction(alertAction)
            self.presentViewController(alertController, animated: true, completion: nil)
            
            return false
        }else {
            return true
        }
    }
    
    
    private func addNewSpecies() {
        guard let realm = realm else { return }   // 1
        try! realm.write {  // 2
            let newSpecies = SpeciesModel()  // 3
            // 4
            newSpecies.name = self.nameTextField.text!
            newSpecies.category = self.selectedCategory
            newSpecies.speciesDescription = self.descriptionTextView.text
            newSpecies.latitude = self.selectedAnnotation.coordinate.latitude
            newSpecies.longitude = self.selectedAnnotation.coordinate.longitude
            self.species = newSpecies
            realm.add(newSpecies)  // 5
        }
    }
    
    
    
    override func shouldPerformSegueWithIdentifier(identifier: String, sender: AnyObject?) -> Bool {
        if validateFields() {
            if species == nil { addNewSpecies() }
            return true
        } else {
            return false
        }
    }
    
    
    
    
    
    
    
    
}
