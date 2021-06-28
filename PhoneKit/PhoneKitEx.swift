//
//  PhoneKitEx.swift
//  LocationPicker
//
//  Created by Salah on 5/28/20.
//  Copyright © 2020 Salah. All rights reserved.
//

import Foundation

//extension Bundle{
//    class var framwWorkBundle:Bundle?{
//        let podBundle = Bundle(for: CountryViewController.self)
//        if let bundleURL:URL = podBundle.url(forResource: "PhoneKit", withExtension: "bundle"){
//        return Bundle(url: bundleURL)
//        }
//        return nil;
//    }
//}
///CountryListManager.bundle
public typealias SelectedHandler = (CountryCode)->Void
public typealias CancelHandler = ()->Void

extension Bundle {
    static var module: Bundle? = {
        
        //firstBundle -> this will used when libarary used in example
        if let firstBundle = Bundle(path: "\(Bundle.main.bundlePath)/Frameworks/PhoneKit.framework/PhoneKit.bundle"),FileManager.default.fileExists(atPath: firstBundle.bundlePath){
        
    return firstBundle
    }else
        //secondBundle -> this will used when libarary used in pods
if let secondBundle:Bundle = Bundle(path: "\(Bundle.main.bundlePath)/Frameworks/PhoneKit.framework"),FileManager.default.fileExists(atPath: secondBundle.bundlePath){
            return secondBundle;
    }
      return nil
    }()
}

extension String{
     var customLocalize_ : String {
        return NSLocalizedString(self, tableName: nil, bundle:Bundle.module ?? Bundle.main, value: "", comment: "")
    }
     func bs_replace(target: String, withString: String) -> String {
        
        return self.replacingOccurrences(of: target, with:withString, options: .literal, range: nil)
    }
     func bs_arNumberToEn()-> String {
        let numbersDictionary : Dictionary = ["٠" : "0","١" : "1", "٢" : "2", "٣" : "3", "٤" : "4", "٥" : "5", "٦" : "6", "٧" : "7", "٨" : "8", "٩" : "9"]
        var str : String = self
        
        for (key,value) in numbersDictionary {
            str =  str.replacingOccurrences(of: key, with: value)
        }
        return str
    }
}
extension UIViewController{
     func bs_showMessageWithTitle(title:String,message:String?)
     {
         let alert = UIAlertController(title:title, message:message, preferredStyle:UIAlertController.Style.alert)
         alert.addAction(UIAlertAction(title: "تم", style:UIAlertAction.Style.default, handler: nil))
         self.present(alert, animated: true, completion: nil)
     }
}

extension UIAlertController{
    
    public static func show(_ senderView:UIView,_ parentViewController:UIViewController? = UIApplication.shared.windows.first?.rootViewController,selectedHandler:SelectedHandler?,cancelHandler:CancelHandler?=nil){
            let alertController:UIAlertController = UIAlertController.init(title:"\n\n\n\n\n\n\n\n\n\n\n\n", message:"\n\n\n\n\n", preferredStyle: UIAlertController.Style.actionSheet);
        var customView = AlertView.instanceFromNib();
        customView.update(selectedHandler, alertController);
        let parent = alertController.view.subviews[0].subviews[0];
        parent.addSubview(customView)
        
        customView.translatesAutoresizingMaskIntoConstraints = false

        parent.addConstraint(NSLayoutConstraint(item: customView, attribute: .trailing, relatedBy: .equal, toItem: parent, attribute: .trailing, multiplier: 1, constant: 0))
        parent.addConstraint(NSLayoutConstraint(item: customView, attribute: .leading, relatedBy: .equal, toItem: parent, attribute: .leading, multiplier: 1, constant: 0))
        parent.addConstraint(NSLayoutConstraint(item: customView, attribute: .top, relatedBy: .equal, toItem: parent, attribute: .top, multiplier: 1, constant: 0))
        parent.addConstraint(NSLayoutConstraint(item: customView, attribute: .bottom, relatedBy: .equal, toItem: parent, attribute: .bottom, multiplier: 1, constant: 0))
        
        alertController.addAction(UIAlertAction.init(title:"Cancel".customLocalize_, style:.cancel, handler: { (alertAction) in
            alertController.dismiss(animated: false, completion: {
                cancelHandler?();
            });
            }))
        var popPresenter:UIPopoverPresentationController? = alertController.popoverPresentationController
        popPresenter?.sourceView = senderView;
        popPresenter?.sourceRect = senderView.bounds;
        parentViewController?.present(alertController, animated: true, completion:{
        });
        }
}
 extension Array where Element == CountryCode {
    public func search(text:String)->[CountryCode]{
       let tempSearchArray = self.filter({ (object) -> Bool in
        return (object.dial_code?.contains(text) ?? false || object.name?.uppercased().contains(text.uppercased()) ?? false || object.localizeName()?.contains(text) ?? false || object.code?.contains(text) ?? false )
        });
        return tempSearchArray;
    }
}
