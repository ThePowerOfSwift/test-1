//
//  ChatTableViewCell.swift
//  BatChat
//
//  Created by Lorenzo Caso on 01/06/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var num: UILabel!
    @IBOutlet weak var inizio: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var improf: UIImageView!
    @IBOutlet weak var sfondo: UICustomButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
