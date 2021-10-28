//
//  CountryViewController.swift
//  Concierge
//
//  Created by sondos on 1/20/19.
//  Copyright © 2019 NewLine. All rights reserved.
//

import UIKit

private  class CountryViewController: UIViewController,UITextFieldDelegate {
    public var selectedHandler:SelectedHandler?
    @IBOutlet weak var tableViewCountry: UITableView!
    private var countryCode : String?
    var countryObj : CountryCode?
    var primaryArray: [CountryCode] = [CountryCode](){
        didSet{
            self.searchArray = primaryArray;
        }
    }
    var searchArray: [CountryCode] = [CountryCode]();
    @IBOutlet weak var txtSearch: UITextField!
    override public func viewDidLoad() {
        super.viewDidLoad()

        tableViewCountry.delegate = self
        tableViewCountry.dataSource = self
        getDataFromJSON()
        txtSearch.placeholder = "Search".customLocalize_;
    }
    override public func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        self.view.backgroundColor=UIColor.black.withAlphaComponent(0.4);
    }
    override public func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated);
        self.view.backgroundColor=UIColor.clear;
    }
    func getDataFromJSON(){
        self.primaryArray =  CountryListManager.shared.getDataFromJSON() ?? []
    }
    
    func search(dial_code : String) {
        
        var row = 0
        for index in 0..<primaryArray.count {
            if primaryArray[index].dial_code == dial_code {
                row = index
                break
            }
        }
        
        let indexPath = IndexPath(row: row, section: 0)
        tableViewCountry.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)

    }
    
    func alert(msg : String){
        let alert = UIAlertController(title: "Alert", message: msg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func btnCancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    @IBAction func txtTxtSearch(_ sender: UITextField) {
        if sender.text?.count ?? 0 != 0 {
            self.searchArray = self.primaryArray.search(text: sender.text!);
        }else{
        self.searchArray = self.primaryArray;
        }
        self.tableViewCountry.reloadData();
    }
    public static func initPicker()->CountryViewController?{
            let storyboard:UIStoryboard = UIStoryboard.init(name: "PhoneKit", bundle:Bundle.module ?? Bundle.main)
            if let vc = storyboard.instantiateViewController(withIdentifier:"CountryViewController") as? CountryViewController{

            return vc;
        }
            return nil;
    }
}

extension CountryViewController: UITableViewDelegate {
   
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
         let countryObject = self.searchArray[indexPath.row]
         selectedHandler?(countryObject)
         self.dismiss(animated: true, completion: nil)
         tableView.deselectRow(at: indexPath, animated: true);
    }
   
}

extension CountryViewController: UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.searchArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CountryTableViewCell") as! CountryTableViewCell
        let countryObject = self.searchArray[indexPath.row]
        cell.countryObj = countryObject
        cell.configureCell()

        return cell
    }
}

