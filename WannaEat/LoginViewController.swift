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
        var json: Any?
        let encodedData = try? JSONEncoder().encode("Hi")
        if let data = encodedData {
            client.send(data: data)
            json = try? JSONSerialization.jsonObject(with: data, options: .allowFragments)
            if let json = json {
                print("KEK")
            }
        }
//        client.send(string: "Hi")
//        loginLabel.delegate = self
//        passLabel.delegate = self
        loginButton.isHidden = true
        // Do any additional setup after loading the view.
    }
    func textFieldDidBeginEditing(_ textField: UITextField) {
        loginButton.isHidden = false
    }
    func textFieldDidEndEditing(_ textField: UITextField) {
        loginButton.isHidden = true
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
