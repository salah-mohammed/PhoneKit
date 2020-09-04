//
//  CustomCountryPickerViewController.swift
//  PhoneKitExample
//
//  Created by Salah on 9/4/20.
//  Copyright © 2020 Salah. All rights reserved.
//

import UIKit
import PhoneKit
class CustomCountryPickerViewController: UIViewController {
    var objects:[CountryCode]=[CountryCode]();
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.delegate=self;
        self.tableView.dataSource=self;
       objects = CountryListManager.shared.getDataFromJSON() ?? []
        self.tableView.reloadData();
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension CustomCountryPickerViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell:CustomCountryPickerTableViewCell = tableView.dequeueReusableCell(withIdentifier:"CustomCountryPickerTableViewCell", for: indexPath) as! CustomCountryPickerTableViewCell
        cell.countryObj=self.objects[indexPath.row];
        cell.configureCell();
    return cell
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.objects.count;
    }
}
