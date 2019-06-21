//
//  start.swift
//  mydream
//
//  Created by 문민웅 on 2018. 9. 6..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation
import UIKit
import NetworkExtension
import SystemConfiguration.CaptiveNetwork
import PlainPing

class start: UIViewController{
    
    
    let namelabel = UILabel()
    var mTimer : Timer?
    var pings:[String] = []
    var test:[Int] = [0,0,0,0,0]
    var multi_check_complete:Bool = false
    
    let debug_device:Int = IPHONE_BASE
    let progress_label = UILabel()
    override func viewDidLoad() {
        super.viewDidLoad()
        pings = ["192.168.4.3","192.168.4.4","192.168.4.5"]
        
        /*
        print(UserDefaults.standard.string(forKey: "dev4"))
        print(UserDefaults.standard.string(forKey: "dev4password"))
        
        UserDefaults.standard.set("feedback1",forKey:"dev6")
        UserDefaults.standard.set("00000000",forKey:"dev6password")
        UserDefaults.standard.set("feedback2",forKey:"dev7")
        UserDefaults.standard.set("00000000",forKey:"dev7password")
        UserDefaults.standard.set("feedback3",forKey:"dev8")
        UserDefaults.standard.set("00000000",forKey:"dev8password")
        
        UserDefaults.standard.set(1,forKey:"dev1mode")
        UserDefaults.standard.set(1,forKey:"dev1client3count")
        UserDefaults.standard.set(1,forKey:"dev1client4count")
        UserDefaults.standard.set(1,forKey:"dev1client5count")
        UserDefaults.standard.set("feedback1asdasdasd",forKey:"dev1client3")
        UserDefaults.standard.set("feedback2",forKey:"dev1client4")
        UserDefaults.standard.set("feedback3",forKey:"dev1client5")
        UserDefaults.standard.set("feedback",forKey:"dev6master")
        UserDefaults.standard.set("feedback",forKey:"dev7master")
        UserDefaults.standard.set("feedback",forKey:"dev8master")
        UserDefaults.standard.set(2,forKey:"dev6mode")
        UserDefaults.standard.set(2,forKey:"dev7mode")
        UserDefaults.standard.set(2,forKey:"dev8mode")
        UserDefaults.standard.set(10,forKey:"count")
        */
        //userdefaults_reset()
        //wifi_request(message: "res")//%,^,{,}
        
        error_check()
        
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.white
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.addSubview(namelabel)
        
        switch UIDevice.modelName {
        case "iphone_4_7" : device = IPHONE_BASE
        case "iphone_4": device = IPHONE_5S_SE
        case "iphone_5_5": device = IPHONE_PLUS
        case "iphone_5_8": device = IPHONE_X
        case "iphone_6_1": device = IPHONE_XR
        case "iphone_6_5": device = IPHONE_XS_MAX
        case "ipad_7_9": device = IPAD_SEVEN_INCH
        case "ipad_9_7": device = IPAD_NINE_INCH
        case "ipad_10_5": device = IPAD_NINE_INCH
        case "ipad_12_9": device = IPAD_TWELVE_INCH
        default: break
        }
        
        /*
        namelabel.translatesAutoresizingMaskIntoConstraints = false
        namelabel.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        namelabel.centerYAnchor.constraint(equalTo:view.centerYAnchor).isActive = true
        namelabel.widthAnchor.constraint(equalToConstant:view.frame.size.width*5/6).isActive = true
        //namelabel.heightAnchor.constraint(equalToConstant: view.frame.size.height*3/5).isActive = true
 
        namelabel.frame = CGRect(x: 0, y: 0, width: view.frame.width*6/7, height: 0)
        namelabel.center = view.center
        namelabel.textColor = .white
        namelabel.text = "Connecting Flex_Cine_Dimmer ..."
        namelabel.textAlignment = .center
 
        if device == IPHONE_PLUS {
            namelabel.font = UIFont.systemFont(ofSize:24)
        }
        else if device == IPHONE_5S_SE {
            namelabel.font = UIFont.systemFont(ofSize:18)
        }
        else if device == IPHONE_XR {
            namelabel.font = UIFont.systemFont(ofSize:24)
        }
        else if device == IPHONE_XS_MAX {
            namelabel.font = UIFont.systemFont(ofSize:24)
        }
        else if device == IPHONE_BASE {
            namelabel.font = UIFont.systemFont(ofSize:22)
        }
        else if device == IPHONE_X {
            namelabel.font = UIFont.systemFont(ofSize:22)
        }
        else {
            namelabel.font = UIFont.systemFont(ofSize:40)
        }
        namelabel.sizeToFit()
        */
        namelabel.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 0)
        namelabel.textColor = .gray
        namelabel.text = "Flex_Cine_Dimmer"
        namelabel.textAlignment = .center
        if (device == IPHONE_BASE) || (device == IPHONE_XS_MAX) {
            namelabel.font = UIFont.boldSystemFont(ofSize: 40)
        }
        else if device == IPHONE_PLUS {
            namelabel.font = UIFont.boldSystemFont(ofSize: 50)
        }
        else if device == IPHONE_X {
            namelabel.font = UIFont.boldSystemFont(ofSize: 35)
        }
        else if device == IPHONE_5S_SE {
            namelabel.font = UIFont.boldSystemFont(ofSize: 30)
        }
        else if device == IPHONE_XR {
            namelabel.font = UIFont.boldSystemFont(ofSize: 44)
        }
        else if device == IPAD_TWELVE_INCH {
            namelabel.font = UIFont.boldSystemFont(ofSize: 85)
        }
        else {
            namelabel.font = UIFont.boldSystemFont(ofSize: 70)
        }
        
