//
//  KETCountryCodePopupViewController.swift
//  KhmerDek
//
//  Created by moeung Theara on 7/27/18.
//  Copyright © 2018 moeung Theara. All rights reserved.
//

import UIKit

protocol KETCountryCodeDelegete {
    func didSelectedCountryCode(country:Country)
}

class KETCountryCodePopupViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var borderView: UIView!
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet var containerView: UIView!
    var delegate:KETCountryCodeDelegete?
    private var countryList: [Country] {
        let countries = Countries()
        let countryList = countries.countries
        return countryList
    }
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
        return self.countryList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "countrycodecell", for: indexPath) as! KETCountryCodeTableViewCell
        cell.customCell(country: self.countryList[indexPath.row])
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        self.view.endEditing(true)
    }
}

extension KETCountryCodePopupViewController:UITableViewDelegate{
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.delegate?.didSelectedCountryCode(country: self.countryList[indexPath.row])
    }
}


class KETCountryCodeTableViewCell:UITableViewCell{
 
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var codeLabel: UILabel!
    @IBOutlet weak var flagLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.flagLabel.font = UIFont.systemFont(ofSize: 30)
    }
    func customCell(country:Country){
        self.nameLabel.text = "\(country.name ?? "")(\(country.countryCode))"
        self.codeLabel.text = "+\(country.phoneExtension)"
        self.flagLabel.text = country.flag ?? ""
    }
    
}
