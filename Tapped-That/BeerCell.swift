//
//  BeerCell.swift
//  Tapped-That
//
//  Created by Christopher Bell on 5/13/19.
//  Copyright © 2019 Christopher Bell. All rights reserved.
//

import UIKit

class BeerCell: UITableViewCell {
    @IBOutlet weak var beerName: UILabel!
    @IBOutlet weak var breweryName: UILabel!
    @IBOutlet weak var beerType: UILabel!
    @IBOutlet weak var beerImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
