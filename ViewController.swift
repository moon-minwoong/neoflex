//
//  ViewController.swift
//  mydream
//
//  Created by 문민웅 on 2018. 5. 14..
//  Copyright © 2018년 moon. All rights reserved.
//

import UIKit
import NetworkExtension
import SystemConfiguration.CaptiveNetwork

extension UIApplication {
    
    var statusBarView: UIView? {
        return value(forKey: "statusBar") as? UIView
    }
    
}

class ViewController: UIViewController ,UITextFieldDelegate{
    let registimage : UIImageView = {
        let imageView = UIImageView(image: #imageLiteral(resourceName: "input"))
        return imageView
    }()
    let wifiid_label = UILabel()
    let wifipassword_label = UILabel()
    let input_wifiid = UITextField()
    let input_password = UITextField()
    
    let intervallabel1 = UILabel()
    let intervallabel2 = UILabel()
    
    let okbtn = UIButton()
    let helpbtn = UIButton()
    
    var mmTimer : Timer?
    var help_screen:Int = 0
    
    let help_text1 = UILabel()
    let help_text2 = UILabel()
    let help_text3 = UILabel()
    let help_text4 = UILabel()
    
    var temp_wifiname:String = ""
    var temp_wifipassword:String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        /*
        switch UIDevice.modelName {
        case "Simulator iphone_4_7" : device = IPHONE_BASE
        case "Simulator iphone_4": device = IPHONE_5S_SE
        case "Simulator iphone_5_5": device = IPHONE_PLUS
        case "Simulator iphone_5_8": device = IPHONE_X
        case "Simulator iphone_6_1": device = IPHONE_XR
        case "Simulator iphone_6_5": device = IPHONE_XS_MAX
        case "Simulator ipad_7_9": device = IPAD_SEVEN_INCH
        case "Simulator ipad_9_7": device = IPAD_NINE_INCH
        case "Simulator ipad_10_5": device = IPAD_NINE_INCH
        case "Simulator ipad_12_9": device = IPAD_TWELVE_INCH
        default: break
        }
         */
        
        input_wifiid.delegate = self
        input_wifiid.returnKeyType = .next
        input_wifiid.tag = 1
        input_password.delegate = self
        input_password.returnKeyType = .join
        input_password.tag = 2
        
        navigationItem.title = "first"
        navigationController?.navigationBar.isTranslucent = false
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .black
        
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.white
        
        setuplayout()
        
        view.addSubview(help_text1)
        view.addSubview(help_text2)
        view.addSubview(help_text3)
        if device == IPHONE_XR {
            for v in view.subviews as [UIView] {
                if let labelview = v as? UILabel {
                    labelview.font = UIFont.systemFont(ofSize: 18)
                }
                if let btnview = v as? UIButton {
                    btnview.titleLabel?.font=UIFont(name:"HelveticaNeue-Bold",size:18)
                }
            }
        }
        else if device == IPHONE_5S_SE {
            for v in view.subviews as [UIView] {
                if let labelview = v as? UILabel {
                    labelview.font = UIFont.systemFont(ofSize: 13)
                }
                if let btnview = v as? UIButton {
                    btnview.titleLabel?.font=UIFont(name:"HelveticaNeue-Bold",size:13)
                }
                if let inputview = v as? UITextField {
                    inputview.font = UIFont.systemFont(ofSize: 13)
                }
            }
        }
        else if device == IPHONE_X {
            for v in view.subviews as [UIView] {
                if let labelview = v as? UILabel {
                    labelview.font = UIFont.systemFont(ofSize: 17)
                }
                if let btnview = v as? UIButton {
                    btnview.titleLabel?.font=UIFont(name:"HelveticaNeue-Bold",size:17)
                }
                if let inputview = v as? UITextField {
                    inputview.font = UIFont.systemFont(ofSize: 17)
                }
            }
        }
        else if device == IPHONE_PLUS {
            for v in view.subviews as [UIView] {
                if let labelview = v as? UILabel {
                    labelview.font = UIFont.systemFont(ofSize: 17)
                }
                if let btnview = v as? UIButton {
                    btnview.titleLabel?.font=UIFont(name:"HelveticaNeue-Bold",size:17)
                }
                if let inputview = v as? UITextField {
                    inputview.font = UIFont.systemFont(ofSize: 17)
                }
            }
        }
        else if device == IPAD_NINE_INCH {
            for v in view.subviews as [UIView] {
                if let labelview = v as? UILabel {
                    labelview.font = UIFont.systemFont(ofSize: 29)
                }
                if let btnview = v as? UIButton {
                    btnview.titleLabel?.font=UIFont(name:"HelveticaNeue-Bold",size:29)
                }
            }
        }
        else if device == IPAD_TEN_INCH {
            for v in view.subviews as [UIView] {
                if let labelview = v as? UILabel {
                    labelview.font = UIFont.systemFont(ofSize: 32)
                }
                if let btnview = v as? UIButton {
                    btnview.titleLabel?.font=UIFont(name:"HelveticaNeue-Bold",size:32)
                }
            }
        }
        else if device == IPAD_TWELVE_INCH {
            for v in view.subviews as [UIView] {
                if let labelview = v as? UILabel {
                    labelview.font = UIFont.systemFont(ofSize: 38)
                }
                if let btnview = v as? UIButton {
                    btnview.titleLabel?.font=UIFont(name:"HelveticaNeue-Bold",size:38)
                }
            }
        }
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if help_screen == 1 {
            for v in view.subviews {
                v.layer.removeAllAnimations()
            }
            
            help_text1.alpha = 1
            help_text2.alpha = 1
            help_text3.alpha = 1
            
            registimage.alpha = 0.2
            wifipassword_label.alpha = 0.2
            intervallabel2.alpha = 0.2
            helpbtn.alpha = 0.2
            okbtn.alpha = 0.2
            help_screen = 2
        }
        else if help_screen == 2 {
            help_text1.alpha = 0
            help_text2.alpha = 0
            help_text3.alpha = 0
            
            help_text1.frame = CGRect(x: help_text1.frame.minX, y: help_text1.frame.minY, width: view.frame.width, height: 0)
            help_text1.text = "1. The wifi password can not contain '%', '^', '{', '}' and spaces."
            help_text1.sizeToFit()
            help_text2.frame = CGRect(x: help_text2.frame.minX, y: help_text2.frame.minY, width: view.frame.width, height: 0)
            help_text2.text = "2. WiFi passwords must be at least 8 characters."
            help_text2.sizeToFit()
            help_screen = 3
            UIView.animate(withDuration: 1, animations: {
                self.help_text1.alpha = 1
                self.wifiid_label.alpha = 0.2
                self.intervallabel1.alpha = 0.2
                self.wifipassword_label.alpha = 1
                self.intervallabel2.alpha = 1
            }, completion: {(complete) in
                UIView.animate(withDuration: 1, animations: {
                    self.help_text2.alpha = 1
                }, completion: {(complete) in
                    self.help_screen = 4
                })
            })
        }
        else if help_screen == 3 {
            for v in view.subviews {
                v.layer.removeAllAnimations()
            }
            
            help_text1.alpha = 1
            help_text2.alpha = 1
            
            wifiid_label.alpha = 0.2
            intervallabel1.alpha = 0.2
            wifipassword_label.alpha = 1
            intervallabel2.alpha = 1
            help_screen = 4
        }
        else if help_screen == 4 {
            help_screen = 3
            help_text1.alpha = 0
            help_text2.alpha = 0
            help_text3.alpha = 0
            
            help_text1.frame = CGRect(x: help_text1.frame.minX, y: help_text1.frame.minY, width: view.frame.width, height: 0)
            help_text1.text = "1. It will be set to the wifi name and password you entered."
            help_text1.sizeToFit()
            help_text2.frame = CGRect(x: help_text2.frame.minX, y: help_text2.frame.minY, width: view.frame.width, height: 0)
            help_text2.text = "2. If you do not go to the next screen after 40 seconds, turn the dimmer off and on again."
            help_text2.sizeToFit()
            
            help_screen = 5
            UIView.animate(withDuration: 1, animations: {
                self.help_text1.alpha = 1
                self.wifipassword_label.alpha = 0.2
                self.intervallabel2.alpha = 0.2
                self.okbtn.alpha = 1
            }, completion: {(complete) in
                UIView.animate(withDuration: 1, animations: {
                    self.help_text2.alpha = 1
                }, completion: {(complete) in
                    self.help_screen = 6
                })
            })
        }
        else if help_screen == 5 {
            for v in view.subviews {
                v.layer.removeAllAnimations()
            }
            
            help_text1.alpha = 1
            help_text2.alpha = 1
            
            wifipassword_label.alpha = 0.2
            intervallabel2.alpha = 0.2
            okbtn.alpha = 1
            help_screen = 6
        }
        else if help_screen == 6 {
            input_wifiid.text = temp_wifiname
            input_password.text = temp_wifipassword
            input_wifiid.alpha = 0
            input_password.alpha = 0
            for v in view.subviews {
                v.layer.removeAllAnimations()
            }
            UIView.animate(withDuration: 1, animations: {
                for v in self.view.subviews {
                    if v.frame.minY < self.helpbtn.frame.maxY {
                        v.alpha = 1
                    }
                    else {
                        v.alpha = 0
                    }
                }
            }, completion: {(complete) in
                self.help_screen = 0
                for v in self.view.subviews {
                    v.isUserInteractionEnabled = true
                }
                self.help_text1.removeFromSuperview()
                self.help_text2.removeFromSuperview()
                self.help_text3.removeFromSuperview()
                
            })
            
        }
        view.endEditing(true)
    }
    
