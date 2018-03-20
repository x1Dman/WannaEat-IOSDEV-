//  TableViewController.swift
//  WannaEat
//
//  Created by Apple on 12/03/2018.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import Foundation

struct NewPuppyParse : Decodable{
    let title: String
    let version: Double
    let href: String
    let results: [PuppyParse]
}

struct PuppyParse: Decodable {
    let href: String?
    let ingredients: String?
    let thumbnail: String?
    let title: String?
    
    init(json: [String: Any]){
        href = json["href"] as? String ?? ""
        ingredients = json["ingredients"] as? String  ?? ""
        thumbnail = json["thumbnail"] as? String  ?? ""
        title = json["title"] as? String  ?? ""
    }
}


func miniParse(str: String) -> String{
    var newStr = str
    return newStr.trim()
}


class TableViewController: UITableViewController {
    var parse: [PuppyParse] = []
    var dataArr: [String] = []
    var textForArr = ""
    
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
        self.refreshControl = nil
    }

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

    func letsConnect() -> [PuppyParse]{
        var str = "i="
        for i in 0..<dataArr.count {
            if i != dataArr.count - 1 {
                str += dataArr[i] + ","
            }else{
                str += dataArr[i]
            }
        }
        let jsonUrlString = "http://www.recipepuppy.com/api/?" + str
        print(jsonUrlString)
        guard let url = URL(string: jsonUrlString) else { return [] }
        
        URLSession.shared.dataTask(with: url){ (data,response,err) in
            guard let data = data else {return}
            //print(dataAsString!)
            do{
                let courses = try JSONDecoder().decode(NewPuppyParse.self, from: data)
                self.parse = courses.results
            }catch let jsonErr{
                print(jsonErr)
            }
            }.resume()
        return self.parse
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationTVC: ScoreTableViewController = segue.destination as! ScoreTableViewController
        print(letsConnect())
        destinationTVC.abc = letsConnect()
    }
}
