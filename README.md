# Result

![alt text](https://github.com/salah-mohammed/PhoneKit/blob/master/PhoneKitExample/example.gif)

# PhoneKit

PhoneKit used for make threat with Phone Number that have different prefix (00, +, not), make the treatment easier .
# Advantages
* Contain country picker with dial number.
* You can make custom country picker.
* can get country object from phone number .
* can get current country.
* Check if two numbers is equalled or not , with prefix 00 or + or without will work succefully.

# Requirements
* IOS 13+ 
* Swift 5+

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
- Get country object from string fullPohonenumber

```swift

if let phoneNumberItem:(CountryCode?,String?) = CountryListManager.shared.phoneNumber(fullPhoneNumber:"+966597105861"){

}

 ```
 
- Print Phone number 

First:withZero , Second:withPluse , Thired:Without prefix .
 
 ```swift

CountryListManager.shared.phoneNumber(phoneNumberType: .zerozero, countryCode: countryObject, phoneNumber: self.txtPhoneNumber.text)
CountryListManager.shared.phoneNumber(phoneNumberType: .pluse, countryCode: countryObject, phoneNumber: self.txtPhoneNumber.text);
CountryListManager.shared.phoneNumber(phoneNumberType: .none, countryCode: countryObject, phoneNumber: self.txtPhoneNumber.text);
```
- Get all countries to make custom country picker for phone number picker

 ```swift

self.primaryArray =  CountryListManager.shared.getDataFromJSON() ?? []

 ```
# Configure Successfully

## License

NavigationKit is released under the MIT license. [See LICENSE](https://github.com/salah-mohammed/PhoneKit/blob/master/LICENSE) for details.

# Developer's information to communicate

- salah.mohamed_1995@hotmail.com
- https://www.facebook.com/salah.shaker.7