    private func setuplayout(){
        imagelayout()
        textfield_label_layout()
        btnlayout()
    }
    
    private func imagelayout(){
        view.addSubview(registimage)
        
        registimage.translatesAutoresizingMaskIntoConstraints = false
        
        registimage.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        registimage.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor).isActive = true
        registimage.widthAnchor.constraint(equalToConstant: view.frame.size.width).isActive = true
        if (device == IPHONE_X ) || (device == IPAD_SEVEN_INCH){
            registimage.heightAnchor.constraint(equalToConstant: view.frame.size.height/5).isActive = true
        }
        else if device == IPHONE_PLUS {
            registimage.heightAnchor.constraint(equalToConstant: view.frame.size.height/4.5).isActive = true
        }
        else if (device == IPHONE_XS_MAX){
            registimage.heightAnchor.constraint(equalToConstant: view.frame.size.height/6).isActive = true
        }
        else if device == IPHONE_5S_SE {
            registimage.heightAnchor.constraint(equalToConstant: view.frame.size.height/5).isActive = true
        }
        else if device == IPHONE_XR {
            registimage.heightAnchor.constraint(equalToConstant: view.frame.size.height/5).isActive = true
        }
        else {
            registimage.heightAnchor.constraint(equalToConstant: view.frame.size.height/4).isActive = true
        }
    }
    
    private func textfield_label_layout(){
        view.addSubview(wifiid_label)
        view.addSubview(wifipassword_label)
        view.addSubview(input_wifiid)
        view.addSubview(input_password)
        view.addSubview(intervallabel1)
        view.addSubview(intervallabel2)
        
        let interval_image_label:CGFloat = 30
        let interval_label_edit:CGFloat = 10
        let interval_edit_line:CGFloat = 5
        let interval_line_label:CGFloat = 20
        let label_text:CGFloat = 15
        let input_text:CGFloat = 20
        
        wifiid_label.translatesAutoresizingMaskIntoConstraints = false
        if (device == IPAD_NINE_INCH)||(device == IPAD_TEN_INCH)||(device == IPAD_SEVEN_INCH) {
            wifiid_label.topAnchor.constraint(equalTo:registimage.bottomAnchor,constant:70).isActive = true
        }
        else if device == IPAD_TWELVE_INCH {
            wifiid_label.topAnchor.constraint(equalTo:registimage.bottomAnchor,constant:80).isActive = true
        }
        else if device == IPHONE_5S_SE {
            wifiid_label.topAnchor.constraint(equalTo:registimage.bottomAnchor,constant:interval_image_label-10).isActive = true
        }
        else {
            wifiid_label.topAnchor.constraint(equalTo:registimage.bottomAnchor,constant:interval_image_label).isActive = true
        }
        if device == IPAD_TWELVE_INCH {
            wifiid_label.leftAnchor.constraint(equalTo:view.leftAnchor,constant:15).isActive = true
        }
        else{
            wifiid_label.leftAnchor.constraint(equalTo:view.leftAnchor,constant:10).isActive = true
        }
        wifiid_label.text = "Create Host Dimmer Name (Host WiFi)"
        if device == IPAD_NINE_INCH {
            wifiid_label.font = UIFont.systemFont(ofSize:30)
        }
        else if device == IPAD_TEN_INCH {
            wifiid_label.font = UIFont.systemFont(ofSize:35)
        }
        else if device == IPAD_TWELVE_INCH {
            wifiid_label.font = UIFont.systemFont(ofSize:40)
        }
        else if device == IPAD_SEVEN_INCH {
            wifiid_label.font = UIFont.systemFont(ofSize:30)
        }
        else {
            wifiid_label.font = UIFont.systemFont(ofSize:label_text)
        }
        wifiid_label.textColor = .white
        
        input_wifiid.translatesAutoresizingMaskIntoConstraints = false
        if device == IPAD_NINE_INCH {
            input_wifiid.topAnchor.constraint(equalTo:wifiid_label.bottomAnchor, constant:10).isActive = true
        }
        else if device == IPAD_TEN_INCH {
            input_wifiid.topAnchor.constraint(equalTo:wifiid_label.bottomAnchor, constant:10).isActive = true
        }
        else if device == IPAD_SEVEN_INCH {
            input_wifiid.topAnchor.constraint(equalTo:wifiid_label.bottomAnchor, constant:8).isActive = true
        }
        else if device == IPAD_TWELVE_INCH {
            input_wifiid.topAnchor.constraint(equalTo:wifiid_label.bottomAnchor, constant:10).isActive = true
        }
        else {
            input_wifiid.topAnchor.constraint(equalTo:wifiid_label.bottomAnchor,constant:interval_label_edit).isActive = true
        }
        input_wifiid.leftAnchor.constraint(equalTo:wifiid_label.leftAnchor).isActive = true
        if device == IPAD_TWELVE_INCH {
            input_wifiid.widthAnchor.constraint(equalToConstant:view.frame.size.width-30).isActive = true
        }
        else{
            input_wifiid.widthAnchor.constraint(equalToConstant:view.frame.size.width-20).isActive = true
        }
        input_wifiid.textColor = .white
        input_wifiid.textAlignment = .left
        input_wifiid.tintColor = .white
        input_wifiid.keyboardAppearance = .dark
        input_wifiid.becomeFirstResponder()//포커싱주기
        if device == IPAD_NINE_INCH {
            input_wifiid.font = UIFont.systemFont(ofSize: 25)
        }
        else if device == IPAD_TEN_INCH {
            input_wifiid.font = UIFont.systemFont(ofSize: 30)
        }
        else if device == IPAD_SEVEN_INCH {
            input_wifiid.font = UIFont.systemFont(ofSize: 25)
        }
        else if device == IPAD_TWELVE_INCH {
            input_wifiid.font = UIFont.systemFont(ofSize: 35)
        }
        intervallabel1.translatesAutoresizingMaskIntoConstraints = false
        intervallabel1.topAnchor.constraint(equalTo:input_wifiid.bottomAnchor,constant:interval_edit_line).isActive = true
        intervallabel1.leftAnchor.constraint(equalTo:input_wifiid.leftAnchor).isActive = true
        if device == IPAD_TWELVE_INCH {
            intervallabel1.widthAnchor.constraint(equalToConstant:view.frame.size.width-30).isActive = true
        }
        else{
            intervallabel1.widthAnchor.constraint(equalToConstant:view.frame.size.width-20).isActive = true
        }
        intervallabel1.backgroundColor = .white
        if device == IPAD_NINE_INCH {
            intervallabel1.heightAnchor.constraint(equalToConstant:3).isActive = true
        }
        else if device == IPAD_TEN_INCH {
            intervallabel1.heightAnchor.constraint(equalToConstant:3).isActive = true
        }
        else if device == IPAD_SEVEN_INCH {
            intervallabel1.heightAnchor.constraint(equalToConstant:3).isActive = true
        }
        else if device == IPAD_TWELVE_INCH {
            intervallabel1.heightAnchor.constraint(equalToConstant:5).isActive = true
        }
        else {
            intervallabel1.heightAnchor.constraint(equalToConstant:2).isActive = true
        }
        
        
        wifipassword_label.translatesAutoresizingMaskIntoConstraints = false
        if device == IPAD_NINE_INCH {
            wifipassword_label.topAnchor.constraint(equalTo:intervallabel1.bottomAnchor,constant:30).isActive = true
        }
        else if device == IPAD_TEN_INCH {
            wifipassword_label.topAnchor.constraint(equalTo:intervallabel1.bottomAnchor,constant:35).isActive = true
        }
        else if device == IPAD_SEVEN_INCH {
            wifipassword_label.topAnchor.constraint(equalTo:intervallabel1.bottomAnchor,constant:30).isActive = true
        }
        else if device == IPAD_TWELVE_INCH {
            wifipassword_label.topAnchor.constraint(equalTo:intervallabel1.bottomAnchor,constant:40).isActive = true
        }
        else {
            wifipassword_label.topAnchor.constraint(equalTo:intervallabel1.bottomAnchor,constant:interval_line_label).isActive = true
        }
        if device == IPAD_TWELVE_INCH{
            wifipassword_label.leftAnchor.constraint(equalTo:view.leftAnchor,constant:15).isActive = true
        }
        else{
            wifipassword_label.leftAnchor.constraint(equalTo:view.leftAnchor,constant:10).isActive = true
        }
        wifipassword_label.text = "Create Host Dimmer Password (Host WiFi)"
        if device == IPAD_NINE_INCH {
            wifipassword_label.font = UIFont.systemFont(ofSize:30)
        }
        else if device == IPAD_TEN_INCH {
            wifipassword_label.font = UIFont.systemFont(ofSize:35)
        }
        else if device == IPAD_SEVEN_INCH {
            wifipassword_label.font = UIFont.systemFont(ofSize:30)
        }
        else if device == IPAD_TWELVE_INCH {
            wifipassword_label.font = UIFont.systemFont(ofSize:40)
        }
        else {
            wifipassword_label.font = UIFont.systemFont(ofSize:label_text)
        }
        wifipassword_label.textColor = .white
        
        input_password.translatesAutoresizingMaskIntoConstraints = false
        input_password.topAnchor.constraint(equalTo:wifipassword_label.bottomAnchor,constant:10).isActive = true
        input_password.leftAnchor.constraint(equalTo:input_wifiid.leftAnchor).isActive = true
        if device == IPAD_TWELVE_INCH{
                input_password.widthAnchor.constraint(equalToConstant:view.frame.size.width-30).isActive = true
        }
        else{
            input_password.widthAnchor.constraint(equalToConstant:view.frame.size.width-20).isActive = true
        }
        
        input_password.textColor = .white
        input_password.textAlignment = .left
        input_password.tintColor = .white
        input_password.keyboardAppearance = .dark
        if device == IPAD_NINE_INCH {
            input_password.font = UIFont.systemFont(ofSize: 25)
        }
        else if device == IPAD_TEN_INCH {
            input_password.font = UIFont.systemFont(ofSize: 30)
        }
        else if device == IPAD_SEVEN_INCH {
            input_password.font = UIFont.systemFont(ofSize: 25)
        }
        else if device == IPAD_NINE_INCH {
            input_password.font = UIFont.systemFont(ofSize: 30)
        }
        else if device == IPAD_TWELVE_INCH {
            input_password.font = UIFont.systemFont(ofSize: 35)
        }
        
        intervallabel2.translatesAutoresizingMaskIntoConstraints = false
        intervallabel2.topAnchor.constraint(equalTo:input_password.bottomAnchor,constant:interval_edit_line).isActive = true
        intervallabel2.leftAnchor.constraint(equalTo:input_password.leftAnchor).isActive = true
        intervallabel2.rightAnchor.constraint(equalTo:input_password.rightAnchor).isActive = true
        intervallabel2.backgroundColor = .white
        if device == IPAD_NINE_INCH {
            intervallabel2.heightAnchor.constraint(equalToConstant:3).isActive = true
        }
        else if device == IPAD_SEVEN_INCH {
            intervallabel2.heightAnchor.constraint(equalToConstant:3).isActive = true
        }
        else if device == IPAD_TWELVE_INCH {
            intervallabel2.heightAnchor.constraint(equalToConstant:5).isActive = true
        }
        else {
            intervallabel2.heightAnchor.constraint(equalToConstant:2).isActive = true
        }
        
    }
    
    private func btnlayout(){
        view.addSubview(okbtn)
        view.addSubview(helpbtn)
        
        let interval_line_btn:CGFloat = 10
        
        helpbtn.translatesAutoresizingMaskIntoConstraints = false
        helpbtn.topAnchor.constraint(equalTo:intervallabel2.bottomAnchor, constant:interval_line_btn).isActive = true
        helpbtn.leftAnchor.constraint(equalTo:intervallabel2.leftAnchor).isActive = true
        helpbtn.widthAnchor.constraint(equalToConstant: 150).isActive = true
        helpbtn.setTitle("Help", for: .normal)
        helpbtn.setTitleColor(.white, for: .normal)
        helpbtn.titleLabel?.font=UIFont(name:"HelveticaNeue-Bold",size:15)
        helpbtn.contentHorizontalAlignment = .left
        
        if device == IPAD_NINE_INCH {
            helpbtn.titleLabel?.font=UIFont(name:"HelveticaNeue-Bold",size:30)
        }
        else if device == IPAD_TEN_INCH {
            helpbtn.titleLabel?.font=UIFont(name:"HelveticaNeue-Bold",size:30)
        }
        else if device == IPAD_SEVEN_INCH {
            helpbtn.titleLabel?.font=UIFont(name:"HelveticaNeue-Bold",size:30)
        }
        else if device == IPAD_TWELVE_INCH {
            helpbtn.titleLabel?.font=UIFont(name:"HelveticaNeue-Bold",size:35)
        }
        else {
            helpbtn.titleLabel?.font=UIFont(name:"HelveticaNeue-Bold",size:15)
        }
        helpbtn.addTarget(self, action: #selector(self.help_action(_:)), for: .touchUpInside)
        
        okbtn.translatesAutoresizingMaskIntoConstraints = false
        okbtn.rightAnchor.constraint(equalTo:intervallabel1.rightAnchor).isActive = true;
        okbtn.topAnchor.constraint(equalTo:intervallabel2.bottomAnchor, constant:interval_line_btn).isActive = true
        if device == IPAD_NINE_INCH {
            okbtn.widthAnchor.constraint(equalToConstant:100).isActive = true
        }
        else if device == IPAD_TEN_INCH {
            okbtn.widthAnchor.constraint(equalToConstant:100).isActive = true
        }
        else if device == IPAD_SEVEN_INCH {
            okbtn.widthAnchor.constraint(equalToConstant:100).isActive = true
        }
        else if device == IPAD_TWELVE_INCH {
            okbtn.widthAnchor.constraint(equalToConstant:130).isActive = true
        }
        else {
            okbtn.widthAnchor.constraint(equalToConstant:50).isActive = true
        }
        okbtn.setTitle("OK", for: .normal)
        okbtn.setTitleColor(.white, for: .normal)
        okbtn.contentHorizontalAlignment = .right
        if device == IPAD_NINE_INCH {
            okbtn.titleLabel?.font=UIFont(name:"HelveticaNeue-Bold",size:30)
        }
        else if device == IPAD_TEN_INCH {
            okbtn.titleLabel?.font=UIFont(name:"HelveticaNeue-Bold",size:30)
        }
        else if device == IPAD_SEVEN_INCH {
            okbtn.titleLabel?.font=UIFont(name:"HelveticaNeue-Bold",size:30)
        }
        else if device == IPAD_TWELVE_INCH {
            okbtn.titleLabel?.font=UIFont(name:"HelveticaNeue-Bold",size:35)
        }
        else {
            okbtn.titleLabel?.font=UIFont(name:"HelveticaNeue-Bold",size:15)
        }
        okbtn.addTarget(self, action: #selector(self.single_move(_:)), for: .touchUpInside)
    }
    
    @objc func single_move(_ sender: Any){
        input_wifiid.resignFirstResponder()
        input_password.resignFirstResponder()
        
        for i in 1 ..< UserDefaults.standard.integer(forKey: "count")+1 {
            let check = UserDefaults.standard.string(forKey: "dev"+String(i)) ?? ""
            if input_wifiid.text == check {
                toast_message(message: "This Wifi name is exists")
                input_wifiid.text = ""
                input_password.text = ""
                return
            }
        }
        
        if ( input_wifiid.text?.count == 0 ){
            toast_message(message: "Input wifi name")
            return
        }
        else if ( input_wifiid.text == "Flex_Cine_Dimmer" ) {
            toast_message(message: "Can not set a wifi name with \"Flex_Cine_Dimmer\"")
            return
        }
        else if input_wifiid.text?.contains(" ") ?? true {
            toast_message(message: "The wifi name can not contain '%', '^', '{', '}' and spaces.")
            return
        }
        else if input_wifiid.text?.contains("%") ?? true {
            toast_message(message: "The wifi name can not contain '%', '^', '{', '}' and spaces.")
            return
        }
        else if input_wifiid.text?.contains("^") ?? true {
            toast_message(message: "The wifi name can not contain '%', '^', '{', '}' and spaces.")
            return
        }
        else if input_wifiid.text?.contains("{") ?? true {
            toast_message(message: "The wifi name can not contain '%', '^', '{', '}' and spaces.")
            return
        }
        else if input_wifiid.text?.contains("}") ?? true {
            toast_message(message: "The wifi name can not contain '%', '^', '{', '}' and spaces.")
            return
        }
        else if ( input_password.text?.count == 0 ){
            toast_message(message: "Input wifi password")
            return
        }
        else if ( Int(input_password.text!.count) < 8 ){
            toast_message(message: "Please set your password \nto 8 characters or more")
            return
        }
        
        var count: Int = 1

        while(true){
            let check = UserDefaults.standard.string(forKey: "dev"+String(count)) ?? ""
            if ( check == "" ) {
                if  count > (UserDefaults.standard.integer(forKey: "count") ?? 0){
                    UserDefaults.standard.set(count, forKey: "count")
                }
                break
            }
            count+=1
        }
        
        okbtn.setTitleColor(UIColor(red:102/255,green:102/255,blue:102/255,alpha:1.0), for: .normal)
        helpbtn.setTitleColor(UIColor(red:102/255,green:102/255,blue:102/255,alpha:1.0), for: .normal)
        okbtn.isEnabled = false
        helpbtn.isEnabled = false
        
        
        let urlpath = "http://192.168.4.1/reg"+input_wifiid.text!+"passelumi"+input_password.text!+"elumi"
        let url = NSURL(string:urlpath)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url! as URL, completionHandler:{
            (data,responds,error)->Void in
            
            if error == nil {
                let urlcontent = NSString(data:data!,encoding: String.Encoding.utf8.rawValue)
                
            }
            else{
                print("error")
            }
        })
        task.resume()
        
        UserDefaults.standard.set(input_wifiid.text,forKey:"dev"+String(count))
        UserDefaults.standard.set(input_password.text,forKey:"dev"+String(count)+"password")
        UserDefaults.standard.set(0,forKey:"dev"+String(count)+"mode")
        
        for v in view.subviews {
            v.alpha = 0.3
        }
        
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.topAnchor.constraint(equalTo:okbtn.bottomAnchor,constant:40).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        activityIndicator.frame = view.bounds
        activityIndicator.startAnimating()
        
        DispatchQueue.global(qos: .background).async {
            sleep(8)
            
            let hotspotconfig = NEHotspotConfiguration(ssid:self.input_wifiid.text!, passphrase:self.input_password.text!,isWEP:false)
            hotspotconfig.joinOnce = true
            NEHotspotConfigurationManager.shared.apply(hotspotconfig){ (error) in
                if error != nil{
                    if error?.localizedDescription == "already associatted."
                    {
                        print("connected")
                    }
                    else{
                        print(error)
                        print("no connected")
                        self.toast_message(message: "Connect WiFi directly and restart app")
                    }
                }
                else{
                    print("connected")
                }
            }
        }
        if let timer = mmTimer {
            if !timer.isValid {
                mmTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
            }
        }
        else {
            mmTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(timerCallback), userInfo: nil, repeats: true)
        }
    }
    @objc func help_action(_ sender:Any){
        for v in view.subviews {
            v.isUserInteractionEnabled = false
        }
        temp_wifiname = input_wifiid.text ?? ""
        temp_wifipassword = input_password.text ?? ""
        
        input_wifiid.text = ""
        input_password.text = ""
        input_wifiid.resignFirstResponder()
        input_password.resignFirstResponder()
        help_screen = 1
        
        
        help_text1.frame = CGRect(x: helpbtn.frame.minX, y: helpbtn.frame.maxY+view.frame.height/20, width: view.frame.width-helpbtn.frame.minX, height: 0)
        help_text1.textColor = .white
        help_text1.text = "1. The wifi name can not contain '%', '^', '{', '}' and spaces."
        help_text1.lineBreakMode = .byWordWrapping
        help_text1.numberOfLines = 0
        help_text1.sizeToFit()
        help_text1.alpha = 0
        help_text2.frame = CGRect(x: helpbtn.frame.minX, y: help_text1.frame.maxY+view.frame.height/30, width: view.frame.width-helpbtn.frame.minX, height: 0)
        help_text2.textColor = .white
        help_text2.text = "2. You can not set the wifi name as \"Flex_Cine_Dimmer\"."
        help_text2.lineBreakMode = .byWordWrapping
        help_text2.numberOfLines = 0
        help_text2.sizeToFit()
        help_text2.alpha = 0
        help_text3.frame = CGRect(x: helpbtn.frame.minX, y: help_text2.frame.maxY+view.frame.height/30, width: view.frame.width-helpbtn.frame.minX, height: 0)
        help_text3.textColor = .white
        help_text3.text = "3. You can not create an existing wifi name."
        help_text3.lineBreakMode = .byWordWrapping
        help_text3.numberOfLines = 0
        help_text3.sizeToFit()
        help_text3.alpha = 0
        view.addSubview(help_text1)
        view.addSubview(help_text2)
        view.addSubview(help_text3)

        UIView.animate(withDuration: 1, animations: {
            self.help_text1.alpha = 1
            self.registimage.alpha = 0.2
            self.wifipassword_label.alpha = 0.2
            self.intervallabel2.alpha = 0.2
            self.helpbtn.alpha = 0.2
            self.okbtn.alpha = 0.2
        }, completion: {(complete) in
            UIView.animate(withDuration: 1, animations: {
                self.help_text2.alpha = 1
                self.registimage.alpha = 0.2
                self.wifipassword_label.alpha = 0.2
                self.intervallabel2.alpha = 0.2
                self.helpbtn.alpha = 0.2
                self.okbtn.alpha = 0.2
            }, completion: {(complete) in
                UIView.animate(withDuration: 1, animations: {
                    self.help_text3.alpha = 1
                    self.registimage.alpha = 0.2
                    self.wifipassword_label.alpha = 0.2
                    self.intervallabel2.alpha = 0.2
                    self.helpbtn.alpha = 0.2
                    self.okbtn.alpha = 0.2
                }, completion: {(complete) in
                    self.help_screen = 2
                })
            })
        })
    }
    func detect_model(){
        print("detect")
        print(UIDevice.modelName)
        switch UIDevice.modelName {
        case "iphone_4_7" : show(iphone_base(), sender: self)
        case "iphone_4": show(iphone_5s_SE(), sender: self)
        case "iphone_5_5": show(iphone_plus(), sender: self)
        case "iphone_5_8": show(iphone_X(), sender: self)
        case "ipad_7_9": show(ipad_seven_inch(), sender: self)
        case "ipad_9_7": show(ipad_nine_inch(), sender: self)
        case "ipad_10_5": show(ipad_ten_inch(), sender: self)
        case "ipad_12_9": show(ipad_twelve_inch(), sender: self)
        default: break
        }
        /*
        switch UIDevice().type{
        case .iPhone6, .iPhone7, .iPhone8, .iPhone6S : show(iphone_X(),sender: self);is_iphone = true;print("base");break;
        case .iPhoneSE, .iPhone5S : show(iphone_5s_SE(),sender: self);is_iphone = true;print("5s_se");break;
        case .iPhoneX : show(iphone_X(),sender: self);is_iphone = true;print("x");break;
        default : break
        }
 */
    }
    
    @objc func timerCallback() {
        if ( getWifissid() == input_wifiid.text ) {
            detect_model()
            if let timer = mmTimer {
                if ( timer.isValid ) {
                    timer.invalidate()
                }
            }
        }
    }
    @objc  func keyboardWillShow(_sender: Notification){
        self.view.frame.origin.y = -150
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag == 1 {
            input_password.becomeFirstResponder()
        }
        else {
            textField.resignFirstResponder()
            okbtn.sendActions(for: .touchUpInside)
        }
        return true
    }
    @objc func keyboardWillHide(_sender: Notification){
        self.view.frame.origin.y = 0
    }
    
    override func getWifissid() -> String? {
        var ssid: String?
        
        if let interfaces = CNCopySupportedInterfaces() as NSArray? {
            for interface in interfaces {
                if let interfaceInfo = CNCopyCurrentNetworkInfo(interface as! CFString ) as NSDictionary? {
                    ssid = interfaceInfo[kCNNetworkInfoKeySSID as String] as? String
                    break
                }
            }
        }
 
        return ssid
    }
    
    
}

