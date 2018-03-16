//
//  LoginViewController.swift
//  WannaEat
//
//  Created by Apple on 09/03/2018.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import SwiftSocket

class LoginViewController: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var passLabel: UITextField!
    @IBOutlet weak var loginLabel: UITextField!
    @IBOutlet weak var loginButton: UIButton!
    @IBAction func logPushed(_ sender: Any) {
        if passLabel.text == "" || loginLabel.text == "" {
            return
        }else {
            loginLabel.text = ""
            passLabel.text = ""
            loginLabel.resignFirstResponder()
            passLabel.resignFirstResponder()
        }
    }
    @IBAction func loginDidEnd(_ sender: Any) {
    }
    @IBAction func passDidEnd(_ sender: Any) {
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        let client = TCPClient(address: "127.0.0.1", port: 2002)
        switch client.connect(timeout: 10){
        case .success:
            print("kek")
        case .failure:
            print("sucks")
        }
        loginButton.isHidden = true
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first{
            view.endEditing(true)
        }
        super.touchesBegan(touches, with: event)
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if loginLabel.text == "" {
            loginButton.isHidden = true
        }else{
            loginButton.isHidden = false
        }
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
            loginButton.isHidden = false
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        logPushed(self)
        return true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
