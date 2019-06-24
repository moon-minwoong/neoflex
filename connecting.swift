//
//  connecting.swift
//  mydream
//
//  Created by 문민웅 on 2018. 6. 14..
//  Copyright © 2018년 moon. All rights reserved.
//
/*
import Foundation
import UIKit
import SystemConfiguration.CaptiveNetwork

class connecting: UIViewController {
    var indicate: UIActivityIndicatorView = UIActivityIndicatorView()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        indicate.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        indicate.center = view.center
        indicate.hidesWhenStopped = true
        indicate.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        view.addSubview(indicate)
        indicate.startAnimating()
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        let ssid = self.getwifiname()
        print("SSID :\(ssid)")
        if UIDevice().type == .iPhone6 {
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getwifiname() -> String?{
        var ssid:String?
        if let interfaces = CNCopySupportedInterfaces() as NSArray? {
            for interface in interfaces {
                if let interfaceInfo = CNCopyCurrentNetworkInfo(interface as! CFString) as NSDictionary? {
                    ssid = interfaceInfo[kCNNetworkInfoKeySSID as String] as? String
                    break
                }
            }
        }
        return ssid
    }
}
*/
