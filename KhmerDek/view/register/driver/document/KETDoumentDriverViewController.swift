//
//  KETDoumentDriverViewController.swift
//  KhmerDek
//
//  Created by moeung Theara on 7/27/18.
//  Copyright © 2018 moeung Theara. All rights reserved.
//

import UIKit
enum RowType:Int{
    case logo
    case stepProgressBar
    case textField
    case button
}

class RowDocument:NSObject{
    var type:Int?
    var objectValue:KETDocument?
    var isError:Bool = false
}

class KETDoumentDriverViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    var uploadIndex:Int?
    var picker:UIImagePickerController?
    var selectedTextField:UITextField?
    var dataSource = [RowDocument]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initnavigationBar()
        self.initDataSource()
        self.initElement()
        self.addNotificationKeyboard()
        self.initTableView()
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    
    }
    
   
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        NotificationCenter.default.removeObserver(self)
    }
    
    func initTableView(){
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.rowHeight = UITableViewAutomaticDimension
        self.tableView.estimatedRowHeight = 200
        self.registerCell()
    }
    
    func initDataSource(){
        let logoImageRow = RowDocument()
        logoImageRow.type = RowType.logo.hashValue
        self.dataSource.append(logoImageRow)
        let stepProgressBarRow = RowDocument()
        stepProgressBarRow.type = RowType.stepProgressBar.hashValue
        self.dataSource.append(stepProgressBarRow)
        
        let textFieldList = self.initDefaultDocumentTextField()
        for field in textFieldList{
            let row = RowDocument()
            row.type = RowType.textField.hashValue
            row.objectValue = field
            self.dataSource.append(row)
        }
        
        let buttonRow = RowDocument()
        buttonRow.type = RowType.button.hashValue
        self.dataSource.append(buttonRow)
        
    }
    
    func initDefaultDocumentTextField() -> [KETDocument]{
        var documentList = [KETDocument]()
        let vechicleId = KETDocument()
        vechicleId.id = "1"
        vechicleId.title = "Vechicle ID"
        documentList.append(vechicleId)
        
        let nationalId = KETDocument()
        nationalId.id = "2"
        nationalId.title = "National ID"
        documentList.append(nationalId)
        
        let drivingId = KETDocument()
        drivingId.id = "3"
        drivingId.title = "Driving License"
        documentList.append(drivingId)
        
        return documentList
    }
    
    func registerCell(){
        let nib = UINib.init(nibName: "textfieldcell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: "textfieldcell")
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
                        self.tableView.setContentOffset( CGPoint.init(x: 0, y:point.y - keyboardHeight), animated: true)
                    }
                }
                
            }
            
        }
    }
    
    @objc func keyboardWillHide(_ notification: NSNotification){
        self.tableView.setContentOffset(CGPoint.init(x: 0, y: 0), animated: true)
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
        
    }

    func showChoosingPhotoAlert(index:Int){
        let title = self.dataSource[index].objectValue?.title ?? ""
        let actionSheetController: UIAlertController = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        
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
  
    
    
    func showErrorIfNeeded()->Bool{
        var isCan = false
        for data in self.dataSource {
            if data.type == RowType.textField.hashValue{
                if data.objectValue?.value == nil{
                    data.isError = true
                }else{
                    data.isError = false
                }
            }
        }
        
        for data in self.dataSource{
            if data.type == RowType.textField.hashValue{
                if data.isError == true{
                    isCan = false
                }else{
                    if isCan == true{
                         isCan = true
                    }
                }
            }
        }
        return isCan
        
    }
    
    func isCanRegister() -> Bool{
        
        return self.showErrorIfNeeded()
    }
    
    
    @IBAction func doClickRegister(_ sender: Any) {
        if isCanRegister(){
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    

}


extension KETDoumentDriverViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data =  self.dataSource[indexPath.row]
        if data.type == RowType.logo.hashValue {
            let logoCell = tableView.dequeueReusableCell(withIdentifier: "logocell", for: indexPath)
            
            return logoCell
        }else if data.type == RowType.stepProgressBar.hashValue{
            let progressCell = tableView.dequeueReusableCell(withIdentifier: "stepprogressbarcell", for: indexPath)
            return progressCell
        }else if data.type == RowType.textField.hashValue{
            let textfieldCell = tableView.dequeueReusableCell(withIdentifier:"textfieldcell", for: indexPath) as! KETTextFieldTableViewCell
            textfieldCell.delegate = self
            textfieldCell.customCell(data: data,row: indexPath.row)
            
            return textfieldCell
        }else if data.type == RowType.button.hashValue{
            let buttonCell = tableView.dequeueReusableCell(withIdentifier: "buttoncell", for: indexPath) as! KETButtonTableViewCell
            buttonCell.delegate = self
            return buttonCell
        }
        return UITableViewCell()
    }
}

extension KETDoumentDriverViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.row == RowType.logo.hashValue{
            return (screenWidth*0.9)*0.25
        }else if indexPath.row == RowType.stepProgressBar.hashValue{
            return (screenWidth*0.9)*0.22
        }else{
            return UITableViewAutomaticDimension
        }
    }
}

extension KETDoumentDriverViewController:KETextFieldDelegate,KETButtonDelegate{
    func doClickUpload(index: Int) {
        print("indexx===\(index)")
        self.uploadIndex = index
        self.showChoosingPhotoAlert(index:index)
    }
    
    func doClickRegister() {
        if isCanRegister(){
            
        }else{
            self.tableView.reloadData()
        }
    }
}


extension KETDoumentDriverViewController:UIImagePickerControllerDelegate,UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        print(chosenImage)
        if let index = self.uploadIndex{
            self.dataSource[index].objectValue?.value = "678887"
            self.dataSource[index].isError = false
            self.tableView.reloadRows(at: [IndexPath.init(row: index, section: 0)], with: .none)
        }
        
        dismiss(animated: true, completion: nil)
    }
}







