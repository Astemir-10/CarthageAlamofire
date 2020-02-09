//
//  MealCategoryCell.swift
//  EmptySubject
//
//  Created by Astemir Shibzuhov on 09.02.2020.
//  Copyright © 2020 Astemir Shibzuhov. All rights reserved.
//

import UIKit

class MealCategoryCell: UICollectionViewCell {

    @IBOutlet weak var categoryImage: UIImageView!
    @IBOutlet weak var categoryTextLabel: UILabel!
    @IBOutlet weak var viewContent: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        viewContent.layer.cornerRadius = 20
        viewContent.clipsToBounds = true
        
        layer.shadowColor = #colorLiteral(red: 0, green: 0, blue: 0, alpha: 1)
        layer.shadowOffset = CGSize(width: -3, height: 1)
        layer.shadowRadius = 4
        layer.shadowOpacity = 0.15
        clipsToBounds = false
        
        // Initialization code
    }

}
