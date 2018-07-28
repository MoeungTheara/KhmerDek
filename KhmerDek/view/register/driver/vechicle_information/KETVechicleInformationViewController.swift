//
//  KETVechicleInformationViewController.swift
//  KhmerDek
//
//  Created by moeung Theara on 7/27/18.
//  Copyright © 2018 moeung Theara. All rights reserved.
//

import UIKit

enum ButtonType:Int{
    case City
    case VechicleTyle
    case VechicleModel
}

class KETVechicleInformationViewController: UIViewController {
    @IBOutlet weak var cityView: UIView!
    @IBOutlet weak var vechicleTypeView: UIView!
    
    @IBOutlet weak var vechicleModelView: UIView!
    @IBOutlet weak var vechicleModelButton: UIButton!
    @IBOutlet weak var vechicleTypeButton: UIButton!
    @IBOutlet weak var cityButton: UIButton!
    @IBOutlet weak var cityTextFiled: UITextField!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var vechicleModelTextFiled: UITextField!
    @IBOutlet weak var vechicleNumTextFiled: UITextField!
    @IBOutlet weak var vechicleTypeTextFiled: UITextField!
    @IBOutlet weak var stepProgressBar: SteppedProgressBar!
    @IBOutlet weak var logoImageView: UIImageView!
    var choicPickerView : UIPickerView!
    var pickerData:[String]?
    var selectedTextField:UITextField?
    var selectedData:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initElement()
        self.initStepProgressBar()
        self.initnavigationBar()
        self.initDropDownButton()
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
        self.setBorderColorTo(view: self.vechicleTypeView)
        self.setBorderColorTo(view: self.vechicleModelView)
        self.setBorderColorTo(view: self.cityView)
        KETRegisterHelper.SetRoundView(view: self.vechicleNumTextFiled, raduis: self.vechicleNumTextFiled.frame.height*0.2)
        self.cityButton.tag = ButtonType.City.hashValue
        self.vechicleTypeButton.tag = ButtonType.VechicleTyle.hashValue
        self.vechicleModelButton.tag = ButtonType.VechicleModel.hashValue
        self.sectUpTextFiled()
    }
    
    func sectUpTextFiled(){
        self.vechicleNumTextFiled.delegate = self
        self.vechicleModelTextFiled.delegate = self
        self.vechicleTypeTextFiled.delegate = self
        self.cityTextFiled.delegate = self
    }
    
    func initStepProgressBar(){
        let title = KETRegisterHelper.getDriverTitleProgressbar()
        KETRegisterHelper.initStepProgressBar(stepProgressBar: self.stepProgressBar,width:screenWidth*0.92, numberOfItem: 6, indexSelected: 4, titles: title)
        let width = (screenWidth*0.92) / CGFloat(title.count)
        self.stepProgressBar.widthTitle = width
        self.stepProgressBar.titleFont = UIFont.boldSystemFont(ofSize: 8.5)
        
        
    }
    
    func initnavigationBar(){
        self.navigationItem.backBarButtonItem?.title = ""
        self.navigationItem.title = nil
        KETNavigationBarUtils.setUpResisterNavigationBar(navigationItem:self.navigationItem, rightSelector1: #selector(doChangelangauge), rightSelector2:  #selector(doShowCallAgency),vc: self)
        if let navigationBar = self.navigationController?.navigationBar {
            navigationBar.tintColor = UIColor.init(hexString: appColor)
            KETNavigationBarUtils.setNavigationBarToTransparent(navigationBar: navigationBar)
        }
       
        
    }
    
    func initDropDownButton(){
        let dropDownImage = #imageLiteral(resourceName: "drop_down").withRenderingMode(.alwaysTemplate)
        self.cityButton.setImage(dropDownImage, for: .normal)
        self.cityButton.tintColor = UIColor.init(hexString: appColor)
        self.vechicleTypeButton.setImage(dropDownImage, for: .normal)
        self.vechicleTypeButton.tintColor = UIColor.init(hexString: appColor)
        self.vechicleModelButton.setImage(dropDownImage, for: .normal)
        self.vechicleModelButton.tintColor = UIColor.init(hexString: appColor)
        self.setPlaceHolderTextField(textField: self.vechicleNumTextFiled, text: "Vechicle No.")
        self.setPlaceHolderTextField(textField: self.vechicleModelTextFiled, text: "Select Vechicle Model")
        self.setPlaceHolderTextField(textField: self.vechicleTypeTextFiled, text:  "Select Vechicle Type")
        self.setPlaceHolderTextField(textField: self.cityTextFiled, text: "Select City")
    }
    
    func setPlaceHolderTextField(textField:UITextField,text:String){
        textField.attributedPlaceholder = NSAttributedString(string:text, attributes: [NSAttributedStringKey.foregroundColor: UIColor.init(hexString: appColor).withAlphaComponent(0.6)])
    }
    
    func setBorderColorTo(view:UIView){
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.init(hexString: appColor).cgColor
    }
    
    func showDocumentScreen(){
        let ui = UIStoryboard.init(name: "document", bundle: nil)
        let documentVc = ui.instantiateInitialViewController() as! KETDoumentDriverViewController
        self.navigationController?.pushViewController(documentVc, animated: true)
    }
    
    func pickUpChoice(_ textField : UITextField){
        
        self.choicPickerView = UIPickerView()
        self.choicPickerView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        self.choicPickerView.delegate = self
        self.choicPickerView.dataSource = self
        self.choicPickerView.backgroundColor = .white
        textField.inputView = self.choicPickerView
        textField.tintColor = .white
        // ToolBar
        let toolBar = UIToolbar()
        toolBar.barStyle = .default
        toolBar.barTintColor = UIColor.init(hexString: appColor)
        toolBar.sizeToFit()
        textField.inputAccessoryView = toolBar
        // Adding Button ToolBar
        let doneButton = UIBarButtonItem(title: "Done", style: .plain, target: self, action: #selector(doneClick))
        
        doneButton.tintColor = .white
        let spaceButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelClick))
        cancelButton.tintColor = .white
        toolBar.setItems([cancelButton, spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        
    }
    
    func dismisskeybaord(){
        self.cityTextFiled.resignFirstResponder()
        self.vechicleTypeTextFiled.resignFirstResponder()
        self.vechicleModelTextFiled.resignFirstResponder()
    }
    
    @objc func doneClick() {
        if let data = self.selectedData{
            if self.selectedTextField == self.cityTextFiled {
                self.cityTextFiled.text = data
            }else if self.selectedTextField == self.vechicleTypeTextFiled{
                self.vechicleTypeTextFiled.text = data
            }else if self.selectedTextField == self.vechicleModelTextFiled {
                self.vechicleModelTextFiled.text = data
            }
        }
        self.dismisskeybaord()
    }
    
    @objc func cancelClick() {
       self.dismisskeybaord()
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

    @IBAction func doClickDropDown(_ sender: Any) {
        let button = sender as! UIButton
        if button.tag == ButtonType.City.hashValue{
           self.cityTextFiled.becomeFirstResponder()
        }else if button.tag == ButtonType.VechicleTyle.hashValue{
            self.vechicleTypeTextFiled.becomeFirstResponder()
        }else if button.tag == ButtonType.VechicleModel.hashValue{
            self.vechicleModelTextFiled.becomeFirstResponder()
        }
    }
    
    @IBAction func doClickNext(_ sender: Any) {
        self.showDocumentScreen()
    }
    

}

extension KETVechicleInformationViewController:UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerData?.count ?? 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerData?[row] ?? ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        self.selectedData = self.pickerData?[row]
        
    }
}

extension KETVechicleInformationViewController:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.selectedTextField = textField
        if textField == self.cityTextFiled {
            pickerData = ["Phnom Penh","Siem Reap","Batambong","Kandal","Kompong Cham"]
        }else if textField == self.vechicleTypeTextFiled {
            pickerData = ["Classic","Rickshaw","SUV","Khmer Tuk Tuk"]
        }else if textField == self.vechicleModelTextFiled {
             pickerData = ["Honda","Toyota","Honda","Honda"]
        }
        self.pickUpChoice(textField)
    }
}