        namelabel.sizeToFit()
        namelabel.center = view.center
        
        progress_label.frame = CGRect(x: namelabel.frame.minX, y: namelabel.frame.minY, width: 0, height: namelabel.frame.height)
        progress_label.text = "Flex_Cine_Dimmer"
        progress_label.textColor = .white
        if (device == IPHONE_BASE) || (device == IPHONE_XS_MAX) {
            progress_label.font = UIFont.boldSystemFont(ofSize: 40)
        }
        else if device == IPHONE_PLUS {
            progress_label.font = UIFont.boldSystemFont(ofSize: 50)
        }
        else if device == IPHONE_X {
            progress_label.font = UIFont.boldSystemFont(ofSize: 35)
        }
        else if device == IPHONE_5S_SE {
            progress_label.font = UIFont.boldSystemFont(ofSize: 30)
        }
        else if device == IPHONE_XR {
            progress_label.font = UIFont.boldSystemFont(ofSize: 44)
        }
        else if device == IPAD_TWELVE_INCH {
            progress_label.font = UIFont.boldSystemFont(ofSize: 85)
        }
        else {
            progress_label.font = UIFont.boldSystemFont(ofSize: 70)
        }
        
        progress_label.lineBreakMode = .byClipping
        progress_label.numberOfLines = 0
        view.addSubview(progress_label)
        
