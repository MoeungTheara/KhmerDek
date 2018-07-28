//
//  KETCountryCodePopupViewController.swift
//  KhmerDek
//
//  Created by moeung Theara on 7/27/18.
//  Copyright © 2018 moeung Theara. All rights reserved.
//

import UIKit

class KETCountryCodePopupViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var containerView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initElement()
        self.initTableView()
        self.setUpSearchBar()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setUpSearchBar(){
        self.searchbar.searchBarStyle = .default
        self.searchbar.barTintColor = .white
        self.searchbar.placeholder = "Search..."
        self.searchbar.textField?.backgroundColor = .white
        searchbar.textField?.leftViewMode = .never
        searchbar.setBackgroundImage(UIImage.init(), for: UIBarPosition.any, barMetrics: UIBarMetrics.default)
        UISearchBar.appearance().searchTextPositionAdjustment = UIOffsetMake(0, 0)
    }
    
    func initElement(){
        self.view.backgroundColor = UIColor.black.withAlphaComponent(0.7)
        self.titleLabel.font = UIFont.boldSystemFont(ofSize: 22)
        self.titleLabel.text = "Select Country"

    }
    
    func initTableView(){
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }


}


extension KETCountryCodePopupViewController:UITableViewDataSource{
    
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countrycodecell", for: indexPath)
        return cell
    }
}

extension KETCountryCodePopupViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("did select")
    }
}


class KETCountryCodeTableViewCell:UITableViewCell{
    @IBOutlet weak var countryImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    
}
