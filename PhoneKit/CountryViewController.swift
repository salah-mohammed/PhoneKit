//
//  CountryViewController.swift
//  Concierge
//
//  Created by sondos on 1/20/19.
//  Copyright © 2019 NewLine. All rights reserved.
//

import UIKit

public class CountryViewController: UIViewController,UITextFieldDelegate {
    public typealias SelectedHandler = (CountryCodes)->Void
    public var selectedHandler:SelectedHandler?
    @IBOutlet weak var tableViewCountry: UITableView!
    private var countryCode : String?
    var countryObj : CountryCodes?
    var primaryArray: [CountryCodes] = [CountryCodes](){
        didSet{
            self.searchArray = primaryArray;
        }
    }
    var searchArray: [CountryCodes] = [CountryCodes]();
    @IBOutlet weak var txtSearch: UITextField!
    override public func viewDidLoad() {
        super.viewDidLoad()

        tableViewCountry.delegate = self
        tableViewCountry.dataSource = self
        getDataFromJSON()
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
        self.searchArray = self.search(text: sender.text!);
        }else{
        self.searchArray = self.primaryArray;
        }
        self.tableViewCountry.reloadData();
    }
    func search(text:String)->[CountryCodes]{
       let tempSearchArray = self.primaryArray.filter({ (object) -> Bool in
        return (object.dial_code?.contains(text) ?? false || object.name?.uppercased().contains(text.uppercased()) ?? false || object.localizeName()?.contains(text) ?? false || object.code?.contains(text) ?? false )
        });
        return tempSearchArray;
    }
        public static func initPicker()->CountryViewController?{
            FramwWorkConstants.frameWorkBundle = Bundle.framwWorkBundle;
            if let storyboard:UIStoryboard = UIStoryboard.init(name: "PhoneKit", bundle:Bundle(for: CountryViewController.self)),
                let vc = storyboard.instantiateViewController(withIdentifier:"CountryViewController") as? CountryViewController{

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

