# Result

![alt text](https://github.com/salah-mohammed/NavigationKit/blob/master/NavigationKitExample/example.gif)

# NavigationKit

Navigation Kit used for make threat with screen that have differents navigation bar style, make change style of bar easy.
# Advantages
* Contain country picker with dial number.
* You can make custom country picker.
* can get country object from phone number .
* can get current country.
* Check if two numbers is equalled or not , with prefix 00 or + or without will work succefully.

# How used (configuration): 
# Pod install
```ruby
pod 'PhoneKit',:git => "https://github.com/salah-mohammed/PhoneKit.git"
 
```
- If You wan use country picker of libarary 

```swift
        self.countryViewController = CountryViewController.initPicker();
        self.countryViewController?.selectedHandler = { object in
        self.countryObject = object;
      }
    self.present(countryViewController!, animated: true, completion: nil);
```
- get country object from string fullPohonenumber

```swift

if let phoneNumberItem:(CountryCode?,String?) = CountryListManager.shared.phoneNumber(fullPhoneNumber:"+966597105861"){

}

 ```
 
 PrintPhone number .
 
 ```swift

CountryListManager.shared.phoneNumber(phoneNumberType: .zerozero, countryCode: countryObject, phoneNumber: self.txtPhoneNumber.text)
CountryListManager.shared.phoneNumber(phoneNumberType: .pluse, countryCode: countryObject, phoneNumber: self.txtPhoneNumber.text);
CountryListManager.shared.phoneNumber(phoneNumberType: .none, countryCode: countryObject, phoneNumber: self.txtPhoneNumber.text);
```
if you want to hide Navigation bar.

 ```swift
 class ThiredViewController: UIViewController,NavigationDelegate {

    var navigationData: NavigationData=NavigationData.init(NavigationManager.NavigationStyle.hide);
    
        public override func viewDidLoad() {
        super.viewDidLoad()
    }
}
 ```

if you want to set background image for Navigation bar and set title color for it.

 ```swift
 class ForthViewController: UIViewController,NavigationDelegate {

    var navigationData: NavigationData=NavigationData.init(NavigationManager.NavigationStyle.custom(NavigationManager.BarColor.backgroundImage(UIImage.init(named:"navigationImage")!), titleColor: UIColor.white))
    
        public override func viewDidLoad() {
        super.viewDidLoad()
    }
}
 ```
- Thired

if you want to set default style 'if Viewcontroller not implement NavigationInfoDelegate'
```swift
NavigationManager.shared.defaultData = NavigationData.init(NavigationManager.NavigationStyle.custom(NavigationManager.BarColor.customColor(UIColor.blue), titleColor:  UIColor.white))

 ```
# Configure Successfully

# Developer's information to communicate

- salah.mohamed_1995@hotmail.com
- https://www.facebook.com/salah.shaker.7
