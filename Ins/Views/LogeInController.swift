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

        // Do any additional setup after loading the view.
    }
    
    @IBAction func findPWact(_ sender: Any) {
    }
    
    @IBAction func Logact(_ sender: Any) {
        if self.UserName.text!.isEmpty || self.Password.text!.isEmpty {
            let alt = UIAlertController(title: "错误", message: "有必填项目未填写", preferredStyle: .alert)
            let act = UIAlertAction(title: "确定", style: .default, handler: nil)
            alt.addAction(act)
            self.present(alt, animated: true, completion: nil)
        }else{
            AVUser.logInWithUsername(inBackground: self.UserName.text!, password: self.Password.text!) { (result, error) in
                if error == nil {
                    self.userdef.set(self.UserName.text!, forKey: "username")
                }else {
                    print("错误",error.debugDescription,"错误")
                    
                if error.debugDescription.contains("Email address isn't verified.") {
                        let alt = UIAlertController(title: "请注意", message: "有必填项目未填写", preferredStyle: .alert)
                        let act = UIAlertAction(title: "确定", style: .cancel, handler: nil)
                        let act2 = UIAlertAction(title: "发送验证码", style: .default, handler: { (_) in
                            let user = AVUser()
                            let user1 = AVQuery.init(className: "_User")
                            
                            
                            
                           
                            AVUser.requestEmailVerify(user1!, with: { (result, error) in
                                if result {
                                    print("success")
                                }else{
                                    print(error,"helo")
                                }
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
