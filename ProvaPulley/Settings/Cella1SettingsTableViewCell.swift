//
//  Cella1SettingsTableViewCell.swift
//  BatChat
//
//  Created by Lorenzo Caso on 04/06/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit

class Cella1SettingsTableViewCell: UITableViewCell {

    @IBOutlet weak var scritta: UILabel!
    @IBOutlet weak var notifiche: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
