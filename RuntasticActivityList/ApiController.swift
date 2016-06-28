//
//  ApiController.swift
//  RuntasticActivityList
//
//  Created by tcs on 5/2/16.
//  Copyright © 2016 Raj. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

private let _sharedInstance = ApiController()

let baseURL = "https://codingcontest.runtastic.com/api"

//    1: Running
//    2: Nordic Walking
//    3: Biking
//    4: Mountainbiking
//    5: Other

//https://codingcontest.runtastic.com/api/user/2/sport_sessions/<sport_session_id>/heart_rate_trace

class ApiController: NSObject {

	var activityList: [UserActivtity]?

	var heartRateList: [HeartRate]?

	// Singleton for accesing the instance
	class func sharedInstance() -> ApiController {
		return _sharedInstance
	}

	/**
	 Fetch User activity list
	 */
	func fetchActivityList(subpath: String, userID: String, activityPath: String, userParams: String, completionHandler: (NSError?) -> Void) {

		let userActivityApiURL = [baseURL, subpath, userID, activityPath].joinWithSeparator("/")
		Alamofire.request(.GET, userActivityApiURL, parameters: nil)
			.responseJSON { response in
				if let json = response.result.value {
					self.activityList = []
					print("JSON: \(json)")
					var jsonData = JSON(data: response.data!)
					let sportSessions = jsonData["sport_sessions"]
					print(sportSessions.count)
					for (_, userActivityList) in sportSessions {
						let activityList: UserActivtity = UserActivtity(data: userActivityList)
						self.activityList?.append(activityList)
					}
				}
				completionHandler(nil)
		}
	}

	func fetchHeartRate(subpath: String, userID: String, activityPath: String, userParams: String, sportID: String, rateTrace: String, completionHandler: (NSError?) -> Void) {

		let userHeartRateApiURL = [baseURL, subpath, userID, activityPath, sportID, rateTrace].joinWithSeparator("/")

		Alamofire.request(.GET, userHeartRateApiURL, parameters: nil)
			.responseJSON { response in
				if let json = response.result.value {
					self.heartRateList = []
					print("JSON: \(json)")
					let jsonData = JSON(data: response.data!)
					for (_, userActivityList) in jsonData {
						let activityList: HeartRate = HeartRate(data: userActivityList)
						self.heartRateList?.append(activityList)
					}
				}
				completionHandler(nil)
		}
	}
}
