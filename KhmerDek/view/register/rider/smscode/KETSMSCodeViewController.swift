//
//  KETSMSCodeViewController.swift
//  KhmerDek
//
//  Created by moeung Theara on 7/26/18.
//  Copyright © 2018 moeung Theara. All rights reserved.
//

import UIKit

class KETSMSCodeViewController: UIViewController {
    @IBOutlet weak var stepProgressBar: SteppedProgressBar!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var code1Textfiled: UITextField!
    @IBOutlet weak var code2textfileld: UITextField!
    @IBOutlet weak var code3textfileld: UITextField!
    @IBOutlet weak var logoImageView: UIImageView!
   
    var isDriver:Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initnavigationBar()
        self.initElement()
        self.initStepProgressBar()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    func initElement(){
        self.nextButton.backgroundColor = UIColor.init(hexString: appColor)
        self.nextButton.setTitle("Next", for: .normal)
        self.nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.nextButton.layer.cornerRadius = 10
        self.nextButton.clipsToBounds = true
        self.nextButton.setTitleColor(.white, for: .normal)
        self.enableNextButtonIfNeeded()
         KETRegisterHelper.SetRoundView(view:  self.code1Textfiled, raduis: self.code1Textfiled.frame.height*0.2)
         KETRegisterHelper.SetRoundView(view:  self.code2textfileld, raduis: self.code2textfileld.frame.height*0.2)
         KETRegisterHelper.SetRoundView(view:  self.code3textfileld, raduis: self.code3textfileld.frame.height*0.2)
        self.setUpTextField()
     
    }
    
    func enableNextButtonIfNeeded(){
        if self.code1Textfiled.text?.count != 0 && self.code2textfileld.text?.count != 0 && self.code3textfileld.text?.count != 0 {
            self.nextButton.isEnabled = true
            self.nextButton.alpha = 1
        }else{
            self.nextButton.isEnabled = false
            self.nextButton.alpha = 0.9
        }
    }
    
    func setUpTextField(){
        self.code1Textfiled.becomeFirstResponder()
        self.addDidChangeTextTo(textFiled: self.code1Textfiled)
        self.addDidChangeTextTo(textFiled: self.code2textfileld)
        self.addDidChangeTextTo(textFiled: self.code3textfileld)
        self.code1Textfiled.delegate = self
        self.code2textfileld.delegate = self
        self.code3textfileld.delegate = self
        self.code1Textfiled.font = UIFont.boldSystemFont(ofSize: 20)
        self.code2textfileld.font = UIFont.boldSystemFont(ofSize: 20)
        self.code3textfileld.font = UIFont.boldSystemFont(ofSize: 20)
    }
    
    func initStepProgressBar(){
        var title = ["Phone","SMM Code"]
        if self.isDriver == false {
               KETRegisterHelper.initStepProgressBar(stepProgressBar: self.stepProgressBar,width:screenWidth*0.4, numberOfItem: 2, indexSelected: 1, titles: title)
        }else{
            title = KETRegisterHelper.getDriverTitleProgressbar()
            KETRegisterHelper.initStepProgressBar(stepProgressBar: self.stepProgressBar,width:screenWidth*0.92, numberOfItem: 6, indexSelected: 2, titles: title)
            
            let width = (screenWidth*0.92) / CGFloat(title.count)
            self.stepProgressBar.widthTitle = width
            self.stepProgressBar.titleFont = UIFont.boldSystemFont(ofSize: 8.5)
           
        }
     
    }
    
    
    func initnavigationBar(){
      
        KETNavigationBarUtils.setUpResisterNavigationBar(navigationItem:self.navigationItem, rightSelector1: #selector(doChangelangauge), rightSelector2:  #selector(doShowCallAgency),vc: self)
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.tintColor = UIColor.init(hexString: appColor)
            KETNavigationBarUtils.setNavigationBarToTransparent(navigationBar: navigationBar)
        }
        
    }
    
    func addDidChangeTextTo(textFiled:UITextField){
        textFiled.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    }
    
    func ShowDriverInformationScreen(){
        let ui = UIStoryboard.init(name: "driver_information", bundle: nil)
        let infoVC = ui.instantiateInitialViewController() as! KETDriverInformationViewController
        self.navigationController?.pushViewController(infoVC, animated: true)
    }
    
    @objc func doChangelangauge() {
        let lanagaugeTitle = KETRegisterHelper.getTitlelangauge()
        KETRegisterHelper.showAlertChangeLangaue(titles: lanagaugeTitle, vc: self) { (title) in
            if title == "Khmer"{
                print("choose khmer")
            }else {
                print("choose english")
            }
        }
        
    }
    
    @objc func doShowCallAgency() {
        let phoneNumberList = KETRegisterHelper.getPhoneNumberList()
        KETRegisterHelper.showAllertCallAgency(PhoneNumberList: phoneNumberList, vc: self) { (phoneNumber) in
            print("phone number:\(phoneNumber)")
        }
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
   
    @IBAction func doClickNext(_ sender: Any) {
        if isDriver == true{
            self.ShowDriverInformationScreen()
        }else{
            
        }
    }
    
}

extension KETSMSCodeViewController:UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        if textField == self.code1Textfiled {
            if textField.text?.count == 1 {
                self.code2textfileld.becomeFirstResponder()
            }
        }else if textField == self.code2textfileld {
            if textField.text?.count == 1{
                self.code3textfileld.becomeFirstResponder()
            }
        }else if textField == self.code3textfileld {
            if textField.text?.count == 1{
                self.code3textfileld.resignFirstResponder()
            }
        }
        self.enableNextButtonIfNeeded()
        
    }
    
}


