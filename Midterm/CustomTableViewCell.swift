//
//  CustomTableViewCell.swift
//  Midterm
//
//  Created by Тогжан Салимова on 10/16/20.
//  Copyright © 2020 Тогжан Салимова. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {

    
    @IBOutlet weak var countryName: UILabel!
    
    @IBOutlet weak var countryCode: UILabel!
    
    @IBOutlet weak var capital: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
