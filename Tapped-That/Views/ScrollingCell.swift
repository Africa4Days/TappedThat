//
//  ScrollingCell.swift
//  Tapped-That
//
//  Created by Christopher Bell on 5/17/19.
//  Copyright © 2019 Christopher Bell. All rights reserved.
//

import UIKit

class ScrollingCell: UITableViewCell {

    @IBOutlet weak var venueImage: UIImageView!
    @IBOutlet weak var venueName: UILabel!
    @IBOutlet weak var venueType: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
