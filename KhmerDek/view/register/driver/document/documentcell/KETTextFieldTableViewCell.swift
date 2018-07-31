//
//  KETTextFieldTableViewCell.swift
//  KhmerDek
//
//  Created by moeung Theara on 7/30/18.
//  Copyright © 2018 moeung Theara. All rights reserved.
//

import UIKit

protocol KETextFieldDelegate {
    func doClickUpload(index:Int)
}

class KETTextFieldTableViewCell: UITableViewCell {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var uploadButton: UIButton!
    var delegate:KETextFieldDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        self.initElement()
    }

    func initElement(){
        KETRegisterHelper.SetRoundView(view: self.textField, raduis: textField.frame.height*0.2)
        self.addImageTouploadButton(button: self.uploadButton)
        
    }
    
    func addImageTouploadButton(button:UIButton){
        let image = #imageLiteral(resourceName: "upload").withRenderingMode(.alwaysTemplate)
        button.setImage(image, for: .normal)
        button.tintColor = UIColor.init(hexString: appColor)
    }
    
    func showErrorIfNeeded(isError:Bool){
        if isError == true{
            textField.layer.borderWidth = 2
            textField.layer.borderColor = UIColor.red.cgColor
            textField.shakeAnimation()
        }else{
            hideError()
        }
    }
    
    func hideError(){
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.init(hexString: appColor).cgColor
    }
    
    func customCell(data:RowDocument,row:Int){
        self.uploadButton.tag = row
        self.textField.placeholder = data.objectValue?.title ?? ""
        if let value = data.objectValue?.value {
            self.textField.text = value
        }
        self.showErrorIfNeeded(isError: data.isError)
    }
    
    @IBAction func doClickUpload(_ sender: Any) {
        self.delegate?.doClickUpload(index: self.uploadButton.tag)
    }
    
}
