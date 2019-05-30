//
//  AccViewController.swift
//  WannaEat
//
//  Created by Apple on 16/03/2019.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import FirebaseAuth

class AccViewController: UIViewController {

    @IBAction func logOut(_ sender: Any) {
        try! Auth.auth().signOut()
        performSegue(withIdentifier: "LogO", sender: self)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
