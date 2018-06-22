//
//  Chat1TableViewCell.swift
//  BatChat
//
//  Created by Lorenzo Caso on 01/06/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit

class Chat1TableViewCell: UITableViewCell {

    @IBOutlet weak var divisore: UILabel!
    @IBOutlet weak var num1: UILabel!
    @IBOutlet weak var fine: UILabel!
    @IBOutlet weak var inizio1: UILabel!
    @IBOutlet weak var desc1: UILabel!
    @IBOutlet weak var nick1: UILabel!
    @IBOutlet weak var improf1: UIImageView!
    @IBOutlet weak var sfondo1: UICustomButton!
    var id: Int32?
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
