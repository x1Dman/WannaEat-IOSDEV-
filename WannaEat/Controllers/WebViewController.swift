//
//  WebViewController.swift
//  WannaEat
//
//  Created by Apple on 23/03/2018.
//  Copyright © 2018 Apple. All rights reserved.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    
    @IBOutlet weak var webView: WKWebView!
    var href: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let url:URL = URL(string: href)!
        let urlRequest: URLRequest = URLRequest(url: url)
        webView.load(urlRequest)
        
        
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
