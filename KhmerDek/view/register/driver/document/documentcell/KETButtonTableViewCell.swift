//
//  KETButtonTableViewCell.swift
//  KhmerDek
//
//  Created by moeung Theara on 7/30/18.
//  Copyright © 2018 moeung Theara. All rights reserved.
//

import UIKit
protocol KETButtonDelegate {
    func doClickRegister()
}
class KETButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var registerButton: UIButton!
    var delegate:KETButtonDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.registerButton.backgroundColor = UIColor.init(hexString: appColor)
        self.registerButton.setTitle("Register", for: .normal)
        self.registerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.registerButton.layer.cornerRadius = 10
        self.registerButton.clipsToBounds = true
        self.registerButton.setTitleColor(.white, for: .normal)
    }

    @IBAction func doClickRegister(_ sender: Any) {
        self.delegate?.doClickRegister()
    }
    

}
