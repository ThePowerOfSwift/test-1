//
//  PulleyTableViewCell.swift
//  BatChat
//
//  Created by Lorenzo Caso on 01/06/18.
//  Copyright © 2018 Lorenzo Caso. All rights reserved.
//

import UIKit

class PulleyTableViewCell: UITableViewCell {
    
    var backView: UIButton?
    var improf: UIImageView?
    var nickname: UILabel?
    var descrizione: UILabel?
    var data: UILabel?
    var numero: UILabel?
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        
        super.init(style: UITableViewCellStyle.default, reuseIdentifier: reuseIdentifier)
        
        nickname = UILabel(frame: CGRect(x: 85, y: 10, width: 80, height: 15))
        improf = UIImageView(frame: CGRect(x: 8, y: 6, width: 60, height: 60))
        backView = UIButton(frame: CGRect(x: 5, y: 3, width: 360, height: 65))
        
        descrizione = UILabel(frame: CGRect(x: 85, y: 25, width: 200, height: 40))
        data = UILabel(frame: CGRect(x: 250, y: 8, width: 50, height: 15))
        numero = UILabel(frame: CGRect(x: 325, y: 20, width: 25, height: 25))
        
        self.addSubview(backView!)
        self.addSubview(nickname!)
        self.addSubview(improf!)
        self.addSubview(descrizione!)
        self.addSubview(numero!)
        self.addSubview(data!)
    }
    
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        
    }
    
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func tapMessage(button: UIButton) {
        
        
    }
    
}

