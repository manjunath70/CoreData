//
//  VC2.swift
//  CoreDataTest
//
//  Created by manjunath on 24/05/22.
//

import UIKit
import CoreData

class DescVC: UIViewController {

    @IBOutlet weak var saveBtn: UIButton!
    @IBOutlet weak var nameTxtField: UITextField!
    @IBOutlet weak var ageTxtField: UITextField!
    var name:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if name == nil
        {
            saveBtn.setTitle("Save", for: .normal)
        }else
        {
            nameTxtField.text = name!
            saveBtn.setTitle("Update", for: .normal)
        }
        nameTxtField.becomeFirstResponder()
    }
    
    @IBAction func saveActionc(_ sender: Any) {
        if nameTxtField.text!.isEmpty
        {
            print("please enter name")
        }else
        {
            
            if name == nil
            {
                save(str:nameTxtField.text!)
            }else
            {
                
                update(compareName:name!,updateName:nameTxtField.text!)
            }
        }
        
    }
    
    func update(compareName:String,updateName:String)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return
        }
        
        let viewContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest:NSFetchRequest<NSFetchRequestResult> = NSFetchRequest.init(entityName: "Person")
        fetchRequest.predicate = NSPredicate(format: "name = %@", compareName)
        
        do{
            let test = try viewContext.fetch(fetchRequest)
            
            let object = test[0] as! NSManagedObject
            object.setValue(updateName, forKey: "name")
            
            do{
                try viewContext.save()
                navigationController?.popViewController(animated: true)
            }
            catch
            {
                print("error")
            }
        }
        catch
        {
            print("error")
        }
    }
    
    func save(str:String)
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return
        }
        let context = appDelegate.persistentContainer.viewContext
        
        let userEnti = NSEntityDescription.entity(forEntityName: "Person", in: context)
        let user = NSManagedObject(entity: userEnti!, insertInto: context)
        user.setValue(str, forKey: "name")
        do{
            try context.save()
            navigationController?.popViewController(animated: true)
        }
        catch
        {
            print("error")
        }
        
    }

}
