//
//  ScheduleListViewController.swift
//  Bark-Mac
//
//  Created by Ray on 2021/6/24.
//

import Cocoa

class ScheduleListViewController: NSViewController {

    @IBOutlet weak var tableView: NSTableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Schedule List"
    }
    
    @IBAction func addButtonTapped(_ sender: NSButton) {
        let controller = AddScheduleViewController(nibName: "AddScheduleViewController", bundle: nil)
        presentAsModalWindow(controller)
    }
}

// MARK: - NSTableViewDataSource
extension ScheduleListViewController: NSTableViewDataSource {
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return ScheduleService.shared.list.count
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        let schedule = ScheduleService.shared.list[row]
        switch tableColumn?.title {
        case "标题":
            return schedule.name
        case "时间":
            return schedule.time
        case "Scheme":
            return schedule.scheme
        case "重复":
            return schedule.repeatStr
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: NSTableView, willDisplayCell cell: Any, for tableColumn: NSTableColumn?, row: Int) {
        (cell as? NSTextFieldCell)?.alignment = .left
        
    }
}

// MARK: - NSTableViewDelegate
extension ScheduleListViewController: NSTableViewDelegate {
    
    
}
