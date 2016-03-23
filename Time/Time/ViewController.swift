//
//  ViewController.swift
//  Time
//
//  Created by Abdurrahman on 3/21/16.
//  Copyright © 2016 CertifiedWebDevelopers. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

	@IBOutlet weak var startStopButton: UIButton!
	@IBOutlet weak var lapResetButton: UIButton!
	@IBOutlet weak var stopwatchLabel: UILabel!
	@IBOutlet weak var lapsTableView: UITableView!
	
	var laps: [String] = []
	
	var timer = NSTimer()
	var minutes : Int = 0
	var seconds : Int = 0
	var fractions : Int = 0
	
	var stopWatchString : String = ""
	var startStopWatch : Bool = true
	var addLap : Bool = false
	
	@IBAction func startStopPressed(sender: AnyObject) {
		if startStopWatch == true {
			
			timer = NSTimer.scheduledTimerWithTimeInterval(0.01, target: self, selector: #selector(updateStopWatch), userInfo: nil, repeats: true)
            NSRunLoop.currentRunLoop().addTimer(timer, forMode: NSRunLoopCommonModes)
			startStopWatch = false
			
			startStopButton.setTitleColor(UIColor(hex: 0xFF5A5A), forState: .Normal)
			startStopButton.setTitle("Stop", forState: .Normal)
			lapResetButton.setTitleColor(UIColor(hex: 0x636363), forState: .Normal)
			lapResetButton.setTitle("Lap", forState: .Normal)

			addLap = true
			
		} else {
			timer.invalidate()
			startStopWatch = true

			startStopButton.setTitleColor(UIColor(hex: 0x00C56C), forState: .Normal)
			startStopButton.setTitle("Start", forState: .Normal)
			lapResetButton.setTitleColor(UIColor(hex: 0x636363), forState: .Normal)
			lapResetButton.setTitle("Reset", forState: .Normal)
			
			addLap = false
		}
	}
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		stopwatchLabel.text = "00:00.00"
		lapsTableView.delegate = self
		lapsTableView.dataSource = self
		
		startStopButton.layer.cornerRadius = startStopButton.frame.size.width / 2
		startStopButton.clipsToBounds = true
		
		lapResetButton.layer.cornerRadius = lapResetButton.frame.size.width / 2
		lapResetButton.clipsToBounds = true
		
	}
	
	override func viewDidAppear(animated: Bool) {
		super.viewDidAppear(animated)
		
		startStopButton.setTitleColor(UIColor(hex: 0x00C56C), forState: .Normal)
		lapResetButton.setTitleColor(UIColor(hex: 0x636363), forState: .Normal)
	}

	@IBAction func lapResetPressed(sender: AnyObject) {
		if addLap == true {
			laps.insert(stopWatchString, atIndex: 0)
			lapsTableView.reloadData()
		} else {

			lapResetButton.setTitle("Lap", forState: .Normal)
			laps.removeAll(keepCapacity: false)
			lapsTableView.reloadData()
			
			fractions = 0
			seconds = 0
			minutes = 0
			
			stopWatchString = "00:00:00"
			stopwatchLabel.text = stopWatchString
		}
	}
	
	func updateStopWatch() {
		fractions += 1
		
		if fractions == 100 {
			seconds += 1
			fractions = 0
		}
		
		if seconds == 60 {
			minutes += 1
			seconds = 0
		}
		
		let fractionsString = fractions > 9 ? "\(fractions)" : "0\(fractions)"
		let secondsString = seconds > 9 ? "\(seconds)" : "0\(seconds)"
		let minutesString = minutes > 9 ? "\(minutes)" : "0\(minutes)"
		
		stopWatchString = "\(minutesString):\(secondsString).\(fractionsString)"
		stopwatchLabel.text = stopWatchString
	}
	
	override func preferredStatusBarStyle() -> UIStatusBarStyle {
		return .LightContent
	}
	
}

extension ViewController : UITableViewDataSource {
	
	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return laps.count
	}
	
	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let cell = UITableViewCell(style: .Value1, reuseIdentifier: "StopwatchCell")
		
		cell.textLabel?.textColor = UIColor(hex: 0x83C3B8)
		cell.textLabel?.text = "Lap \(laps.count-indexPath.row)"
		cell.detailTextLabel?.text = laps[indexPath.row]
		
		return cell
	}
	
}

extension ViewController : UITableViewDelegate {
	
}





