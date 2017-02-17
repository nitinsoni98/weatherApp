//
//  TableViewCell.swift
//  WeatherApp
//
//  Created by Sierra 4 on 14/02/17.
//  Copyright © 2017 codebrew. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var imgIcon: UIImageView!
    @IBOutlet weak var lblMaximumTemperature: UILabel!
    @IBOutlet weak var lblMinimumTemperature: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()


}

}
