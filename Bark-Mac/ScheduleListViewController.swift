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
        return 10
    }
    
    func tableView(_ tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return 25
    }
    
    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        var rowStr = ""
        if tableColumn?.title == "标题" {
            rowStr += "第1列,"
        }
        rowStr += ("aaa")
        return rowStr
    }
    
    func tableView(_ tableView: NSTableView, willDisplayCell cell: Any, for tableColumn: NSTableColumn?, row: Int) {
        (cell as? NSTextFieldCell)?.alignment = .left
        
    }
}

// MARK: - NSTableViewDelegate
extension ScheduleListViewController: NSTableViewDelegate {
    
    
}
