//
//  KETVechicleInfoPopupViewController.swift
//  KhmerDek
//
//  Created by moeung Theara on 7/27/18.
//  Copyright © 2018 moeung Theara. All rights reserved.
//

import UIKit

class KETVechicleInfoPopupViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initElement()
        self.initTableView()
    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
       
    }
    
    func initElement(){
        self.view.layer.borderWidth = 1
        self.view.layer.borderColor = UIColor.init(hexString: appColor).cgColor
    }
    
    func initTableView(){
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }
    


}

extension KETVechicleInfoPopupViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "Taxi"
        return cell
    }
}

extension KETVechicleInfoPopupViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
}





