//
//  LoginViewController.swift
//  WannaEat
//
//  Created by Apple on 09/03/2018.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
//import FacebookCore
//import FacebookLogin

class LoginViewController: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var passLabel: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
//        let loginButtonn = LoginButton(readPermissions: [ .publicProfile ])
//        loginButtonn.center = view.center
//        view.addSubview(loginButtonn)
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
//    func textFieldDidBeginEditing(_ textField: UITextField) {
//        if loginLabel.text == "" {
//            loginButton.isHidden = true
//        }else{
//            loginButton.isHidden = false
//        }
//    }
//    func textFieldDidEndEditing(_ textField: UITextField) {
//            loginButton.isHidden = false
//    }
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        logPushed(self)
//        return true
//    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
