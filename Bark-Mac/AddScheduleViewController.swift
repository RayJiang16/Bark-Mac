//
//  AddScheduleViewController.swift
//  Bark-Mac
//
//  Created by Ray on 2021/6/24.
//

import Cocoa

class AddScheduleViewController: NSViewController {

    @IBOutlet weak var nameField: NSTextField!
    @IBOutlet weak var dateField: NSTextField!
    @IBOutlet weak var schemeField: NSTextField!
    @IBOutlet weak var repeatButton: NSPopUpButton!
    
    @IBOutlet weak var repeatButtonList1: NSStackView!
    @IBOutlet weak var repeatButtonList2: NSStackView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Add Schedule"
    }
    
    @IBAction func repeatTypeButtonTapped(_ sender: NSPopUpButton) {
        print(1)
    }
    
    @IBAction func repeatButtonTapped(_ sender: NSButton) {
        print(2)
    }
}
