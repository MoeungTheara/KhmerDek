//
//  KETSplashScreenViewController.swift
//  KhmerDek
//
//  Created by moeung Theara on 7/31/18.
//  Copyright © 2018 moeung Theara. All rights reserved.
//

import UIKit

class KETSplashScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        KETNavigationBarUtils.setNavigationBarToTransparent(navigationBar: (self.navigationController?.navigationBar)!)
      
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //self.showPhoneNumberScreen()
        self.showRefernceCodeScreen()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func showRefernceCodeScreen(){
        let ui = UIStoryboard.init(name: "refcode", bundle: nil)
        let refCodeVc = ui.instantiateInitialViewController()
        self.navigationController?.pushViewController(refCodeVc!, animated: false)
    }
    
    func showPhoneNumberScreen(){
        let ui = UIStoryboard.init(name: "phone", bundle: nil)
        let phoneVc = ui.instantiateInitialViewController()
        self.navigationController?.pushViewController(phoneVc!, animated: false)
    }
    

}
