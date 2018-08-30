//
//  ViewController.swift
//  YouweiCocoa
//
//  Created by Youwei Lu on 8/23/18.
//  Copyright © 2018 Youwei Lu. All rights reserved.
//

import Alamofire
import UIKit

class ViewController: UIViewController {
    
    var firstName:String = ""
    
    @IBOutlet weak var firstNameLabel:UILabel?
    
    @IBOutlet var usernameField: UITextField!
    
    private static var manager: Alamofire.SessionManager = {
        
        // Create the server trust policies
        let serverTrustPolicies: [String: ServerTrustPolicy] = [
            "aggregation-web.sit.va.anthem.com": .disableEvaluation
        ]
        
        // Create custom manager
        let configuration = URLSessionConfiguration.default
        configuration.httpAdditionalHeaders = Alamofire.SessionManager.defaultHTTPHeaders
        let manager = Alamofire.SessionManager(
            configuration: URLSessionConfiguration.default,
            serverTrustPolicyManager: ServerTrustPolicyManager(policies: serverTrustPolicies)
        )
        
        return manager
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        firstNameLabel?.text = firstName
        
    }
    
    @IBAction func getFirstName() {
        
        let headers: HTTPHeaders = [
            "X-MADT-AppId": "ABCBS",
            "X-MADT-AppVersion": "8.0.1200",
            "Content-Type": "application/json"
        ]
        let parameters: Parameters = [
            //            "userName": "SIT5SUB340T91519",
            //            "userName": "SIT5SUB500T91520",
            "userName": usernameField.text ?? " ",
            "password": "support1",
            "actualUserName": ""
        ]
        ViewController.manager.request("https://aggregation-web.sit.va.anthem.com/ma-authentication-app-v6/rest/public/login", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
                if let json = response.result.value as? [String: Any] {
                    print("JSON: \(json)") // serialized json response
                    self.firstNameLabel?.text = json["firstName"] as? String
                }
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

