//
//  File.swift
//  WannaEat
//
//  Created by 18579118 on 24.09.2020.
//  Copyright © 2020 Apple. All rights reserved.
//

import Foundation

class Credentials {
	static let instance = Credentials()

	var email: String = ""
	var name: String = ""
	var token: String = ""

	private init() {}
}
