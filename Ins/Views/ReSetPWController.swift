//
//  ReSetPWController.swift
//  Ins
//
//  Created by HUAMEi on 2018/6/20.
//  Copyright © 2018年 HUAMEi. All rights reserved.
//

import UIKit

class ReSetPWController: UIViewController {

    @IBOutlet weak var email: UITextField!
    
    let userdef = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //重置密码
    
    @IBAction func reSet(_ sender: Any) {
        if self.email.text!.isEmpty  {
            let alt = UIAlertController(title: "请注意", message: "请先填写邮箱地址", preferredStyle: .alert)
            let act = UIAlertAction(title: "确定", style: .default, handler: nil)
            alt.addAction(act)
            self.present(alt, animated: true, completion: nil)
        }else if self.email.text?.contains("@") == false {
            let alt = UIAlertController(title: "请注意", message: "请输入正确的邮箱地址", preferredStyle: .alert)
            let act = UIAlertAction(title: "确定", style: .default, handler: nil)
            alt.addAction(act)
            self.present(alt, animated: true, completion: nil)
        }else{
            AVUser.requestPasswordResetForEmail(inBackground: self.email.text!) { (success, error) in
                if success {
                    let alt = UIAlertController(title: "成功", message: "重置密码邮件已发送至您的邮箱", preferredStyle: .alert)
                    let act = UIAlertAction(title: "确定", style: .default, handler: nil)
                    alt.addAction(act)
                    self.present(alt, animated: true, completion: nil)
                    
                }else{
                    print(error)
                    let alt = UIAlertController(title: "请注意", message: "出现未知错误，请重试", preferredStyle: .alert)
                    let act = UIAlertAction(title: "确定", style: .default, handler: { (_) in
                        self.presentingViewController?.dismiss(animated: true, completion: nil)
                    })
                    alt.addAction(act)
                    self.present(alt, animated: true, completion: nil)
                }
            }
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
