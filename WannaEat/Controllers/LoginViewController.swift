//
//  LoginViewController.swift
//  WannaEat
//
//  Created by Apple on 09/03/2019.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import FirebaseAuth

class LoginViewController: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passField: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var segmentControl: UISegmentedControl!
    
    @IBAction func buttonPushed(_ sender: Any) {
        if loginField.text != "" && passField.text != ""{
            if segmentControl.selectedSegmentIndex == 0{
                Auth.auth().signIn(withEmail: loginField.text!, password: passField.text!, completion: {(user, error) in
                    if user != nil{
                        //Sign in successful
                        self.performSegue(withIdentifier: "segue", sender: self)
                    }else{
                        if let myError = error?.localizedDescription{
                            print(myError)
                        }else{
                            print("Error")
                        }
                    }
                })
            }else{
                Auth.auth().createUser(withEmail: loginField.text!, password: passField.text!, completion: {(user,error) in
                    if user != nil {
                        
                    }else{
                        if let myError = error?.localizedDescription{
                            print(myError)
                        }else{
                            print("Error")
                        }
                    }
                })
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if touches.first != nil{
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
