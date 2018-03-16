//
//  TableViewController.swift
//  WannaEat
//
//  Created by Apple on 12/03/2018.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Foundation


class TableViewController: UITableViewController {

    @IBAction func plusPushed(_ sender: Any) {
        let alert = UIAlertController(title: "Add element to the table", message: nil, preferredStyle: UIAlertControllerStyle.alert)
        alert.addTextField(configurationHandler: { (UITextField) in UITextField.placeholder = "Product name"})
        let alertActionAdd = UIAlertAction(title: "Add", style: UIAlertActionStyle.default, handler: {(UIAlertAction) in
            if alert.textFields?.first?.text != "" {
                self.dataArr.append((alert.textFields?.first?.text)!)
                self.tableView.reloadData()
                self.saveData()
            }
            print("push Add")
        })
        
        let alertActionCancel = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel, handler: {(UIAlertAction) in print("push Cancel")})
        
        alert.addAction(alertActionAdd)
        alert.addAction(alertActionCancel)
        
        self.present(alert, animated: true, completion: nil)
    }
    @IBAction func editPushed(_ sender: Any) {
        tableView.setEditing(!tableView.isEditing, animated: true)
    }
    @IBAction func findPushed(_ sender: Any) {
        //saveData()
//        let parameters = ["q": "egg,potato", "app_id":"","app_key": ""] as [String : Any]
//        Alamofire.request("https://api.edamam.com/search",parameters: parameters).responseJSON {
//            response in debugPrint(response)
//            if let json = response.result.value{
//                print("JSON: \(json)")
//            }
//        }
    }
    
    var dataArr: [String] = []
    var textForArr = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        self.refreshControl = nil
    }

//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }

    // MARK: - Table view data source
    func saveData(){
        let defaults = UserDefaults.standard
        defaults.set(dataArr, forKey: "dataArr")
        
    }
    func loadData(){
        let defaults = UserDefaults.standard
        dataArr = defaults.object(forKey: "dataArr") as? [String] ?? [String]()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return dataArr.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "A", for: indexPath)
        let currentText = dataArr[indexPath.row]
        cell.textLabel?.text = currentText
        //cell.imageView?.image = UIImage(named: currentText)
        return cell
    }

     //Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
         //Return false if you do not want the specified item to be editable.
        return true
    }

    
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            dataArr.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }

    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
        let from = dataArr[fromIndexPath.row]
        dataArr.remove(at: fromIndexPath.row)
        dataArr.insert(from, at: to.row)
        
        saveData()
        tableView.reloadData()
    }

    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
