//
//  KETReferencdCodeViewController.swift
//  KhmerDek
//
//  Created by moeung Theara on 7/26/18.
//  Copyright © 2018 moeung Theara. All rights reserved.
//

import UIKit

class KETReferencdCodeViewController: UIViewController {
    @IBOutlet weak var validateMessageLabel: UILabel!
    @IBOutlet weak var stepProgressBar: SteppedProgressBar!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var codeTextFeild: UITextField!
    @IBOutlet weak var logoImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initElement()
        self.initnavigationBar()
        self.initStepProgressBar()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
       
    }
    
    func initStepProgressBar(){
        let title = KETRegisterHelper.getDriverTitleProgressbar()
        KETRegisterHelper.initStepProgressBar(stepProgressBar: self.stepProgressBar,width:screenWidth*0.92, numberOfItem: 6, indexSelected: 0, titles: title)
        
        let width = (screenWidth*0.92) / CGFloat(title.count)
        self.stepProgressBar.widthTitle = width
        self.stepProgressBar.titleFont = UIFont.boldSystemFont(ofSize: 8.5)
        
    }
    
    func initElement(){
        self.nextButton.backgroundColor = UIColor.init(hexString: appColor)
        self.nextButton.setTitle("Next", for: .normal)
        self.nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.nextButton.layer.cornerRadius = 10
        self.nextButton.clipsToBounds = true
        self.nextButton.setTitleColor(.white, for: .normal)
        
        KETRegisterHelper.SetRoundView(view: self.codeTextFeild, raduis: self.codeTextFeild.frame.height*0.2)
        self.codeTextFeild.font = UIFont.systemFont(ofSize: 16)
        self.codeTextFeild.placeholder = "123455"
        self.codeTextFeild.addDoneButtonOnKeyboard()
        self.codeTextFeild.delegate = self
        KETRegisterHelper.hideError(label: self.validateMessageLabel)
        self.addDidChangeTextTo(textFiled: self.codeTextFeild)
    }
    
    func initnavigationBar(){
        
        KETNavigationBarUtils.setUpResisterNavigationBar(navigationItem:self.navigationItem, rightSelector1: #selector(doChangelangauge), rightSelector2:  #selector(doShowCallAgency),vc: self)
      
        if let navigationBar = self.navigationController?.navigationBar {
            
            KETNavigationBarUtils.setNavigationBarToTransparent(navigationBar: navigationBar)
        }
        self.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    func addDidChangeTextTo(textFiled:UITextField){
        textFiled.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    }
    
    func showRegisterPhoneScreen(){
        let ui = UIStoryboard.init(name: "phone", bundle: nil)
        let phoneVc = ui.instantiateInitialViewController() as! KETPhoneNumberDriverViewController
        phoneVc.isDriver = true
        self.navigationController?.pushViewController(phoneVc, animated: true)
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
    func showError(textFiled:UITextField){
        textFiled.layer.borderWidth = 2
        textFiled.layer.borderColor = UIColor.red.cgColor
        textFiled.shakeAnimation()
    }
    
    func hideError(textField:UITextField){
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.init(hexString: appColor).cgColor
    }
    
    func isCanGoToNext()->Bool{
        var isCan = false
        if codeTextFeild.text?.isEmpty == false{
            let count = self.codeTextFeild.text?.count ?? 0
            if count < 8{
                KETRegisterHelper.showError(label: self.validateMessageLabel, message: "minimun 8 digits", TotextField: self.codeTextFeild)
            }else{
                isCan = true
            }
        
        }else{
            self.showError(textFiled: codeTextFeild)
        }
        return isCan
    }
    
   
    @IBAction func doClickNext(_ sender: Any) {
        if self.isCanGoToNext(){
            self.showRegisterPhoneScreen()
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
}

extension KETReferencdCodeViewController:UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.isEmpty == true{
           self.showError(textFiled: textField)
            let count = self.codeTextFeild.text?.count ?? 0
            if count < 8{
                KETRegisterHelper.showError(label: self.validateMessageLabel, message: "minimun 8 digits", TotextField: self.codeTextFeild)
            }else{
                KETRegisterHelper.hideError(label: self.validateMessageLabel)
            }
        }else{
            self.hideError(textField: textField)
        }
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        if textField.text?.isEmpty == false{
            self.hideError(textField: textField)
            let count = self.codeTextFeild.text?.count ?? 0
            if count >= 8{
                KETRegisterHelper.hideError(label: self.validateMessageLabel)
            }
        }
        print("Text changed")
        
    }
    
}



