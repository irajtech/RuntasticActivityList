//
//  ViewController.swift
//  RuntasticActivityList
//
//  Created by tcs on 5/2/16.
//  Copyright © 2016 Raj. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

	@IBOutlet weak var sportsActivitytableView: UITableView!
	let appInfoCellIdentifier = "APPINFO"

	override func viewDidLoad() {
		super.viewDidLoad()
		self.sportsActivitytableView.estimatedRowHeight = 100
		// Do any additional setup after loading the view, typically from a nib.
		ApiController.sharedInstance().fetchActivityList("user", userID: "2", activityPath: "sport_sessions", userParams: "")
		{ (error) in
			if error == nil {
				dispatch_async(dispatch_get_main_queue()) {
					self.sportsActivitytableView.reloadData()
				}
			}
		}
	}

	func numberOfSectionsInTableView(tableView: UITableView) -> Int {
		return 1
	}

	func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		return ApiController.sharedInstance().activityList?.count ?? 0
	}

	func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
		let appInfoCell = tableView.dequeueReusableCellWithIdentifier("APPINFO", forIndexPath: indexPath)

		if let appInfoCell = appInfoCell as? UserActivityTableViewCell {
			if let appData = ApiController.sharedInstance().activityList?[indexPath.row] {
				appInfoCell.activityID.text = appData.id!
				appInfoCell.sportsID.text = appData.sportTypeId!
				let duration: NSDate = NSDate(timeIntervalSince1970: appData.duration!)
				let dateFormatter = NSDateFormatter.rfcDateFormatter()
				let durationInterval = dateFormatter.stringFromDate(duration)
				appInfoCell.duration.text = durationInterval
			}
		}

		return appInfoCell
	}

	func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

		if let appData = ApiController.sharedInstance().activityList?[indexPath.row] {
			if appData.heartrateAvailable! {

				self.performSegueWithIdentifier("HeartRateSegue", sender: self)
			}
		}
	}

	override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {

		if segue.identifier == "HeartRateSegue",
			let destination = segue.destinationViewController as? HeartRateViewController,
			indexPath = sportsActivitytableView.indexPathForSelectedRow?.row {
				destination.appData = ApiController.sharedInstance().activityList?[indexPath]
		}
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}
}

extension NSDateFormatter {
	public class func rfcDateFormatter() -> NSDateFormatter {
		let rfc1123 = NSDateFormatter()
		rfc1123.locale = NSLocale(localeIdentifier: "en_US")
		rfc1123.timeZone = NSTimeZone(abbreviation: "UTC")
		rfc1123.dateFormat = "hh:mm:ss"
		return rfc1123
	}
}