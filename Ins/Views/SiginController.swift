//
//  SiginController.swift
//  Ins
//
//  Created by Kxy on 2018/6/12.
//  Copyright © 2018年 HUAMEi. All rights reserved.
//

import UIKit

class SiginController: UIViewController {
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var password2th: UITextField!
    @IBOutlet weak var email: UITextField!
    
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var jianjie: UITextField!
    @IBOutlet weak var websit: UITextField!
    
    @IBOutlet weak var scview: UIScrollView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        self.scview.contentSize = CGSize(width: self.view.frame.width, height: 500)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
