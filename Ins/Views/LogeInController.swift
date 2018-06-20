//
//  LogeInController.swift
//  Ins
//
//  Created by Kxy on 2018/6/11.
//  Copyright © 2018年 HUAMEi. All rights reserved.
//

import UIKit

class LogeInController: UIViewController {

    @IBOutlet weak var longIn: UIButton!
    @IBOutlet weak var SingIn: UIButton!
    @IBOutlet weak var UserName: UITextField!
    @IBOutlet weak var Password: UITextField!
    @IBOutlet weak var FindPW: UIButton!
    
    let userdef = UserDefaults.standard
    override func viewDidLoad() {
        super.viewDidLoad()
        let hidetap = UITapGestureRecognizer(target: self, action: #selector(hidekeyboard))
        hidetap.numberOfTapsRequired = 1
        self.view.isUserInteractionEnabled = true
        self.view.addGestureRecognizer(hidetap)
        // Do any additional setup after loading the view.
    }
    @objc func hidekeyboard() {
        self.view.endEditing(true)
    }
    @IBAction func findPWact(_ sender: Any) {
    }
    
    @IBAction func Logact(_ sender: Any) {
        if self.UserName.text!.isEmpty || self.Password.text!.isEmpty {
            let alt = UIAlertController(title: "错误", message: "请填写用户名和密码", preferredStyle: .alert)
            let act = UIAlertAction(title: "确定", style: .default, handler: nil)
            alt.addAction(act)
            self.present(alt, animated: true, completion: nil)
        }else{
            AVUser.logInWithUsername(inBackground: self.UserName.text!, password: self.Password.text!) { (result, error) in
                if error == nil {
                    self.userdef.set(self.UserName.text!, forKey: "username")
                    let vc = self.storyboard?.instantiateViewController(withIdentifier: "TabView") as! TabBarController
                    self.present(vc, animated: true, completion: nil)
                }else {
                    print("错误",error.debugDescription,"错误")
                    if error.debugDescription.contains("The username and password mismatch") {
                        let alt = UIAlertController(title: "密码错误", message: "请确认您的密码是否填写正确", preferredStyle: .alert)
                        let act = UIAlertAction(title: "确定", style: .default, handler: nil)
                        alt.addAction(act)
                        self.present(alt, animated: true, completion: nil)
                    }else if error.debugDescription.contains("Email address isn't verified.") {
                        let alt = UIAlertController(title: "请注意", message: "邮箱未认证", preferredStyle: .alert)
                        let act = UIAlertAction(title: "确定", style: .cancel, handler: nil)
                        let act2 = UIAlertAction(title: "发送验证码", style: .default, handler: { (_) in
                            let user = AVUser.current()
                            let id = user?.objectId
                            let user1 = AVQuery(className: "_User")
                            user1.getObjectInBackground(withId: id!, block: { (object, error) in
                                AVUser.requestEmailVerify(object?.value(forKey: "email") as! String, with: { (success, error) in
                                    if success {
                                        let alt = UIAlertController(title: "请注意", message: "已向您的邮箱发送验证，请确认", preferredStyle: .alert)
                                        let act = UIAlertAction(title: "确定", style: .default, handler: nil)
                                        alt.addAction(act)
                                        self.present(alt, animated: true, completion: nil)
                                    }else{
                                        print(error)
                                    }
                                })
                            })
                        
                        })
                        alt.addAction(act)
                        alt.addAction(act2)
                        self.present(alt, animated: true, completion: nil)
                }else if error.debugDescription.contains("Could not find user") {
                    let alt = UIAlertController(title: "请注意", message: "用户不存在", preferredStyle: .alert)
                    let act = UIAlertAction(title: "确定", style: .default, handler: nil)
                    alt.addAction(act)
                    self.present(alt, animated: true, completion: nil)
                    }
                }
            }
        }
        
    }
    
    @IBAction func SiginAct(_ sender: Any) {
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
