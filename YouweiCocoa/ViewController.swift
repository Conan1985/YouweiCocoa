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
            "jsonplaceholder.typicode.com": .disableEvaluation
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
            "Authorization": "Basic QWxhZGRpbjpvcGVuIHNlc2FtZQ==",
            "Accept": "application/json"
        ]
        let parameters: Parameters = [
            "foo": "bar",
            "baz": ["a", 1],
            "qux": [
                "x": 1,
                "y": 2,
                "z": 3
            ]
        ]
        ViewController.manager.request("https://jsonplaceholder.typicode.com/todos", method: .post, parameters: parameters, headers: headers).responseJSON { response in
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

