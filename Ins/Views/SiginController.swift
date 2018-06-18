//
//  SiginController.swift
//  Ins
//
//  Created by Kxy on 2018/6/12.
//  Copyright © 2018年 HUAMEi. All rights reserved.
//

import UIKit
import NotificationCenter

class SiginController: UIViewController,UITextFieldDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var img: UIImageView!
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var password2th: UITextField!
    @IBOutlet weak var email: UITextField!
 
    
    @IBOutlet var tapGes: UITapGestureRecognizer!
    
    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var jianjie: UITextField!
    @IBOutlet weak var websit: UITextField!
    
    @IBOutlet weak var scview: UIScrollView!
    
    @IBOutlet weak var ok: UIButton!
    @IBOutlet weak var cancel: UIButton!
    
    var keyboardsize : CGRect!
    override func viewDidLoad() {
        
        super.viewDidLoad()
//添加键盘通知
        NotificationCenter.default.addObserver(self, selector: #selector(showKeyboard), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(hideKeyboarf), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        //键盘delegate绑定
        self.username.delegate = self
        self.password.delegate = self
        self.password2th.delegate = self
        self.email.delegate = self
        self.name.delegate = self
        self.jianjie.delegate = self
        self.websit.delegate = self
        
        self.img.layer.cornerRadius = self.img.frame.width/2
        self.img.isUserInteractionEnabled = true
        self.img.addGestureRecognizer(tapGes)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.name {
            self.username.resignFirstResponder()
            self.password.becomeFirstResponder()
        }
        return true
    }
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.scview.contentSize = CGSize(width: self.view.frame.width, height: 800)
    }
    
    @IBAction func zhcue(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func showKeyboard(notification: Notification) {
        //定义键盘大小
        let rect = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        keyboardsize = rect as? CGRect
        print(keyboardsize)
        //当虚拟键盘出现以后，将滚动师徒的实际高度所有为屏幕高度减去键盘的高度
        UIView.animate(withDuration: 0.4) {
            self.scview.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height:  (self.scview.frame.height - self.keyboardsize.height))
        }
    }
    
    @objc func hideKeyboarf(notification: Notification){
        
        UIView.animate(withDuration: 0.4) {
            self.scview.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height:  self.view.frame.height)
        }
        
    }
    //点击头像，弹出照片选择
    @IBAction func tapPhoto(_ sender: Any) {
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)
    }
    //选择的照片作为头
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.img.image = info[UIImagePickerControllerEditedImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    }
    //若点击取消则退出界面
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        self.dismiss(animated: true, completion: nil)
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
