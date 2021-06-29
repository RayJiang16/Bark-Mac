//
//  ScheduleModel.swift
//  Bark-Mac
//
//  Created by 蒋惠 on 2021/2/4.
//

import Foundation

enum ScheduleRepeatType: Int, Codable {
    case never = 0
    case everyday
    case custom
}

enum ScheduleRepeat: Int, Codable {
    case unknown = 0
    case monday = 1
    case tuesday
    case wednesday
    case thursday
    case friday
    case saturday
    case sunday
}

struct ScheduleModel: Codable, Equatable {
    let id: String
    let name: String
    let time: String
    let scheme: String
    let repeatType: ScheduleRepeatType
    let `repeat`: [ScheduleRepeat]
    let user: [User]
}
