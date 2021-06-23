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
    case Monday = 1
    case Tuesday
    case Wednesday
    case Thursday
    case Friday
    case Saturday
    case Sunday
}

struct ScheduleModel: Codable, Equatable {
    let name: String
    let time: String
    let scheme: String
    let repeatType: ScheduleRepeatType
    let `repeat`: ScheduleRepeat?
}
