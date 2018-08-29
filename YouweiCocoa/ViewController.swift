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
        let headers: HTTPHeaders = [
            "X-MADT-AppId": "ABCBS",
            "X-MADT-AppVersion": "8.0.1200",
            "Content-Type": "application/json"
        ]
        let parameters: Parameters = [
            "userName": "SIT5SUB340T91519",
            "password": "support1",
            "actualUserName": ""
        ]
        ViewController.manager.request("https://aggregation-web.sit.va.anthem.com/ma-authentication-app-v6/rest/public/login", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

