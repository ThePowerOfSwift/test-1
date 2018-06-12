//
//  ConversazionCellTableViewCell.swift
//  BatChat
//
//  Created by Sofia Passarelli on 12/06/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit

class ConversazionCell: UITableViewCell {


    @IBOutlet weak var lblMessaggio: UILabel!
    @IBOutlet weak var lblData: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
