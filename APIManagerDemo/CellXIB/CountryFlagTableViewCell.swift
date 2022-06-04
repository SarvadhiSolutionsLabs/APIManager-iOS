//
//  CountryFlagTableViewCell.swift
//  APIManagerDemo
//
//  Created by Avadh on 23/04/21.
//  Copyright © 2021 Avadh. All rights reserved.
//

import UIKit

class CountryFlagTableViewCell: UITableViewCell {

    @IBOutlet weak var flagImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
