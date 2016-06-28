//
//  HeartRate.swift
//  RuntasticActivityList
//
//  Created by tcs on 5/2/16.
//  Copyright © 2016 Raj. All rights reserved.
//

import UIKit
import SwiftyJSON

class HeartRate {
	let heart_rate: Int?
	let signal_strength: String?
	let duration: Double?

	init(data: JSON) {
		self.heart_rate = data["heart_rate"].int
		self.duration = data["duration"].double
		self.signal_strength = data["signal_strength"].string
	}
}
