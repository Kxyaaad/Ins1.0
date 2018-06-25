//
//  ViewController.swift
//  Ins
//
//  Created by HUAMEi on 2018/6/11.
//  Copyright © 2018年 HUAMEi. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let userdef = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       self.navigationItem.title = "Instagram"
    }

    @IBAction func logout(_ sender: Any) {
        
        self.userdef.set(nil, forKey: "username")
        self.userdef.set(nil, forKey: "userID")
        let vc = storyboard?.instantiateViewController(withIdentifier: "LOGIN") as! LogeInController
        self.present(vc, animated: true, completion: nil)
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

