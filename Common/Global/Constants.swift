//
//  Constants.swift
//  FastShare
//
//  Created by Fullname on 1/17/19.
//  Copyright © 2019 Fullname. All rights reserved.
//

import UIKit

let SCREEN_WIDTH = UIScreen.main.bounds.size.width
let SCREEN_HEIGHT = UIScreen.main.bounds.size.height

let all = ""
let viettel = "1"
let vina = "2"
let mobile = "3"
let nonTelecom = -1


enum ControllerId: Int {
    case CartListViewController = 1
    case CreateNewCartViewController = 2
}

let accessToken = "accessToken"
let number_phone_key = "number_phone_key"
let user_address_key = "user_address_key"
let passwork_key = "passwork_key"
let fullName = "fullName"
let user_role_key = "user_role_key"
let quickly_hold_sim = "quickly_hold_sim"
let copy_ctv_sim_price = "copy_ctv_sim_price"

let error_check_internet = "Không có kết nối mạng"
enum ControllerID : Int {
    case Login = 0
    case Main = 1
    case Register = 2
    case Search
    case ForgotPassword
    case ChangePassword

}

enum ProfileControllerID : Int {
    case UpdateProfile
    case ChangePassword
}

enum DebtControllerID : Int {
     case Liability
}

enum SimStatus : Int {
    case new
    case processing
    case done
}

enum Telecom : Int {
    case viettel = 1
    case mobile = 3
    case vina = 2
}

enum ChangeProfileImage : Int {
    case avatar = 1
    case cmnd1 = 3
    case cmnd2 = 2
}

struct UserDefaultsKey {
    static let AccessToken = "AccessToken"
    static let UserLogin = "UserLogin"
    static let IndexIntro = "IndexIntro"
     static let SimCategory = "SimCategory"
}

struct SearchSimType {
    static let Telecom = "Telecom"
    static let Price = "Price"
    static let NiceNumber = "NiceNumber"
}



func getControllerFromProfile(id:ProfileControllerID) -> UIViewController {
    var newController : UIViewController
    let storyboard = UIStoryboard.init(name: "Profile", bundle: nil)
    switch id {
    case .UpdateProfile:
        newController = storyboard.instantiateViewController(withIdentifier: "UpdateProfileViewController")
    case .ChangePassword :
        newController = storyboard.instantiateViewController(withIdentifier: "ChangePasswordViewController")
    }
    
    return newController
}

func getControllerFromHome (id : ControllerID) -> UIViewController {
    var newController : UIViewController
    let storyboard = UIStoryboard.init(name: "Home", bundle: nil)
    
    switch id {
    case .Login:
        newController = storyboard.instantiateViewController(withIdentifier: "LoginViewController")
    case .Main :
        newController = storyboard.instantiateViewController(withIdentifier: "TabBarViewController")
    case .Register:
        newController = storyboard.instantiateViewController(withIdentifier: "registerController") as! LoginViewController
    case .Search:
        newController = storyboard.instantiateViewController(withIdentifier: "searhViewController") as! LoginViewController
    case .ForgotPassword:
        newController = storyboard.instantiateViewController(withIdentifier: "forgotpassController")
    case .ChangePassword:
        newController = storyboard.instantiateViewController(withIdentifier: "changepassController")

    }
    
    return newController
}

func getControllerFromDebt(id:DebtControllerID) -> UIViewController {
    var newController : UIViewController
    let storyboard = UIStoryboard.init(name: "Debt", bundle: nil)
    switch id {
    case .Liability:
        newController = storyboard.instantiateViewController(withIdentifier: "LiabilityViewController")
    }
    
    return newController
}

struct K {
    struct ProductionServer {
        static let baseURL = "http://adong-api-dev.zamio.net/api/"
    }
    
    struct APIParameterKey {
        static let password = "password"
        static let email = "username"
    }
}

enum HTTPHeaderField: String {
    case authentication = "Authorization"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
    case token = "Bearer eyJ0eXBlIjoiSldUIiwiYWxnIjoiSFM1MTIifQ.eyJzdWIiOiJhZG1pbiIsImF1ZCI6InNpbXBsZS1jbGllbnQiLCJpc3MiOiJTaW1wbGVBUEkiLCJyb2xlcyI6WyJRdeG6o24gbMO9IHbhuq10IHTGsCIsIkvhur8gdG_DoW4iLCJRdeG6o24gbMO9IHbDuW5nIiwiVGjGsCBrw70iLCJUw6BpIHjhur8iLCJRdeG6o24gbMO9IMSR4buZaSB4ZSIsIlRo4bunIGtobyIsIkFkbWluaXN0cmF0b3IiLCLEkOG7mWkgdHLGsOG7n25nIC8gR2nDoW0gc8OhdCJdLCJ1c2VySWQiOjEsInVzZXJuYW1lIjoiYWRtaW4ifQ.pAt8o_PilsZDpep3Snvz-851Hr6Ky5Vv8_O51eCsA7TGZfTCJze7jZECBF5yNJq8rcbccIk0L1XVRLPmHwnVBw"
}
