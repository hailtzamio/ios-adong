//
//  LoginViewController.swift
//  ADongPr
//
//  Created by Cuongvh on 5/19/20.
//  Copyright © 2020 zamio. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: BaseViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }
    
    @IBAction func login(_ sender: Any) {
        gotoNextPage()
//        login4()
    }
    
    func login(fullname:String, password:String) {
        
        MGConnection.request(APIRouter.login(username: "admin", password: "123456"), User.self,completion: {(result, error) in
            guard error == nil else {
                
                return
            }
            
            if let register = result {
                
                print(register.fullName)
                return
            }
        })
    }
    
    func login4() {
        
        showLoading()
        
        let urlString = "http://adong-api-dev.zamio.net/api/login"
        let json = "{\"username\":\"admin\",\"password\":\"123456\"}"
        
        let url = URL(string: urlString)!
        let jsonData = json.data(using: .utf8, allowLossyConversion: false)!
        
        var request = URLRequest(url: url)
        request.httpMethod = HTTPMethod.post.rawValue
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-Type")
        request.httpBody = jsonData
        
        Alamofire.request(request).responseJSON {
            (response) in
            let jsonResponse = response.result.value as! NSDictionary
            self.stopLoading()
            if jsonResponse["accessToken"] != nil {
                let user = User()
                user.accessToken = jsonResponse["accessToken"] as? String
                user.fullName = jsonResponse["fullName"] as? String
                Context.saveUserLogin(userLogin: user)
                
                self.preferences.set(user.accessToken, forKey: accessToken)
                self.preferences.set(user.fullName, forKey: fullName)
                Production.ACCESS_TOKEN = user.accessToken ?? ""
                
                //                let viewcontroller : UIViewController = UIStoryboard(name:"Main", bundle: nil).instantiateViewController(withIdentifier: "MainTabViewController") as! MainTabViewController
                //                self.navigationController?.pushViewController(viewcontroller, animated: true)
                
                let storyboard = UIStoryboard(name: "Main", bundle: nil)
                if let viewController = storyboard.instantiateViewController(withIdentifier: "MainTabViewController") as? MainTabViewController {
                    viewController.modalPresentationStyle = .overFullScreen
                    self.navigationController?.pushViewController(viewController, animated: true)
                }
                
            } else {
                
            }
            
            print(response)
        }
    }
    
    func gotoNextPage(){
        let vc = PermissViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
