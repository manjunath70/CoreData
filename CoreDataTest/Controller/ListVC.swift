//
//  ViewController.swift
//  CoreDataTest
//
//  Created by manjunath on 23/05/22.
//

import UIKit
import CoreData
import KeychainAccess

class ListVC: UIViewController {
    
    
    
    @IBOutlet weak var tblView: UITableView!
    var name:String?
    var arrStr:[String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tblView.delegate = self
        tblView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        retrieve()
    }
    
    func retrieve()
    {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else
        {
            return
        }
        
        let viewContext = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Person")
        
        do
        {
            let fetch = try viewContext.fetch(fetchRequest)
            arrStr.removeAll()
            for data in fetch as! [NSManagedObject]
            {
                print("\(data.value(forKey: "name") as! String)")
                arrStr.append("\(data.value(forKey: "name") as! String)")
            }
            
            arrStr.reverse()
            
            DispatchQueue.main.async {
                self.tblView.reloadData()
            }
        }
        catch
        {
            print("error")
        }
        
    }
    
    
    
    
    
    @IBAction func addAction(_ sender: Any) {
        name = nil
        performSegue(withIdentifier: "toVC2", sender: nil)
    }
}
extension ListVC:UITableViewDataSource
{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tempCell = tblView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TblCell
        
        tempCell.lbl.text = arrStr[indexPath.item]
        return tempCell
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrStr.count
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
}
extension ListVC:UITableViewDelegate
{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        name = arrStr[indexPath.item]
        performSegue(withIdentifier: "toVC2", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toVC2"
        {
            let vc = segue.destination as? DescVC
            vc!.name = name
        }
    }
  
}
