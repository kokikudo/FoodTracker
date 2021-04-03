//
//  MealTableViewCell.swift
//  FoodTracker
//
//  Created by kudo koki on 2021/03/31.
//

import UIKit

class MealTableViewCell: UITableViewCell {

    // プロパティ
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    @IBOutlet weak var ratingControl: RatingControl!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
