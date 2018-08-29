//
//  ViewController.swift
//  YouweiCocoa
//
//  Created by Youwei Lu on 8/23/18.
//  Copyright © 2018 Youwei Lu. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBAction func GoNext(_ sender: Any) {
        print("clicked the button in first screen")
        performSegue(withIdentifier: "firstSegue", sender: self)
    }
    
    var username:String = ""
    
    @IBOutlet weak var usernameLabel:UILabel?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        usernameLabel?.text = username
        
        // Do any additional setup after loading the view, typically from a nib.

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

