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
	@IBOutlet weak var actionSpinner: UIActivityIndicatorView!
	
	@IBAction func buttonPushed(_ sender: Any) {
		if let login = loginField.text, let pass = passField.text, login != "", pass != "" {
			if segmentControl.selectedSegmentIndex == 0 {
				// login
				actionSpinner.isHidden = false
				actionSpinner.startAnimating()
				loginAuth(with: login, with: pass) { data in
					DispatchQueue.main.async {
						switch data {
							case .success(let credits):
								self.actionSpinner.stopAnimating()
								self.actionSpinner.isHidden = true
								Credentials.instance.token = credits.token
								self.performSegue(withIdentifier: "segue", sender: self)
							case .failure(let error):
								self.showAlert("Login failed")
								print(error)
						}
					}
				}
			} else {
				// registation
				actionSpinner.isHidden = false
				actionSpinner.startAnimating()
				registration(with: login, with: pass) { data in
					DispatchQueue.main.async {
						switch data {
							case .success(let credits):
								self.actionSpinner.stopAnimating()
								self.actionSpinner.isHidden = true
								Credentials.instance.name = credits.username
								Credentials.instance.email = credits.email
								self.showAlert("OK")
							case .failure(let error):
								self.showAlert("Registration failed")
								self.actionSpinner.stopAnimating()
								self.actionSpinner.isHidden = true
								print(error)
						}
					}
				}
			}
		}
	}
	private enum AuthError: Error {
		case badData
	}
	override func viewDidLoad() {
		super.viewDidLoad()
		actionSpinner.isHidden = true
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
	
	private func loginAuth(with login: String, with password: String, completion: @escaping(Result<Login, AuthError>)->()) {
		let parameters = [
			[
				"key": "username",
				"value": login,
				"type": "text"
			],
			[
				"key": "password",
				"value": password,
				"type": "text"
			]] as [[String : Any]]
		
		let boundary = "Boundary-\(UUID().uuidString)"
		var body = ""
		for param in parameters {
			if param["disabled"] == nil {
				let paramName = param["key"]!
				body += "--\(boundary)\r\n"
				body += "Content-Disposition:form-data; name=\"\(paramName)\""
				let paramType = param["type"] as! String
				if paramType == "text" {
					let paramValue = param["value"] as! String
					body += "\r\n\r\n\(paramValue)\r\n"
				} else {
					let paramSrc = param["src"] as! String
					guard let fileData = try? NSData(contentsOfFile:paramSrc, options:[]) as Data else {
						return completion(.failure(.badData))
					}
					let fileContent = String(data: fileData, encoding: .utf8)!
					body += "; filename=\"\(paramSrc)\"\r\n"
						+ "Content-Type: \"content-type header\"\r\n\r\n\(fileContent)\r\n"
				}
			}
		}
		body += "--\(boundary)--\r\n";
		let postData = body.data(using: .utf8)
		
		var request = URLRequest(url: URL(string: "http://127.0.0.1:8000/login/")!,timeoutInterval: Double.infinity)
		request.addValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
		
		request.httpMethod = "POST"
		request.httpBody = postData
		
		let task = URLSession.shared.dataTask(with: request) { data, response, error in
			guard let data = data else {
				print(String(describing: error))
				return
			}
			guard let loginCred = try? JSONDecoder().decode(Login.self, from: data) else {
				return completion(.failure(.badData))
			}
			return completion(.success(loginCred))
		}.resume()
	}
	
	private func registration(with login: String, with password: String, completion: @escaping(Result<Credits, AuthError>)->()) {
		let parameters = [
			[
				"key": "username",
				"value": login,
				"type": "text"
			],
			[
				"key": "email",
				"value": login,
				"type": "text"
			],
			[
				"key": "password",
				"value": password,
				"type": "text"
			]
			] as [[String : Any]]
		let jsonData = "username=\(login)&email=\(login)@mail.ru&password=\(password)"
		var request = URLRequest(url: URL(string: "http://127.0.0.1:8000/users/")!,timeoutInterval: Double.infinity)
		request.httpMethod = "POST"

		request.httpBody = jsonData.data(using: .utf8)
		URLSession.shared.dataTask(with: request) { data, response, error in
			guard let data = data else {
				print(String(describing: error))
				return completion(.failure(.badData))
			}
			print("HERE")
			print(String(decoding: data, as: UTF8.self))
			guard let welcome = try? JSONDecoder().decode(Credits.self, from: data) else {
				return completion(.failure(.badData))
			}
			completion(.success(welcome))
		}.resume()
	}
	
	private func showAlert(_ text: String = "") {
		let alert = UIAlertController(title: text, message: nil, preferredStyle: UIAlertControllerStyle.alert)
		let alertActionAdd = UIAlertAction(title: "OK", style: UIAlertActionStyle.default)
		alert.addAction(alertActionAdd)
		self.present(alert, animated: true)
	}
}
