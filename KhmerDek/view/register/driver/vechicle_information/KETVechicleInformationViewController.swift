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
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var vechicleTypeView: UIView!
    
    @IBOutlet weak var stackView: UIStackView!
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
    var cityList:[KETCategory]?
    var vechicleTypeList:[KETCategory]?
    var vechicleModelLidt:[KETCategory]?
    var selectedTextField:UITextField?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initElement()
        self.initData()
        self.initStepProgressBar()
        self.initnavigationBar()
        self.initDropDownButton()
        self.addNotificationKeyboard()
       
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.scrollView.contentSize = CGSize.init(width: screenWidth, height: screenheight*1.1)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    func initData(){
        let citycategory = KETCategory()
        citycategory.id = "1"
        citycategory.name = "Phnom Penh"
        citycategory.isSelected = false
        let citycategory1 = KETCategory()
        citycategory1.id = "2"
        citycategory1.name = "Siem Reap"
        citycategory1.isSelected = false
        let citycategory2 = KETCategory()
        citycategory2.id = "2"
        citycategory2.name = "Batambong"
        citycategory2.isSelected = false
        self.cityList = [citycategory,citycategory1,citycategory2]
        
        let vechicleCategory = KETCategory()
        vechicleCategory.id = "2"
        vechicleCategory.name = "Classic"
        vechicleCategory.isSelected = false
        
        let vechicleCategory1 = KETCategory()
        vechicleCategory1.id = "2"
        vechicleCategory1.name = "Rickshaw"
        vechicleCategory1.isSelected = false
        
        let vechicleCategory2 = KETCategory()
        vechicleCategory2.id = "2"
        vechicleCategory2.name = "SUV"
        vechicleCategory2.isSelected = false
        
        self.vechicleTypeList = [vechicleCategory,vechicleCategory1,vechicleCategory2]
        
        let vechicleModel = KETCategory()
        vechicleModel.id = "2"
        vechicleModel.name = "Honda"
        vechicleModel.isSelected = false
        
        let vechicleModel1 = KETCategory()
        vechicleModel1.id = "2"
        vechicleModel1.name = "Toyota"
        vechicleModel1.isSelected = false
        self.vechicleModelLidt = [vechicleModel,vechicleModel1]

    }
    
    func initElement(){
        
        self.nextButton.backgroundColor = UIColor.init(hexString: appColor)
        self.nextButton.setTitle("Next", for: .normal)
        self.nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.nextButton.layer.cornerRadius = 10
        self.nextButton.clipsToBounds = true
        self.nextButton.setTitleColor(.white, for: .normal)
       
        KETRegisterHelper.SetRoundView(view: self.vechicleNumTextFiled, raduis: self.vechicleNumTextFiled.frame.height*0.2)
        KETRegisterHelper.SetRoundView(view: self.vechicleTypeView, raduis: self.vechicleNumTextFiled.frame.height*0.2)
        KETRegisterHelper.SetRoundView(view: self.vechicleModelView, raduis: self.vechicleNumTextFiled.frame.height*0.2)
        KETRegisterHelper.SetRoundView(view:  self.cityView, raduis: self.vechicleNumTextFiled.frame.height*0.2)
        self.cityButton.tag = ButtonType.City.hashValue
        self.vechicleTypeButton.tag = ButtonType.VechicleTyle.hashValue
        self.vechicleModelButton.tag = ButtonType.VechicleModel.hashValue
        self.setUpTextFiled()
    }
    
    func addNotificationKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidShow(_:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(self.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardDidShow(_ notification: NSNotification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            if let y = self.selectedTextField?.frame.origin {
                if let point = self.selectedTextField?.convert(y, to:self.view) {
                    if point.y > keyboardHeight{
                        self.scrollView.setContentOffset( CGPoint.init(x: 0, y:point.y - keyboardHeight), animated: true)
                    }
                }
                
            }
            
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification){
        self.scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
    }
    
    func setUpTextFiled(){
        self.vechicleNumTextFiled.delegate = self
        self.vechicleModelTextFiled.delegate = self
        self.vechicleTypeTextFiled.delegate = self
        self.vechicleNumTextFiled.delegate = self
        self.cityTextFiled.delegate = self
        self.addDidChangeTextTo(textFiled: vechicleNumTextFiled)
        self.addDidChangeTextTo(textFiled: vechicleModelTextFiled)
        self.addDidChangeTextTo(textFiled: vechicleTypeTextFiled)
        self.addDidChangeTextTo(textFiled: cityTextFiled)
    }
    func addDidChangeTextTo(textFiled:UITextField){
        textFiled.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
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
        self.vechicleNumTextFiled.placeholder = "Vechicle No."
        self.vechicleModelTextFiled.placeholder = "Select Vechicle Model"
        self.vechicleTypeTextFiled.placeholder =  "Select Vechicle Type"
        self.cityTextFiled.placeholder =   "Select City"
    }
    
    func showError(view:UIView){
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor.red.cgColor
    }
    
    func hideError(view:UIView){
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.init(hexString: appColor).cgColor
    }
    
   
    
    func showDocumentScreen(){
        let ui = UIStoryboard.init(name: "document", bundle: nil)
        let documentVc = ui.instantiateInitialViewController() as! KETDoumentDriverViewController
        self.navigationController?.pushViewController(documentVc, animated: true)
    }
    
    func addSeletedData(){
        if self.selectedTextField == self.cityTextFiled{
            var index = 0
            let selectedCity = self.cityList?.filter({$0.isSelected == true})
            if let list = selectedCity{
                if let city = list.first{
                     index = self.cityList?.index(of:city) ?? 0
                    print("index:\(index)")
                }else{
                    self.cityList?[0].isSelected = true
                }
            }
            self.choicPickerView.selectRow(index, inComponent: 0, animated: false)
        }else if self.selectedTextField == self.vechicleTypeTextFiled{
            var index = 0
            let selectedType = self.vechicleTypeList?.filter({$0.isSelected == true})
            if let list = selectedType{
                if let type = list.first{
                      index = self.vechicleTypeList?.index(of:type) ?? 0
                }else{
                    self.vechicleTypeList?[0].isSelected = true
                }
            }
            self.choicPickerView.selectRow(index, inComponent: 0, animated: false)
        }else if self.selectedTextField == self.vechicleModelTextFiled{
            var index = 0
            let selectedModel = self.vechicleModelLidt?.filter({$0.isSelected == true})
            if let list = selectedModel{
                if let model = list.first{
                    index = self.vechicleModelLidt?.index(of: model) ?? 0
                }else{
                    self.vechicleModelLidt?[0].isSelected = true
                }
            }
            self.choicPickerView.selectRow(index, inComponent: 0, animated: false)
        }
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
        self.addSeletedData()
        
    }
    
    func dismisskeybaord(){
        self.cityTextFiled.resignFirstResponder()
        self.vechicleTypeTextFiled.resignFirstResponder()
        self.vechicleModelTextFiled.resignFirstResponder()
    }
    
    func showErrorIfNeeded(textField:UITextField){
       
        if self.vechicleNumTextFiled.text?.count == 0 && textField == self.vechicleNumTextFiled {
            self.showError(view: self.vechicleNumTextFiled)
            self.vechicleNumTextFiled.shakeAnimation()
        }else if self.vechicleNumTextFiled.text?.count != 0{
            self.hideError(view:vechicleNumTextFiled)
        }
        if self.cityTextFiled.text?.count == 0 && textField == self.cityTextFiled {
            self.showError(view: self.cityView)
            self.cityView.shake()
        }else if self.cityTextFiled.text?.count != 0{
            self.hideError(view: cityView)
        }
        
        if self.vechicleTypeTextFiled.text?.count == 0  && textField == self.vechicleTypeTextFiled {
            self.showError(view: self.vechicleTypeView)
            self.vechicleTypeView.shake()
        }else if self.vechicleTypeTextFiled.text?.count != 0{
            self.hideError(view: vechicleTypeView)
        }
        
        if self.vechicleModelTextFiled.text?.count == 0 && textField == self.vechicleModelTextFiled  {
            self.showError(view: self.vechicleModelView)
            self.vechicleModelView.shake()
        }else if self.vechicleModelTextFiled.text?.count != 0{
            self.hideError(view: vechicleModelView)
        }
        
    }
    
    func isCanGoToNext() -> Bool{
        var isCan = false
        self.showErrorIfNeeded(textField: self.vechicleNumTextFiled)
        self.showErrorIfNeeded(textField: self.cityTextFiled)
        self.showErrorIfNeeded(textField: self.vechicleTypeTextFiled)
        self.showErrorIfNeeded(textField: self.vechicleModelTextFiled)
        if self.vechicleNumTextFiled.text?.count != 0 && self.cityTextFiled.text?.count != 0 && self.vechicleTypeTextFiled.text?.count != 0 && self.vechicleModelTextFiled.text?.count != 0 {
            isCan = true
        }
        
        return isCan
    }
    
    @objc func doneClick() {
        
        if self.selectedTextField == self.cityTextFiled {
            if let dataSelected = self.cityList?.filter({$0.isSelected == true }){
                if let city = dataSelected.first{
                     self.cityTextFiled.text = city.name
                }
               
            }
            
        }else if self.selectedTextField == self.vechicleTypeTextFiled{
            if let dataSelected = self.vechicleTypeList?.filter({$0.isSelected == true }){
                if let type = dataSelected.first{
                    self.vechicleTypeTextFiled.text = type.name
                }
            }
        }else if self.selectedTextField == self.vechicleModelTextFiled {
            if let dataSelected = self.vechicleModelLidt?.filter({$0.isSelected == true }){
                if let model = dataSelected.first{
                    self.vechicleModelTextFiled.text = model.name
                }
                
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
        if self.isCanGoToNext(){
            self.showDocumentScreen()
        }
    }
    

}

extension KETVechicleInformationViewController:UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        if selectedTextField == self.cityTextFiled {
            return self.cityList?.count ?? 0
        }else if selectedTextField == self.vechicleTypeTextFiled {
            return self.vechicleTypeList?.count ?? 0
        }else if selectedTextField == self.vechicleModelTextFiled {
            return self.vechicleModelLidt?.count ?? 0
        }
        return 0
    }
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if selectedTextField == self.cityTextFiled {
            return self.cityList?[row].name ?? ""
        }else if selectedTextField == self.vechicleTypeTextFiled {
            return self.vechicleTypeList?[row].name ?? ""
        }else if selectedTextField == self.vechicleModelTextFiled {
            return self.vechicleModelLidt?[row].name ?? ""
        }
        return ""
    }
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if selectedTextField == self.cityTextFiled {
            if let list = self.cityList{
                for (i,city) in list.enumerated(){
                    if i == row{
                        city.isSelected = true
                    }else{
                        city.isSelected = false
                    }
                }
            }
            dump(self.cityList)
            
        }else if selectedTextField == self.vechicleTypeTextFiled {
            if let list = self.vechicleTypeList{
                for (i,type) in list.enumerated(){
                    if i == row{
                        type.isSelected = true
                    }else{
                        type.isSelected = false
                    }
                }
            }
        }else if selectedTextField == self.vechicleModelTextFiled {
            if let list = self.vechicleModelLidt{
                for (i,model) in list.enumerated(){
                    if i == row{
                        model.isSelected = true
                    }else{
                        model.isSelected = false
                    }
                }
            }
        }
        
    }
}

extension KETVechicleInformationViewController:UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.selectedTextField = textField
        if textField == self.vechicleNumTextFiled{
            
        }else{
            self.pickUpChoice(textField)
        }
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.showErrorIfNeeded(textField: textField)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        self.showErrorIfNeeded(textField: textField)
        return true
    }
    @objc func textFieldDidChange(textField: UITextField){
        self.showErrorIfNeeded(textField: textField)
        print("Text changed")
        
    }
}


