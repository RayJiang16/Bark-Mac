//
//  PopViewController.swift
//  Bark-Mac
//
//  Created by 蒋惠 on 2021/2/3.
//

import Cocoa

class PopViewController: NSViewController {

    @IBOutlet weak var saveButton: NSButton!
    @IBOutlet weak var copyButton: NSButton!
    @IBOutlet weak var textField: NSTextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func exitButtonTapped(_ sender: NSButton) {
        NSApplication.shared.terminate(self)
    }
    
    @IBAction func settingsButtonTapped(_ sender: NSButton) {
        let controller = ScheduleListViewController(nibName: "ScheduleListViewController", bundle: nil)
        presentAsModalWindow(controller)
    }
    
    @IBAction func sendButtonTapped(_ sender: NSButton) {
        let text = textField.stringValue
        if text.isEmpty {
            let str = NSPasteboard.general.string(forType: .string) ?? ""
            send(text: str)
        } else {
            textField.stringValue = ""
            send(text: text)
        }
    }
    
    func send(text: String) {
        if text.isEmpty { return }
        User.sendList.forEach {
            let url = RequestService.makeUrl(token: $0.token,
                                             title: text,
                                             save: saveButton.state == .on,
                                             copy: copyButton.state == .on)
            RequestService.sendRequest(urlStr: url)
        }
    }
}
