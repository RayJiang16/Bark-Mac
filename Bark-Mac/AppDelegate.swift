//
//  AppDelegate.swift
//  Bark-Mac
//
//  Created by 蒋惠 on 2021/2/3.
//

import Cocoa
import SnapKit

@main
class AppDelegate: NSObject, NSApplicationDelegate {
    
    private lazy var statusItem: NSStatusItem = {
        let view = NSStatusBar.system.statusItem(withLength: 25)
        view.button?.action = #selector(popoverButtonTapped(_:))
        return view
    }()
    
    private lazy var popover: NSPopover = {
        let view = NSPopover()
        view.behavior = .transient
        view.appearance = NSAppearance(named: .vibrantLight)
        view.contentViewController = PopViewController()
        return view
    }()
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        statusItem.button?.image = NSImage(named: "StatusIcon")
        
        NSEvent.addGlobalMonitorForEvents(matching: .leftMouseDown) { [weak self] (event) in
            if self?.popover.isShown ?? false {
                self?.popover.close()
            }
        }
        
        ScheduleService().start()
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    @objc private func popoverButtonTapped(_ sender: NSStatusBarButton) {
        popover.show(relativeTo: sender.bounds, of: sender, preferredEdge: NSRectEdge.maxY)
    }
}
