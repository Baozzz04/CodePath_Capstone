//
//  DishTableViewCell.swift
//  CodePath_final
//
//  Created by Nguyen Ngoc Bao on 19/04/2024.
//

import Foundation
import UIKit

class DishTableViewCell: UITableViewCell {
    
    // Additional properties and methods can be added here as needed
    @IBOutlet weak var dishLabel: UILabel!
    @IBOutlet weak var dishImage: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        dishImage.image = nil
        dishLabel.text = nil
    }
}
