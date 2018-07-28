//
//  KETDoumentDriverViewController.swift
//  KhmerDek
//
//  Created by moeung Theara on 7/27/18.
//  Copyright © 2018 moeung Theara. All rights reserved.
//

import UIKit

enum ButtonDoumentType:Int{
    case VechicleID
    case NationalID
    case DrivingLicense
}

class KETDoumentDriverViewController: UIViewController {

    @IBOutlet weak var nationalIdView: UIView!
    @IBOutlet weak var drivingLienseView: UIView!
    @IBOutlet weak var vechicleNoView: UIView!
    @IBOutlet weak var uploadDrivingbutton: UIButton!
    @IBOutlet weak var uploadnationalIdButton: UIButton!
    @IBOutlet weak var uploadVechicleIdButton: UIButton!
    @IBOutlet weak var registerButton: UIButton!
    @IBOutlet weak var drivingLicenseTextFiled: UITextField!
    @IBOutlet weak var nationalIdTextfield: UITextField!
    @IBOutlet weak var vechicleIdTextFiled: UITextField!
    @IBOutlet weak var stepProgressBar: SteppedProgressBar!
    @IBOutlet weak var logoImagaeView: UIImageView!
    var uploadType:Int?
    var picker:UIImagePickerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initStepProgressBar()
        self.initnavigationBar()
        self.initElement()
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
    
    func initStepProgressBar(){
        let title = KETRegisterHelper.getDriverTitleProgressbar()
        KETRegisterHelper.initStepProgressBar(stepProgressBar: self.stepProgressBar,width:screenWidth*0.92, numberOfItem: 6, indexSelected: 5, titles: title)
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
    
    func initElement(){
        self.picker = UIImagePickerController()
        picker?.delegate = self
        self.registerButton.backgroundColor = UIColor.init(hexString: appColor)
        self.registerButton.setTitle("Register", for: .normal)
        self.registerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        self.registerButton.layer.cornerRadius = 10
        self.registerButton.clipsToBounds = true
        self.registerButton.setTitleColor(.white, for: .normal)
        KETRegisterHelper.SetRoundView(view: self.vechicleNoView, raduis: self.vechicleIdTextFiled.frame.height*0.2)
         KETRegisterHelper.SetRoundView(view: self.nationalIdView, raduis: self.nationalIdTextfield.frame.height*0.2)
         KETRegisterHelper.SetRoundView(view: self.drivingLienseView, raduis: self.drivingLicenseTextFiled.frame.height*0.2)
        self.addImageTouploadButton(button: self.uploadDrivingbutton)
        self.addImageTouploadButton(button: self.uploadnationalIdButton)
        self.addImageTouploadButton(button: self.uploadVechicleIdButton)
        self.setPlaceHolderTextField(textField: self.vechicleIdTextFiled, text: "Vechicle ID")
        self.setPlaceHolderTextField(textField: self.nationalIdTextfield , text: "National ID")
        self.setPlaceHolderTextField(textField: self.drivingLicenseTextFiled, text: "Driving License (Optional)")
        self.uploadVechicleIdButton.tag = ButtonDoumentType.VechicleID.hashValue
        self.uploadnationalIdButton.tag = ButtonDoumentType.NationalID.hashValue
        self.uploadDrivingbutton.tag = ButtonDoumentType.DrivingLicense.hashValue
    }
    
    func addImageTouploadButton(button:UIButton){
        let image = #imageLiteral(resourceName: "upload").withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = UIColor.init(hexString: appColor)
    }
    
    func setPlaceHolderTextField(textField:UITextField,text:String){
        textField.attributedPlaceholder = NSAttributedString(string:text, attributes: [NSAttributedStringKey.foregroundColor: UIColor.init(hexString: appColor).withAlphaComponent(0.6)])
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
    
    @IBAction func doClickRegister(_ sender: Any) {
    }
    
    
    @IBAction func doClickUpload(_ sender: Any) {
        let button = sender as! UIButton
        self.uploadType = button.tag
        self.showChoosingPhotoAlert()
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

}



extension KETDoumentDriverViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        print(chosenImage)
        if let type = self.uploadType {
            
            if type == ButtonDoumentType.VechicleID.hashValue{
                
            }else if type == ButtonDoumentType.NationalID.hashValue{
                
            }else if type == ButtonDoumentType.DrivingLicense.hashValue{
                
            }
        }
        dismiss(animated: true, completion: nil)
    }
}

