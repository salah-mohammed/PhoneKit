//
//  FloatButtonView.swift
//  tesdasdasd
//
//  Created by SalahMohammed on 8/30/20.
//  Copyright © 2019 iMech. All rights reserved.
//

import Foundation
import UIKit


open class AlertView: UIView {
     @IBOutlet open weak var layoutConstraintHeightOfTableView: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet var contentView: UIView!
    var alertController:UIAlertController?
    var items:[CountryCode]=[CountryCode]();
    var primaryArray:[CountryCode]=[CountryCode]();
    open override func layoutSubviews() {
        super.layoutSubviews()

    }
    open override  func awakeFromNib() {
        super.awakeFromNib();
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
//        configureXib()
    }
    func update( _ alertController:UIAlertController?){
        self.alertController=alertController;

        search();
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        configureXib()
    }
    class func instanceFromNib() -> AlertView {
        
        let myView = Bundle.module?.loadNibNamed("AlertView", owner: nil, options: nil)![0] as! AlertView
        myView.configureXib()
        return myView;
        
    }
    private func configureXib() {
        self.primaryArray = CountryListManager.shared.getDataFromJSON() ?? []
        self.tableView.register(UINib.init(nibName:"AlertCountryTableViewCell", bundle: Bundle.module), forCellReuseIdentifier:"AlertCountryTableViewCell");
        searchBar.backgroundColor=UIColor.clear;
        searchBar.barTintColor=UIColor.clear;
        searchBar.setSearchFieldBackgroundImage(nil, for: .normal);
        searchBar.searchBarStyle = .minimal
        searchBar.delegate=self;
        tableView.delegate=self;
        tableView.dataSource=self;
        layoutConstraintHeightOfTableView.constant = UIScreen.main.bounds.height*0.6;
        self.searchBar.autocapitalizationType = .none;
        self.searchBar.placeholder="Search".customLocalize_;
    }
    func search(){
        if self.searchBar.text?.count == 0 {
            self.items = self.primaryArray
        }else{
            self.items = self.search(text: searchBar.text!);
        }
        self.tableView.reloadData();
    }
    func search(text:String)->[CountryCode]{
       let tempSearchArray = self.primaryArray.filter({ (object) -> Bool in
        return (object.dial_code?.contains(text) ?? false || object.name?.uppercased().contains(text.uppercased()) ?? false || object.localizeName()?.contains(text) ?? false || object.code?.contains(text) ?? false )
        });
        return tempSearchArray;
    }
}
extension AlertView:UITableViewDelegate,UITableViewDataSource {
    open func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    open func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier:"AlertCountryTableViewCell", for: indexPath) as! AlertCountryTableViewCell
        cell.contentView.backgroundColor=UIColor.clear;
        cell.backgroundColor=UIColor.clear;
        var object = items[indexPath.row];
        cell.countryObj=object;
        cell.configureCell()
//        cell.textLabel?.text=object.localizeName() ?? "";
//        cell.textLabel?.textAlignment = .center;
//        cell.textLabel?.textColor=UIColor.systemBlue;
//        cell.textLabel?.font=UIFont.systemFont(ofSize: 19, weight: .regular);
        return cell;
    }
    open func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        var object = items[indexPath.row];
        self.alertController?.dismiss(animated: true, completion: {
//            self.selectedHandler?(object);
        });
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return 50;
    }
}
extension AlertView:UISearchBarDelegate{
    public func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        self.search();
    }
    public func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    self.search();
    }
}
