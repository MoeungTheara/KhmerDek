//
//  SMPNavigationBarUtils.swift
//  chichamaps
//
//  Created by Sreymom TONG on 12/26/17.
//  Copyright © 2017 Sompom. All rights reserved.
//

import UIKit

class KETNavigationBarUtils: NSObject {
    static func setUpResisterNavigationBar(navigationItem: UINavigationItem,rightSelector1: Selector, rightSelector2: Selector,vc:UIViewController){
    
        let lanImage    = #imageLiteral(resourceName: "langauge").withRenderingMode(.alwaysTemplate)
        let AgencyImage  = #imageLiteral(resourceName: "customer_support").withRenderingMode(.alwaysTemplate)
        
        let langButton   = UIBarButtonItem(image: lanImage,  style: .plain, target: vc, action: rightSelector1)
        langButton.tintColor = UIColor.init(hexString: appColor)
        let agencyButton = UIBarButtonItem(image: AgencyImage,  style: .plain, target: vc, action:rightSelector2)
        agencyButton.tintColor = .gray
        navigationItem.rightBarButtonItems = [agencyButton,langButton]
        let backButton = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        navigationItem.backBarButtonItem = backButton
    }

    static func setNavigationBarToTransparent(navigationBar: UINavigationBar){
        navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        navigationBar.shadowImage = UIImage()
        navigationBar.isTranslucent = true
    }
}