        /*
        let logo_line:CGFloat = 30
        
        
        let shape0 = CAShapeLayer()
        var path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: view.center.y+logo_line/2))
        path.addLine(to: CGPoint(x: logo_line, y: view.center.y-logo_line/2))
        path.addLine(to: CGPoint(x: namelabel.frame.height, y: namelabel.frame.maxY))
        path.addLine(to: CGPoint(x: 0, y: namelabel.frame.maxY))
        
        let red:CGFloat = (CGFloat(255+(77-255)*cctslider.value/32))
        var green:CGFloat = (CGFloat(120+(170-120)*cctslider.value/32))
        var blue : CGFloat = (CGFloat(40+(232-40)*cctslider.value/32))
        shape0.path = path.cgPath
        shape0.fillColor = UIColor(displayP3Red: 77/255, green: 170/255, blue: 232/255, alpha: 1).cgColor
        shape0.lineWidth = 2
        
        view.layer.addSublayer(shape0)
        
        let shape1 = CAShapeLayer()
        var path1 = UIBezierPath()
        path1.move(to: CGPoint(x: namelabel.frame.height/2-2, y: namelabel.frame.maxY))
        path1.addLine(to: CGPoint(x: namelabel.frame.height, y: namelabel.frame.midY-2))
        path1.addLine(to: CGPoint(x: namelabel.frame.height, y: namelabel.frame.midY+2))
        path1.addLine(to: CGPoint(x: namelabel.frame.height/2+2, y: namelabel.frame.maxY))
        path1.addLine(to: CGPoint(x: namelabel.frame.height/2-2, y: namelabel.frame.maxY))
        
        shape1.path = path1.cgPath
        shape1.fillColor = UIColor.black.cgColor
        shape1.lineWidth = 2
        view.layer.addSublayer(shape1)
        */
        /*
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .whiteLarge)
        view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.topAnchor.constraint(equalTo:namelabel.bottomAnchor,constant:20).isActive = true
        activityIndicator.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        activityIndicator.frame = view.bounds
        activityIndicator.startAnimating()
        */
        if let timer = self.mTimer {
            if !timer.isValid {
                self.mTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerCallback), userInfo: nil, repeats: true)
            }
        }
        else {
            self.mTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.timerCallback), userInfo: nil, repeats: true)
        }
        
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
    
    @objc func timerCallback() {
        print("wifi name : \(getWifissid())")
        if getWifissid() == "Flex_Cine_Dimmer" {
            if let timer = mTimer {
                if ( timer.isValid ) {
                    timer.invalidate()
                    UIView.animate(withDuration: 1, animations: {self.progress_label.frame = CGRect(x: self.namelabel.frame.minX, y: self.namelabel.frame.minY, width: self.namelabel.frame.width, height: self.namelabel.frame.height)}, completion: {(complete) in
                        let urlpath = "http://192.168.4.1/get"
                        let url = NSURL(string:urlpath)
                        
                        let session = URLSession.shared
                        
                        let task = session.dataTask(with: url! as URL, completionHandler:{
                            (data,responds,error)->Void in
                            print(error)
                            if let check=data{
                                if self.check_data(text: String(decoding: check, as: UTF8.self)){
                                    DispatchQueue.main.async { // Correct
                                        check_mat = String(decoding: check, as: UTF8.self)
                                        self.show(ViewController(),sender: self)
                                    }
                                }
                            }
                            if error == nil {
                                let urlcontent = NSString(data:data!,encoding: String.Encoding.utf8.rawValue)
                            }
                            else{
                                print("error")
                            }
                        })
                        task.resume()
                        
                        })
                        
                    
                }
            }
            
            
        }
        else {
            var count:Int = 1
            
            while(true){
                if count > (UserDefaults.standard.integer(forKey: "count")) {
                    toast_message(message: "Connect Flex_Cine_Dimmer WiFi")
                    break
                }
                let text = UserDefaults.standard.string(forKey: "dev"+String(count)) ?? ""
                if getWifissid() == text {
                    if let timer = mTimer {
                        if ( timer.isValid ) {
                            timer.invalidate()
                        }
                    }
                    multi_check()
                    break
                }
                count += 1
            }
        }
    }
    func detect_model(){
        print("detect")
        print(UIDevice.modelName)
        switch UIDevice.modelName {
        case "iphone_4_7" : show(iphone_base(), sender: self)//해당 프로젝트 이름
        case "iphone_4": show(iphone_5s_SE(), sender: self)
        case "iphone_5_5": show(iphone_plus(), sender: self)
        case "iphone_5_8": show(iphone_X(), sender: self)
        case "iphone_6_1": show(iphone_XR(), sender: self)
        case "iphone_6_5": show(iphone_XS_MAX(), sender: self)
        case "ipad_7_9": show(ipad_seven_inch(),sender: self)
        case "ipad_9_7": show(ipad_nine_inch(), sender: self)
        case "ipad_10_5": show(ipad_ten_inch(), sender: self)
        case "ipad_12_9": show(ipad_twelve_inch(), sender: self)
        default: break
        }
    }
    
    func userdefaults_reset() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
    
    func multi_check() {
        guard pings.count > 0 else {
            return
        }
        
        let ping = self.pings.removeFirst()
        print("ip : "+ping)
        PlainPing.ping(ping,withTimeout: 1, completionBlock: { (timeElapsed:Double?, error:Error?) in
            if let latency = timeElapsed {
                        
                connect_device[2-self.pings.count]=1
                if self.pings.count == 0{
                    UIView.animate(withDuration: 1, animations: {self.progress_label.frame = CGRect(x: self.namelabel.frame.minX, y: self.namelabel.frame.minY, width: self.namelabel.frame.width/CGFloat(self.pings.count+1), height: self.namelabel.frame.height)}, completion: {(complete) in
                        let urlpath = "http://192.168.4.1/get"
                        let url = NSURL(string:urlpath)
                        
                        let session = URLSession.shared
                        
                        let task = session.dataTask(with: url! as URL, completionHandler:{
                            (data,responds,error)->Void in
                            print(error)
                            if let check=data{
                                if self.check_data(text: String(decoding: check, as: UTF8.self)){
                                    DispatchQueue.main.async { // Correct
                                        check_mat = String(decoding: check, as: UTF8.self)
                                        self.detect_model()
                                    }
                                }
                            }
                            if error == nil {
                                let urlcontent = NSString(data:data!,encoding: String.Encoding.utf8.rawValue)
                            }
                            else{
                                print("error")
                            }
                        })
                        task.resume()
                    })
                }
            }
            if let error = error {
                print("error: \(error.localizedDescription)")
                
                connect_device[2-self.pings.count]=0
                
                if self.pings.count == 0{
                    UIView.animate(withDuration: 1, animations: {self.progress_label.frame = CGRect(x: self.namelabel.frame.minX, y: self.namelabel.frame.minY, width: self.namelabel.frame.width/CGFloat(self.pings.count+1), height: self.namelabel.frame.height)}, completion: {(complete) in
                        let urlpath = "http://192.168.4.1/get"
                        let url = NSURL(string:urlpath)
                        
                        let session = URLSession.shared
                        
                        let task = session.dataTask(with: url! as URL, completionHandler:{
                            (data,responds,error)->Void in
                            print(error)
                            if let check=data{
                                if self.check_data(text: String(decoding: check, as: UTF8.self)){
                                    DispatchQueue.main.async { // Correct
                                        check_mat = String(decoding: check, as: UTF8.self)
                                        self.detect_model()
                                    }
                                }
                            }
                            if error == nil {
                                let urlcontent = NSString(data:data!,encoding: String.Encoding.utf8.rawValue)
                            }
                            else{
                                print("error")
                            }
                        })
                        task.resume()
                    })
                }
                else {
                    UIView.animate(withDuration: 1, animations: {self.progress_label.frame = CGRect(x: self.namelabel.frame.minX, y: self.namelabel.frame.minY, width: self.namelabel.frame.width/CGFloat(self.pings.count+1), height: self.namelabel.frame.height)})
                }
            }
                self.multi_check()
        })
    }
}

