//
//  HeartRateViewController.swift
//  RuntasticActivityList
//
//  Created by tcs on 5/2/16.
//  Copyright © 2016 Raj. All rights reserved.
//

import UIKit

class HeartRateViewController: UIViewController {

	var appData: UserActivtity!

	@IBOutlet weak var durationSpent: UILabel!
	var heartDate: HeartRate?

	override func viewDidLoad() {
		super.viewDidLoad()

		print(appData.id!)
		ApiController.sharedInstance().fetchHeartRate("user", userID: "2", activityPath: "sport_sessions", userParams: "", sportID: appData.id!, rateTrace: "heart_rate_trace", completionHandler: { (error) in
			if error == nil {
				dispatch_async(dispatch_get_main_queue()) {
					for i in ApiController.sharedInstance().heartRateList! {
						if ((i.heart_rate >=  140) && (i.heart_rate <= 159)) {
							let duration: NSDate = NSDate(timeIntervalSince1970: i.duration!)
							let dateFormatter = NSDateFormatter.rfcDateFormatter()
							let durationInterval = dateFormatter.stringFromDate(duration)
							self.durationSpent.text = durationInterval
						}
					}
				}
			}
		})

		// Do any additional setup after loading the view.
	}

	override func didReceiveMemoryWarning() {
		super.didReceiveMemoryWarning()
		// Dispose of any resources that can be recreated.
	}

	/*
	 // MARK: - Navigation

	 // In a storyboard-based application, you will often want to do a little preparation before navigation
	 override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
	 // Get the new view controller using segue.destinationViewController.
	 // Pass the selected object to the new view controller.
	 }
	 */
}
