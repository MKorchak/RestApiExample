//
//  TableViewCell.swift
//  RestApiExample
//
//  Created by Misha Korchak on 29.12.16.
//  Copyright © 2016 Misha Korchak. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var IDLabel: UILabel!
    @IBOutlet weak var numberLabel: UILabel!
    @IBOutlet weak var posterImage: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
