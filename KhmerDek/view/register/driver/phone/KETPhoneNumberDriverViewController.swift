//
//  PhoneNumberViewController.swift
//  KhmerDek
//
//  Created by moeung Theara on 7/25/18.
//  Copyright © 2018 moeung Theara. All rights reserved.
//

import UIKit


class KETPhoneNumberDriverViewController: UIViewController {

   
    @IBOutlet weak var validateMessageLabel: UILabel!
    @IBOutlet weak var stepProgressBar: SteppedProgressBar!
    @IBOutlet weak var countryCodeButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var flagLabel: UILabel!
    @IBOutlet weak var phoneTextFeild: UITextField!
    @IBOutlet weak var countryCodeLabel: UILabel!
    @IBOutlet weak var countryNameLabel: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    fileprivate var popover: Popover!
    var isDriver:Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initElement()
        self.initnavigationBar()
        self.initStepProgressBar()
        self.initData()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    func initData(){
        var code = ""
        if let countryCode:String = (Locale.current as NSLocale).object(forKey: .countryCode) as? String{
            code = countryCode
        }else{
            code = "KH"
        }
        let currentCountry =  Countries().countries.filter({$0.countryCode == code})
        if let country = currentCountry.first{
            self.countryNameLabel.text = country.name ?? ""
            self.countryCodeLabel.text = "+\(country.phoneExtension)"
            self.flagLabel.text = country.flag ?? ""
        }else{
            
        }
    }
    
    func initStepProgressBar(){
        if isDriver == true {
            let title = KETRegisterHelper.getDriverTitleProgressbar()
            KETRegisterHelper.initStepProgressBar(stepProgressBar: self.stepProgressBar,width:screenWidth*0.92, numberOfItem: 6, indexSelected: 1, titles: title)
            let width = (screenWidth*0.92) / CGFloat(title.count)
            self.stepProgressBar.widthTitle = width
            self.stepProgressBar.titleFont = UIFont.boldSystemFont(ofSize: 8.5)
        }else{
            let title = ["Phone","SMM Code"]
            KETRegisterHelper.initStepProgressBar(stepProgressBar: self.stepProgressBar,width:screenWidth*0.4, numberOfItem: 2, indexSelected: 0, titles: title)
        }
       
      
        
    }
    
    func initElement(){
        self.nextButton.backgroundColor = UIColor.init(hexString: appColor)
        self.nextButton.setTitle("Next", for: .normal)
        self.nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.nextButton.layer.cornerRadius = 10
        self.nextButton.clipsToBounds = true
        self.nextButton.setTitleColor(.white, for: .normal)
        
    
        KETRegisterHelper.SetRoundView(view: self.phoneTextFeild, raduis: self.countryCodeButton.frame.height*0.2)
        KETRegisterHelper.SetRoundView(view: self.countryCodeButton, raduis: self.countryCodeButton.frame.height*0.2)
     
        
        self.countryNameLabel.font = UIFont.systemFont(ofSize: 16)
        self.countryCodeLabel.font = UIFont.systemFont(ofSize: 14)
        self.countryCodeLabel.textColor = .gray
        self.phoneTextFeild.placeholder = "123456"
        self.phoneTextFeild.addDoneButtonOnKeyboard()
        self.phoneTextFeild.delegate = self
        self.addDidChangeTextTo(textFiled: self.phoneTextFeild)
        KETRegisterHelper.hideError(label: self.validateMessageLabel)
        self.flagLabel.font = UIFont.systemFont(ofSize: 35)
    }
        
    func initnavigationBar(){
        if self.isDriver == true {
          KETNavigationBarUtils.setUpResisterNavigationBar(navigationItem:self.navigationItem, rightSelector1: #selector(doChangelangauge), rightSelector2:  #selector(doShowCallAgency),vc: self)
            if let navigationBar = self.navigationController?.navigationBar {
                navigationBar.tintColor = UIColor.init(hexString: appColor)
                KETNavigationBarUtils.setNavigationBarToTransparent(navigationBar: navigationBar)
            }
        }else{
            self.navigationItem.setHidesBackButton(true, animated: false)
        }
        
    }
    
    func addDidChangeTextTo(textFiled:UITextField){
        textFiled.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    }
    
    func showSMSCodeScreen(){
        let smsCodeVC = KETSMSCodeViewController.init(nibName: "smscode", bundle: nil)
        smsCodeVC.isDriver = self.isDriver
        self.navigationController?.pushViewController(smsCodeVC, animated: true)
        
       
    }
    
    func showCountryCodePopup(){
        self.view.endEditing(true)
        let ui = UIStoryboard.init(name: "country_code", bundle: nil)
        let vc = ui.instantiateInitialViewController() as! KETCountryCodePopupViewController
        vc.delegate = self
        vc.view.frame = CGRect.init(x: 0, y: 0, width: screenWidth*0.85, height: screenheight*0.85)
        let popoverOptions: [PopoverOption] = [
            .type(.down),
            .cornerRadius(2),
            .blackOverlayColor(UIColor(white: 0.0, alpha: 0.6))
        ]
        self.popover = Popover(options: popoverOptions)
        self.popover.willShowHandler = {
            print("willShowHandler")
        }
        self.popover.didShowHandler = {
            print("didShowHandler")
            vc.view.layer.cornerRadius = 2
            vc.view.clipsToBounds = true
        }
        self.popover.willDismissHandler = {
            print("willDismissHandler")
        }
        self.popover.didDismissHandler = {
            print("didDismissHandler")
        }
        self.popover.showAsDialog(vc.view)
       
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
        if phoneTextFeild.text?.isEmpty == false{
            isCan = true
            if (phoneTextFeild.text?.count ?? 0) < 9 ||  (phoneTextFeild.text?.count ?? 0) > 10{
                isCan = false
                KETRegisterHelper.showError(label: self.validateMessageLabel, message: "Invalid Phone Number ",TotextField: phoneTextFeild)
            }
        }else{
            self.showError(textFiled: phoneTextFeild)
        }
        return isCan
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @IBAction func doClickCountryCode(_ sender: Any) {
        self.showCountryCodePopup()
    }
    @IBAction func doClickNext(_ sender: Any) {
        if self.isCanGoToNext(){
            self.phoneTextFeild.resignFirstResponder()
            self.showSMSCodeScreen()
        }
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

}
extension KETPhoneNumberDriverViewController:KETCountryCodeDelegete{
    func didSelectedCountryCode(country: Country) {
        self.popover.dismiss()
        self.countryCodeLabel.text = "+\(country.phoneExtension)"
        self.countryNameLabel.text = country.name
        self.flagLabel.text = country.flag ?? ""
    }
}

extension KETPhoneNumberDriverViewController:UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.isEmpty == true{
            self.showError(textFiled: textField)
        }else{
            if (textField.text?.count ?? 0) < 9 ||  (textField.text?.count ?? 0) > 10{
                KETRegisterHelper.showError(label: self.validateMessageLabel, message: "Invalid Phone Number ",TotextField: textField)
            }else{
                KETRegisterHelper.hideError(label: self.validateMessageLabel)
            }
            
        }
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        if textField.text?.isEmpty == false{
            self.hideError(textField: textField)
            KETRegisterHelper.hideError(label: self.validateMessageLabel)
        }else{
            
        }
        print("Text changed")
        
    }
    
}


