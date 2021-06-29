//
//  AddScheduleViewController.swift
//  Bark-Mac
//
//  Created by Ray on 2021/6/24.
//

import Cocoa

class AddScheduleViewController: NSViewController {

    var schedule: ScheduleModel?
    
    @IBOutlet weak var nameField: NSTextField!
    @IBOutlet weak var dateField: NSTextField!
    @IBOutlet weak var schemeField: NSTextField!
    @IBOutlet weak var repeatButton: NSPopUpButton!
    
    @IBOutlet weak var repeatButtonList1: NSStackView!
    @IBOutlet weak var repeatButtonList2: NSStackView!
    
    private var repeatList: [ScheduleRepeat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Schedule"
    }
    
    private func add() {
        let id: String
        if let schedule = schedule {
            id = schedule.id
        } else {
            id = UUID().uuidString
        }
        let obj = ScheduleModel(id: id, name: nameField.stringValue, time: dateField.stringValue, scheme: schemeField.stringValue, repeatType: .never, repeat: [], user: [])
    }
}

// MARK: - Actions
extension AddScheduleViewController {
    
    @IBAction func repeatTypeButtonTapped(_ sender: NSPopUpButton) {
        let hiddenRepeatButtons = sender.indexOfSelectedItem != 2
        repeatButtonList1.isHidden = hiddenRepeatButtons
        repeatButtonList2.isHidden = hiddenRepeatButtons
    }
    
    @IBAction func repeatButtonTapped(_ sender: NSButton) {
        guard let type = ScheduleRepeat(rawValue: sender.tag) else {
            sender.isHighlighted = false
            return
        }
        if sender.isHighlighted {
            repeatList.append(type)
        } else {
            if let idx = repeatList.firstIndex(of: type) {
                repeatList.remove(at: idx)
            }
        }
    }
}
