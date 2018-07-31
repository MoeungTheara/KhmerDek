//
//  KETStepProgressBarTableViewCell.swift
//  KhmerDek
//
//  Created by moeung Theara on 7/30/18.
//  Copyright © 2018 moeung Theara. All rights reserved.
//

import UIKit

class KETStepProgressBarTableViewCell: UITableViewCell {

    @IBOutlet weak var stepProgressBar: SteppedProgressBar!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initStepProgressBar()
    }

    func initStepProgressBar(){
        let title = KETRegisterHelper.getDriverTitleProgressbar()
        KETRegisterHelper.initStepProgressBar(stepProgressBar: self.stepProgressBar,width:screenWidth*0.92, numberOfItem: 6, indexSelected: 5, titles: title)
        let width = (screenWidth*0.92) / CGFloat(title.count)
        self.stepProgressBar.widthTitle = width
        self.stepProgressBar.titleFont = UIFont.boldSystemFont(ofSize: 8.5)
        
        
    }

}
