//
//  PulleyTableViewCell.swift
//  BatChat
//
//  Created by Lorenzo Caso on 01/06/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit

class PulleyTableViewCell: UITableViewCell {

    @IBOutlet weak var sfondo: UICustomButton!
    @IBOutlet weak var improf: UIImageView!
    @IBOutlet weak var nickname: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var inizio: UILabel!
   
    
    @IBOutlet weak var num: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
