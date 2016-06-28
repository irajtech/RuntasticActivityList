//
//  UserActivtity.swift
//  RuntasticActivityList
//
//  Created by tcs on 5/2/16.
//  Copyright © 2016 Raj. All rights reserved.
//

import UIKit
import SwiftyJSON

class UserActivtity {

	let id: String?
	let sportTypeId: String?
	let duration: Double?
	let heartrateAvailable: Bool?

	init(data: JSON) {
		self.id = data["id"].stringValue
		let activityType = data["sportTypeId"].int
		self.sportTypeId = Activity(rawValue: activityType!)?.sportsActivity()
		self.duration = data["duration"].double
		self.heartrateAvailable = data["heartRateAvailable"].bool
	}
}

enum Activity: Int {
	case Running = 1
	case NordicWalking, Biking, Mountainbiking, Other
	case DontKnow = 37
	func sportsActivity() -> String {
		switch self {
		case .Running:
			return "Running"
		case .NordicWalking:
			return "Nordic Walking"
		case .Biking:
			return "Biking"
		case .Mountainbiking:
			return "Mountainbiking"
		case .Other:
			return "Other"
		case .DontKnow:
			return "Miracle WorkOut"
		}
	}
}