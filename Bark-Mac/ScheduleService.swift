//
//  ScheduleService.swift
//  Bark-Mac
//
//  Created by 蒋惠 on 2021/2/4.
//

import Foundation

final class ScheduleService {
    
    private var list: [ScheduleModel] = []
    private var day: String = ""
    
    init() {
        loadSchedule()
    }
    
    func start() {
        Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(run(_:)), userInfo: nil, repeats: true)
    }
    
    func loadSchedule() {
        guard let url = Bundle.main.url(forResource: "Schedule", withExtension: "json") else { return }
        do {
            let data = try Data(contentsOf: url)
            let list = try JSONDecoder().decode([ScheduleModel].self, from: data)
            self.list = filterTodayTask(list)
        } catch {
            print(error)
        }
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
        }
    }
    
    // MARK: - Helper function
    
    private func filterTodayTask(_ list: [ScheduleModel]) -> [ScheduleModel] {
        let today = getWeekday()
        return list.filter {
            switch $0.repeatType {
            case .never, .everyday:
                return true
            case .custom:
                if let repeatDay = $0.repeat?.rawValue {
                    return today == repeatDay
                }
                return false
            }
        }
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
