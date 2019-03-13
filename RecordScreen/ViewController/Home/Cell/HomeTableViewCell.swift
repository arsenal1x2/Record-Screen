//
//  HomeTableViewCell.swift
//  RecordScreen
//
//  Created by LTT on 123//19.
//  Copyright © 2019 LTT. All rights reserved.
//

import UIKit

class HomeTableViewCell: UITableViewCell {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var iconImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    func configCell(nameIcon: String, title: String) {
        iconImageView.image = UIImage(named: nameIcon)
        titleLabel.text = title
    }
}
