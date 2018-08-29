//
//  SecondViewController.swift
//  SeguesTest
//
//  Created by Timothy Masterson on 7/19/18.
//  Copyright © 2018 Timothy Masterson. All rights reserved.
//

import Alamofire
import UIKit

class SecondViewController: UIViewController {
    
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

        // Do any additional setup after loading the view.
        
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
        SecondViewController.manager.request("https://aggregation-web.sit.va.anthem.com/ma-authentication-app-v6/rest/public/login", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: headers).responseJSON { response in
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        // Determine what the segue destination is
        if segue.destination is ViewController
        {
            let vc = segue.destination as? ViewController
            vc?.username = itemTextField.text!
        }
    }
    
    
    
    @IBOutlet var itemTextField: UITextField!
    

}
