//
//  KETRegisterHelper.swift
//  KhmerDek
//
//  Created by moeung Theara on 7/26/18.
//  Copyright © 2018 moeung Theara. All rights reserved.
//

import UIKit

class KETRegisterHelper: NSObject {
    class func initStepProgressBar(stepProgressBar:SteppedProgressBar,width:CGFloat,numberOfItem:Int,indexSelected:Int,titles:[String]){
         let space = (screenWidth - width) * 0.5
        var inset: UIEdgeInsets {
            return UIEdgeInsets(top: 0, left: space, bottom: 0, right: space)
        }
        stepProgressBar.titleOffset = 10
        stepProgressBar.insets = inset
        stepProgressBar.tintColor = UIColor.init(hexString: appColor)
        stepProgressBar.tintActiveImage = true
        stepProgressBar.lineWidth = 5
        
        stepProgressBar.inactiveTextColor = UIColor.init(hexString: appColor)
        
        
        stepProgressBar.inactiveColor = UIColor.init(hexString: appColor)
        stepProgressBar.activeColor = UIColor.init(hexString: appColor)
        
        stepProgressBar.currentTab = indexSelected
        stepProgressBar.numberOfImage = numberOfItem
        stepProgressBar.justCheckCompleted = false
        stepProgressBar.stepDrawingMode = .fill
        stepProgressBar.image = #imageLiteral(resourceName: "circle")
        stepProgressBar.activeImage = #imageLiteral(resourceName: "check")
        stepProgressBar.titles = titles
        stepProgressBar.titleFont = UIFont.systemFont(ofSize: 10)
        
        
    }
    
    class func SetRoundView(view:UIView,raduis:CGFloat){
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.init(hexString: appColor).cgColor
        view.layer.cornerRadius = CGFloat(raduis)
        view.clipsToBounds = true
    }
    
    class func getDriverTitleProgressbar() -> [String]{
        return  ["Ref.Code","Phone","SMS Code","Driver Info","Vechicle Info","Documents"]
    }
    
    class func getTitlelangauge() -> [String]{
        return ["Khmer","English"]
    }
    
    class func getPhoneNumberList() -> [String]{
        return ["0967854321","070456732","012678954"]
    }
    
    class func showAlertChangeLangaue(titles:[String],vc:UIViewController,completSelected: @escaping (_ title:String) -> Void){
        
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        for title in titles {
            let langaugeAction: UIAlertAction = UIAlertAction(title:title, style: .default) { action -> Void in
                completSelected(title)
            }
            actionSheetController.addAction(langaugeAction)
        }
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style:.cancel ) { action -> Void in }
    
        actionSheetController.addAction(cancelAction)
        
        vc.present(actionSheetController, animated: true, completion: nil)
    }
    
    class func showAllertCallAgency(PhoneNumberList:[String],vc:UIViewController,completSelected: @escaping (_ phoneNumber:String) -> Void){
        
        let alert = UIAlertController(title: "Agency", message: "", preferredStyle: UIAlertControllerStyle.alert)
       
        for phone in PhoneNumberList {
            let callAction = UIAlertAction(title: phone, style: .default) { _ in
               completSelected(phone)
            }
             alert.addAction(callAction)
        }
        let cancleAction = UIAlertAction(title: "Cancle", style: .destructive, handler: nil)
    
        alert.addAction(cancleAction)
        vc.present(alert, animated: true, completion: nil)
    }
    
    class func showError (label:UILabel,message:String,TotextField:UITextField){
        TotextField.shakeAnimation()
        label.text = message
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .red
        label.isHidden = false
        
    }
    
    class func hideError (label:UILabel){
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.isHidden = true
    }
}
