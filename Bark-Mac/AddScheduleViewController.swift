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
    
    private var repeatButtons: [NSButton] = []
    private var repeatList: [ScheduleRepeat] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Schedule"
        setupView()
    }
    
    private func getButtons() {
        repeatButtonList1.subviews.forEach {
            if let btn = ($0 as? NSButton) {
                repeatButtons.append(btn)
            }
        }
        repeatButtonList2.subviews.forEach {
            if let btn = ($0 as? NSButton) {
                repeatButtons.append(btn)
            }
        }
    }
    
    private func setupView() {
        getButtons()
        guard let schedule = schedule else { return }
        nameField.stringValue = schedule.name
        dateField.stringValue = schedule.time
        schemeField.stringValue = schedule.scheme
        repeatButton.selectItem(at: schedule.repeatType.rawValue)
        schedule.repeatDay.forEach { obj in
            if let idx = repeatButtons.firstIndex(where: { $0.tag == obj.rawValue }) {
                repeatButtons[idx].isHighlighted = true
            }
        }
    }
    
    private func addSchedule() {
        let id: String
        if let schedule = schedule {
            id = schedule.id
        } else {
            id = UUID().uuidString
        }
        let repeatType = ScheduleRepeatType(rawValue: repeatButton.indexOfSelectedItem) ?? .never
        let schedule = ScheduleModel(id: id, name: nameField.stringValue, time: dateField.stringValue, scheme: schemeField.stringValue, repeatType: repeatType, repeatDay: repeatList, user: [])
        ScheduleService.shared.addSchedule(schedule)
        dismiss(self)
    }
    
}

// MARK: - Actions
extension AddScheduleViewController {
    
    @IBAction func addButtonTapped(_ sender: NSButton) {
        addSchedule()
    }
    
    @IBAction func removeButtonTapped(_ sender: NSButton) {
        guard let id = schedule?.id else { return }
        ScheduleService.shared.removeSchedule(id)
        dismiss(self)
    }
    
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
