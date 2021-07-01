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
    
    var title: String {
        switch self {
        case .unknown:
            return ""
        case .monday:
            return "周一"
        case .tuesday:
            return "周二"
        case .wednesday:
            return "周三"
        case .thursday:
            return "周四"
        case .friday:
            return "周五"
        case .saturday:
            return "周六"
        case .sunday:
            return "周日"
        }
    }
}

struct ScheduleModel: Codable, Equatable {
    let id: String
    let name: String
    let time: String
    let scheme: String
    let repeatType: ScheduleRepeatType
    let repeatDay: [ScheduleRepeat]
    let user: [User]
    
    var repeatStr: String {
        switch repeatType {
        case .never:
            return "从不"
        case .everyday:
            return "每天"
        case .custom:
            if repeatDay.contains(.saturday) && repeatDay.contains(.sunday) && repeatDay.count == 2 {
                return "周末"
            } else if !repeatDay.contains(.saturday) && !repeatDay.contains(.sunday) && repeatDay.count == 5 {
                return "工作日"
            } else {
                return repeatDay.map{ $0.title }.joined(separator: ", ")
            }
        }
    }
}
