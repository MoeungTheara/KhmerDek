//
//  KETDriverInformationViewController.swift
//  KhmerDek
//
//  Created by moeung Theara on 7/27/18.
//  Copyright © 2018 moeung Theara. All rights reserved.
//

import UIKit

class KETDriverInformationViewController: UIViewController {
    @IBOutlet weak var stepProgressBar: SteppedProgressBar!
    @IBOutlet weak var validateMessageLabel: UILabel!
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var profileButton: UIButton!
    @IBOutlet weak var nextButron: UIButton!
    @IBOutlet weak var nameTextfiled: UITextField!
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var logoImageView: UIImageView!
    var picker:UIImagePickerController?
    var driverImage:UIImage?
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initnavigationBar()
        self.initStepProgressBar()
        self.initElement()
        self.addNotificationKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
       
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        self.initData()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.height*0.5
        self.profileImageView.clipsToBounds = true
        self.scrollView.contentSize = CGSize.init(width: screenWidth, height: screenheight*1.1)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    
    func addNotificationKeyboard(){
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidShow(_:)), name: NSNotification.Name.UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector:#selector(self.keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    @objc func keyboardDidShow(_ notification: NSNotification){
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            if let y = self.nameTextfiled?.frame.origin.y {
                    if y > keyboardHeight{
                        self.scrollView.setContentOffset( CGPoint.init(x: 0, y:y - keyboardHeight*0.8), animated: true)
                    }
                
                
            }
            
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification){
        self.scrollView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
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
    
    func initStepProgressBar(){
        let title = KETRegisterHelper.getDriverTitleProgressbar()
        KETRegisterHelper.initStepProgressBar(stepProgressBar: self.stepProgressBar,width:screenWidth*0.92, numberOfItem: 6, indexSelected: 3, titles: title)
        let width = (screenWidth*0.92) / CGFloat(title.count)
        self.stepProgressBar.widthTitle = width
        self.stepProgressBar.titleFont = UIFont.boldSystemFont(ofSize: 8.5)
        
        
    }
    
    func initElement(){
        self.picker = UIImagePickerController()
        picker?.delegate = self
        self.nextButron.backgroundColor = UIColor.init(hexString: appColor)
        self.nextButron.setTitle("Next", for: .normal)
        self.nextButron.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.nextButron.layer.cornerRadius = 10
        self.nextButron.clipsToBounds = true
        self.nextButron.setTitleColor(.white, for: .normal)
        
        KETRegisterHelper.SetRoundView(view: self.nameTextfiled, raduis: self.nameTextfiled.frame.height*0.2)
        
        self.profileButton.setImage(#imageLiteral(resourceName: "camera").withRenderingMode(.alwaysTemplate), for: .normal)
        self.profileButton.tintColor = .white
        self.profileImageView.layer.cornerRadius = self.profileImageView.frame.height*0.5
        self.profileImageView.clipsToBounds = true
        self.profileImageView.backgroundColor = UIColor.init(hexString: redColor)
        self.nameTextfiled.placeholder = "username"
        self.nameTextfiled.delegate = self
        self.nameTextfiled.returnKeyType = .done
        KETRegisterHelper.hideError(label: self.validateMessageLabel)
        self.addDidChangeTextTo(textFiled: self.nameTextfiled)
    }
    
    func initData(){
        if self.profileImageView.image != nil {
            self.profileButton.setImage(nil, for: .normal)
        }else{
            self.profileButton.setImage(#imageLiteral(resourceName: "camera").withRenderingMode(.alwaysTemplate), for: .normal)
            self.profileButton.tintColor = .white
        }
    }
    
    func addDidChangeTextTo(textFiled:UITextField){
        textFiled.addTarget(self, action: #selector(textFieldDidChange(textField:)), for: .editingChanged)
    }
    
    func showVechicleInformationScreen(){
        let ui = UIStoryboard.init(name: "vechicle_information", bundle: nil)
        let vechicleVc = ui.instantiateInitialViewController() as! KETVechicleInformationViewController
        self.navigationController?.pushViewController(vechicleVc, animated: true)
    }
    
    func showUploadPhotoRequire(){
        self.nameTextfiled.resignFirstResponder()
        let alert = UIAlertController(title: "Photo required", message: "Please choose a photo to continue", preferredStyle: UIAlertControllerStyle.alert)
    
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showChoosingPhotoAlert(){
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let cameraAction: UIAlertAction = UIAlertAction(title: "Camera", style: .default) { action -> Void in
            self.openCamera()
        }
        
        let photoAction: UIAlertAction = UIAlertAction(title: "Photo Album", style: .default) { action -> Void in
            self.openGallary()
        }
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Cancel", style: .cancel) { action -> Void in }
        
   
        actionSheetController.addAction(cameraAction)
        actionSheetController.addAction(photoAction)
        actionSheetController.addAction(cancelAction)
        
        self.present(actionSheetController, animated: true, completion: nil)
    }
    
    func openGallary(){
        picker!.allowsEditing = false
        picker!.sourceType = UIImagePickerControllerSourceType.photoLibrary
        present(picker!, animated: true, completion: nil)
    }
    
    func openCamera(){
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerControllerSourceType.camera)){
            picker!.allowsEditing = false
            picker!.sourceType = UIImagePickerControllerSourceType.camera
            picker!.cameraCaptureMode = .photo
            present(picker!, animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Camera Not Found", message: "This device has no Camera", preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style:.default, handler: nil)
            alert.addAction(ok)
            present(alert, animated: true, completion: nil)
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
        if nameTextfiled.text?.isEmpty == true{
            self.showError(textFiled: nameTextfiled)
        }
        if self.driverImage == nil {
            self.showUploadPhotoRequire()
        }
        if self.driverImage != nil && nameTextfiled.text?.count != 0{
            isCan = true
        }else{
            isCan = false
        }
        
        return isCan
    }
    
    @IBAction func doClickNext(_ sender: Any) {
        if isCanGoToNext() {
            self.showVechicleInformationScreen()
        }
    }
    

    @IBAction func doClickChoosePhoto(_ sender: Any) {
        self.showChoosingPhotoAlert()
    }
    
    
}

extension KETDriverInformationViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
         dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        self.driverImage = chosenImage
        profileImageView.contentMode = .scaleAspectFill
        profileImageView.image = chosenImage
        self.initData()
        dismiss(animated: true, completion: nil)
    }
}

extension KETDriverInformationViewController:UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.nameTextfiled.resignFirstResponder()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.isEmpty == true{
            self.showError(textFiled: textField)
        }else{
            self.hideError(textField: textField)
          
        }
    }
    
    @objc func textFieldDidChange(textField: UITextField){
        if textField.text?.isEmpty == false{
            self.hideError(textField: textField)
        }else{
            
        }
        print("Text changed")
        
    }
    
}




