//
//  UserActivityTableViewCell.swift
//  
//
//  Created by tcs on 5/2/16.
//
//

import UIKit

class UserActivityTableViewCell: UITableViewCell {

   
    @IBOutlet weak var activityID: UILabel!
    @IBOutlet weak var sportsID: UILabel!
    @IBOutlet weak var duration: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
