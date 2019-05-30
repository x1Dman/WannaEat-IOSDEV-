//
//  InfoViewController.swift
//  WannaEat
//
//  Created by Apple on 22/03/2019.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit

class InfoViewController: UIViewController {
    
    func letsMakeTextGreatAgain(){
        var t:String = ""
        var h:Int = 1
        for key in receipt!{
            if h == 1 {
                t.append(String(h))
                t.append(") ")
                t.append(String(key))
                h += 1
            }else{
                if key == ","{
                    t.append(String("\n"))
                    t.append(String(h))
                    t.append(")")
                    h += 1
                }else{
                    t += String(key)
                }
            }
        }
        receipt! = t
        numLines = h
    }
    
    @IBOutlet weak var recipePic: UIImageView!
    @IBOutlet weak var infoLabel: UILabel!
    @IBOutlet weak var optionControl: UISegmentedControl!
    
    var urlPhoto: String? = ""
    var receipt: String? = ""
    var href: String? = ""
    var numLines: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        letsMakeTextGreatAgain()
        if urlPhoto! != ""{
            let url = URL(string:  urlPhoto!)
            let data = try? Data(contentsOf: url!)
            recipePic.image = UIImage(data : data!)
        }else{
            recipePic.image = UIImage(named: "rest")
        }
        if receipt! != ""{
            infoLabel.numberOfLines = numLines
            infoLabel.text = receipt!
        }else{
            infoLabel.text = "There is nothing to talk about."
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destinationVC: WebViewController = segue.destination as! WebViewController
        destinationVC.href = self.href!
    }

}
