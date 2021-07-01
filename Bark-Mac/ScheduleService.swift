//
//  ScheduleService.swift
//  Bark-Mac
//
//  Created by 蒋惠 on 2021/2/4.
//

import Foundation

final class ScheduleService {
    
    static let shared = ScheduleService()
    
    private let fileUrl: URL
    private(set) var list: [ScheduleModel] = []
    private var day: String = ""
    
    private init() {
        let lib = NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first!
        fileUrl = URL(fileURLWithPath: "\(lib)/Schedule.json")
        loadSchedule()
    }
    
    func start() {
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(run(_:)), userInfo: nil, repeats: true)
    }
    
    @objc func run(_ timer: Timer) {
        let today = getDate(with: "dd")
        if today != day {
            loadSchedule()
            day = today
        }
        
        getTask().forEach {
            doTask(schedule: $0)
            removeTask(schedule: $0)
        }
    }
    
    func getTask() -> [ScheduleModel] {
        let now = getDate(with: "HH:mm")
        return list.filter { $0.time == now }
    }
    
    func doTask(schedule: ScheduleModel) {
        User.scheduleList.forEach {
            let url = RequestService.makeUrl(token: $0, title: schedule.name, save: false, copy: false, url: schedule.scheme)
            RequestService.sendRequest(urlStr: url)
        }
    }
    
    func removeTask(schedule: ScheduleModel) {
        if let idx = (list.firstIndex { $0 == schedule }) {
            list.remove(at: idx)
            if schedule.repeatType == .never {
                removeSchedule(schedule.id)
            }
        }
    }
    
}

// MARK: - Save & Load
extension ScheduleService {
    
    func loadSchedule() {
        do {
            let data = try Data(contentsOf: fileUrl)
            let list = try JSONDecoder().decode([ScheduleModel].self, from: data)
            self.list = sortTask(filterTodayTask(list))
        } catch {
            print("loadSchedule failed: \(error)")
        }
    }
    
    func saveSchedule() {
        do {
            let data = try JSONEncoder().encode(list)
            try data.write(to: fileUrl)
        } catch {
            print("saveSchedule failed: \(error)")
        }
    }
    
    func addSchedule(_ schedule: ScheduleModel) {
        if let idx = list.firstIndex(where: { $0.id == schedule.id }) {
            list.remove(at: idx)
        }
        list.append(schedule)
        list = sortTask(filterTodayTask(list))
        saveSchedule()
    }
    
    func removeSchedule(_ id: String) {
        if let idx = list.firstIndex(where: { $0.id == id }) {
            list.remove(at: idx)
            saveSchedule()
        }
    }
}

// MARK: - Helper function
extension ScheduleService {
    
    private func filterTodayTask(_ list: [ScheduleModel]) -> [ScheduleModel] {
        return list.filter {
            switch $0.repeatType {
            case .never, .everyday:
                return true
            case .custom:
                let type = ScheduleRepeat(rawValue: getWeekday()) ?? .unknown
                return $0.repeatDay.contains(type)
            }
        }
    }
    
    private func sortTask(_ list: [ScheduleModel]) -> [ScheduleModel] {
        return list.sorted { $0.time < $1.time }
    }
    
    private func getDate(with format: String) -> String {
        let df = DateFormatter()
        df.dateFormat = format
        return df.string(from: Date())
    }
    
    private func getWeekday() -> Int {
        let day = Calendar.current.component(.weekday, from: Date())
        if day == 0 {
            return 7
        } else {
            return day - 1
        }
    }
}
