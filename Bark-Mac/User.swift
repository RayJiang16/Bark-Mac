//
//  User.swift
//  Bark-Mac
//
//  Created by 蒋惠 on 2021/2/4.
//

import Foundation

struct User: Codable, Equatable {
    
    static let scheduleList: [String] = [""]
    static let sendList: [String] = [""]
    
    let id: String
    let name: String
    let token: String
}
