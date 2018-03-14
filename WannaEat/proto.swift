//
//  proto.swift
//  WannaEat
//
//  Created by Apple on 13/03/2018.
//  Copyright © 2018 Apple. All rights reserved.
//

import Foundation

public struct Request {
    var Command: String?
}

public struct Response {
    var Status: String?
    
    var data : Data?
}

