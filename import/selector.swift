//
//  selector.swift
//  mydream
//
//  Created by 문민웅 on 2018. 6. 26..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation
import UIKit
import NetworkExtension
import SystemConfiguration.CaptiveNetwork
import PlainPing

var name:String=""
var password:String = ""

@objc extension UIViewController {
    func pressbtn(_ sender:UIButton, num: Int)
    {
        switch num {
        case 1:
            if temp_p1 == 0 {
                temp_p1 = 1
                temp_p2 = 0
                temp_p3 = 0
                temp_p4 = 0
                p1btn.setTitleColor(.white, for: .normal)
                p2btn.setTitleColor(UIColor(red:102/255,green:102/255,blue:102/255,alpha:1.0), for: .normal)
                p3btn.setTitleColor(UIColor(red:102/255,green:102/255,blue:102/255,alpha:1.0), for: .normal)
                p4btn.setTitleColor(UIColor(red:102/255,green:102/255,blue:102/255,alpha:1.0), for: .normal)
                wifi_request(message: "sel10")
            }
            else{
                temp_p1 = 0
                p1btn.setTitleColor(UIColor(red:102/255,green:102/255,blue:102/255,alpha:1.0), for: .normal)
                wifi_request(message: "sel50")
            }
            break
        case 2:
            if temp_p2 == 0 {
                temp_p1 = 0
                temp_p2 = 1
                temp_p3 = 0
                temp_p4 = 0
                p2btn.setTitleColor(.white, for: .normal)
                p1btn.setTitleColor(UIColor(red:102/255,green:102/255,blue:102/255,alpha:1.0), for: .normal)
                p3btn.setTitleColor(UIColor(red:102/255,green:102/255,blue:102/255,alpha:1.0), for: .normal)
                p4btn.setTitleColor(UIColor(red:102/255,green:102/255,blue:102/255,alpha:1.0), for: .normal)
                wifi_request(message: "sel20")
            }
            else{
                temp_p2 = 0
                p2btn.setTitleColor(UIColor(red:102/255,green:102/255,blue:102/255,alpha:1.0), for: .normal)
                wifi_request(message: "sel50")
            }
            break
        case 3:
            if temp_p3 == 0 {
                temp_p1 = 0
                temp_p2 = 0
                temp_p3 = 1
                temp_p4 = 0
                p3btn.setTitleColor(.white, for: .normal)
                p2btn.setTitleColor(UIColor(red:102/255,green:102/255,blue:102/255,alpha:1.0), for: .normal)
                p1btn.setTitleColor(UIColor(red:102/255,green:102/255,blue:102/255,alpha:1.0), for: .normal)
                p4btn.setTitleColor(UIColor(red:102/255,green:102/255,blue:102/255,alpha:1.0), for: .normal)
                wifi_request(message: "sel30")
            }
            else{
                temp_p3 = 0
                p3btn.setTitleColor(UIColor(red:102/255,green:102/255,blue:102/255,alpha:1.0), for: .normal)
                wifi_request(message: "sel50")
            }
        default :
            print("hiddenasldiawnld")
            if temp_p4 == 0 {
                temp_p1 = 0
                temp_p2 = 0
                temp_p3 = 0
                temp_p4 = 1
                p4btn.setTitleColor(.white, for: .normal)
                p2btn.setTitleColor(UIColor(red:102/255,green:102/255,blue:102/255,alpha:1.0), for: .normal)
                p3btn.setTitleColor(UIColor(red:102/255,green:102/255,blue:102/255,alpha:1.0), for: .normal)
                p1btn.setTitleColor(UIColor(red:102/255,green:102/255,blue:102/255,alpha:1.0), for: .normal)
                wifi_request(message: "sel40")
            }
            else{
                temp_p4 = 0
                p4btn.setTitleColor(UIColor(red:102/255,green:102/255,blue:102/255,alpha:1.0), for: .normal)
                wifi_request(message: "sel50")
            }
        }
    }
    func pressbtn1(_ sender: UIButton){
        if stat_device {
            if stat_ch_btn[0] == 0 {
                if (multi_mat == mat_channel[0]) || (multi_mat == "Void") {
                    multi_mat = mat_channel[0]
                    stat_ch_btn[0] = 1
                    switch mat_channel[0] {
                    case "Single" : p1btn.setAttributedTitle(NSAttributedString(string: "CH1", attributes: Single_color_white), for: .normal);multi_mat_type(type: "Day");
                    multi_day_stat = 1
                    multi_slider.currentValue = Double(channel_value[0][1]);
                    multi_day_label.text = String(channel_value[0][1])+"%";break;
                    case "Bi" : p1btn.setAttributedTitle(NSAttributedString(string: "CH1", attributes: Bi_color_white), for: .normal);multi_mat_type(type: "Bi");
                    cctslider.value = Float(channel_value[0][0]);cctlabel.text = String(channel_value[0][0]*100+2800)+"K";
                    brtslider.value = Float(channel_value[0][1]);brtlabel.text = String(channel_value[0][1])+"%"
                    let red:CGFloat = (CGFloat(255+(77-255)*cctslider.value/32))
                    var green:CGFloat = (CGFloat(120+(170-120)*cctslider.value/32))
                    var blue : CGFloat = (CGFloat(40+(232-40)*cctslider.value/32))
                    cctslider.minimumTrackTintColor = UIColor(red:red/255,green:green/255,blue:blue/255,alpha:1.0)
                    cctslider.maximumTrackTintColor = UIColor(red:red/255,green:green/255,blue:blue/255,alpha:1.0)
                    var color_value:CGFloat = (CGFloat(255*brtslider.value/100))
                    brtslider.minimumTrackTintColor = UIColor(red:color_value/255,green:color_value/255,blue:color_value/255,alpha:1.0)
                    brtslider.maximumTrackTintColor = UIColor(red:color_value/255,green:color_value/255,blue:color_value/255,alpha:1.0)
                    default : break;
                    }
                }
            }
            else {
                stat_ch_btn[0] = 0
                switch mat_channel[0] {
                case "Single" : p1btn.setAttributedTitle(NSAttributedString(string: "CH1", attributes: Single_color_gray), for: .normal);break;
                case "Bi" : p1btn.setAttributedTitle(NSAttributedString(string: "CH1", attributes: Bi_color_gray), for: .normal);break;
                default : break;
                }
                for i in 0 ..< 4 {
                    if mat_channel[0] == mat_channel[i] {
                        if stat_ch_btn[i] == 1 {
                            if mat_channel[0] == "Bi" {
                                cctslider.value = Float(channel_value[i][0]);cctlabel.text = String(channel_value[i][0]*100+2800)+"K";
                                brtslider.value = Float(channel_value[i][1]);brtlabel.text = String(channel_value[i][1])+"%"
                                let red:CGFloat = (CGFloat(255+(77-255)*cctslider.value/32))
                                var green:CGFloat = (CGFloat(120+(170-120)*cctslider.value/32))
                                var blue : CGFloat = (CGFloat(40+(232-40)*cctslider.value/32))
                                cctslider.minimumTrackTintColor = UIColor(red:red/255,green:green/255,blue:blue/255,alpha:1.0)
                                cctslider.maximumTrackTintColor = UIColor(red:red/255,green:green/255,blue:blue/255,alpha:1.0)
                                var color_value:CGFloat = (CGFloat(255*brtslider.value/100))
                                brtslider.minimumTrackTintColor = UIColor(red:color_value/255,green:color_value/255,blue:color_value/255,alpha:1.0)
                                brtslider.maximumTrackTintColor = UIColor(red:color_value/255,green:color_value/255,blue:color_value/255,alpha:1.0)
                            }
                            else {
                                multi_slider.currentValue = Double(channel_value[i][1]);
                                multi_day_label.text = String(channel_value[i][1])+"%";
                            }
                        }
                    }
                }
                if (stat_ch_btn[1] == 0)&&(stat_ch_btn[2] == 0)&&(stat_ch_btn[3] == 0) {
                    multi_mat = "Void"
                }
            }
        }
        else {
            if temp_p1 == 0 {
                cctslider.isEnabled = false
                brtslider.isEnabled = false
                cctslider.value = Float(preset_value[0][0])
                cctlabel.text = String(preset_value[0][0]+28)+"00K"
                brtslider.value = Float(preset_value[0][1])
                brtlabel.text = String(preset_value[0][1])+"%"
                let red:CGFloat = (CGFloat(255+(77-255)*cctslider.value/32))
                var green:CGFloat = (CGFloat(120+(170-120)*cctslider.value/32))
                var blue : CGFloat = (CGFloat(40+(232-40)*cctslider.value/32))
                cctslider.minimumTrackTintColor = UIColor(red:red/255,green:green/255,blue:blue/255,alpha:1.0)
                cctslider.maximumTrackTintColor = UIColor(red:red/255,green:green/255,blue:blue/255,alpha:1.0)
                
                let color_value:CGFloat = (CGFloat(255*brtslider.value/100))
                brtslider.minimumTrackTintColor = UIColor(red:color_value/255,green:color_value/255,blue:color_value/255,alpha:1.0)
                brtslider.maximumTrackTintColor = UIColor(red:color_value/255,green:color_value/255,blue:color_value/255,alpha:1.0)
                
                stat_btn = 1
                temp_p1 = 1
                temp_p2 = 0
                temp_p3 = 0
                temp_p4 = 0
                p1btn.setAttributedTitle(NSAttributedString(string: "P1", attributes: preset_btn_design_white), for: .normal)
                p4btn.setAttributedTitle(NSAttributedString(string: "P4", attributes: preset_btn_design_gray), for: .normal)
                p2btn.setAttributedTitle(NSAttributedString(string: "P2", attributes: preset_btn_design_gray), for: .normal)
                p3btn.setAttributedTitle(NSAttributedString(string: "P3", attributes: preset_btn_design_gray), for: .normal)
                wifi_request(message: "sel10")
            }
            else{
                cctslider.isEnabled = true
                brtslider.isEnabled = true
                stat_btn = 0
                temp_p1 = 0
                p1btn.setAttributedTitle(NSAttributedString(string: "P1", attributes: preset_btn_design_gray), for: .normal)
                wifi_request(message: "sel50")
            }
        }
    }
    func pressbtn2(_ sender: UIButton){
        if stat_device {
            if stat_ch_btn[1] == 0 {
                if (multi_mat == mat_channel[1]) || (multi_mat == "Void") {
                    multi_mat = mat_channel[1]
                    stat_ch_btn[1] = 1
                    switch mat_channel[1] {
                    case "Single" : p2btn.setAttributedTitle(NSAttributedString(string: "CH2", attributes: Single_color_white), for: .normal);multi_mat_type(type: "Day");
                    multi_day_stat = 2
                    multi_slider.currentValue = Double(channel_value[1][1]);
                    multi_day_label.text = String(channel_value[1][1])+"%";
                    break;
                    case "Bi" : p2btn.setAttributedTitle(NSAttributedString(string: "CH2", attributes: Bi_color_white), for: .normal);multi_mat_type(type: "Bi");
                    cctslider.value = Float(channel_value[1][0]);cctlabel.text = String(channel_value[1][0]*100+2800)+"K";
                    brtslider.value = Float(channel_value[1][1]);brtlabel.text = String(channel_value[1][1])+"%";
                    let red:CGFloat = (CGFloat(255+(77-255)*cctslider.value/32))
                    var green:CGFloat = (CGFloat(120+(170-120)*cctslider.value/32))
                    var blue : CGFloat = (CGFloat(40+(232-40)*cctslider.value/32))
                    cctslider.minimumTrackTintColor = UIColor(red:red/255,green:green/255,blue:blue/255,alpha:1.0)
                    cctslider.maximumTrackTintColor = UIColor(red:red/255,green:green/255,blue:blue/255,alpha:1.0)
                    var color_value:CGFloat = (CGFloat(255*brtslider.value/100))
                    brtslider.minimumTrackTintColor = UIColor(red:color_value/255,green:color_value/255,blue:color_value/255,alpha:1.0)
                    brtslider.maximumTrackTintColor = UIColor(red:color_value/255,green:color_value/255,blue:color_value/255,alpha:1.0)
                    default : break;
                    }
                }
            }
            else {
                stat_ch_btn[1] = 0
                switch mat_channel[1] {
                case "Single" : p2btn.setAttributedTitle(NSAttributedString(string: "CH2", attributes: Single_color_gray), for: .normal);break;
                case "Bi" : p2btn.setAttributedTitle(NSAttributedString(string: "CH2", attributes: Bi_color_gray), for: .normal);break;
                default : break;
                }
                for i in 0 ..< 4 {
                    if mat_channel[1] == mat_channel[i] {
                        if stat_ch_btn[i] == 1 {
                            if mat_channel[1] == "Bi" {
                                cctslider.value = Float(channel_value[i][0]);cctlabel.text = String(channel_value[i][0]*100+2800)+"K";
                                brtslider.value = Float(channel_value[i][1]);brtlabel.text = String(channel_value[i][1])+"%"
                                let red:CGFloat = (CGFloat(255+(77-255)*cctslider.value/32))
                                var green:CGFloat = (CGFloat(120+(170-120)*cctslider.value/32))
                                var blue : CGFloat = (CGFloat(40+(232-40)*cctslider.value/32))
                                cctslider.minimumTrackTintColor = UIColor(red:red/255,green:green/255,blue:blue/255,alpha:1.0)
                                cctslider.maximumTrackTintColor = UIColor(red:red/255,green:green/255,blue:blue/255,alpha:1.0)
                                var color_value:CGFloat = (CGFloat(255*brtslider.value/100))
                                brtslider.minimumTrackTintColor = UIColor(red:color_value/255,green:color_value/255,blue:color_value/255,alpha:1.0)
                                brtslider.maximumTrackTintColor = UIColor(red:color_value/255,green:color_value/255,blue:color_value/255,alpha:1.0)
                            }
                            else {
                                multi_slider.currentValue = Double(channel_value[i][1]);
                                multi_day_label.text = String(channel_value[i][1])+"%";
                            }
                        }
                    }
                }
                if (stat_ch_btn[0] == 0)&&(stat_ch_btn[2] == 0)&&(stat_ch_btn[3] == 0) {
                    multi_mat = "Void"
                }
            }
        }
        else {
            if temp_p2 == 0 {
                cctslider.isEnabled = false
                brtslider.isEnabled = false
                cctslider.value = Float(preset_value[1][0])
                cctlabel.text = String(preset_value[1][0]+28)+"00K"
                brtslider.value = Float(preset_value[1][1])
                brtlabel.text = String(preset_value[1][1])+"%"
                let red:CGFloat = (CGFloat(255+(77-255)*cctslider.value/32))
                var green:CGFloat = (CGFloat(120+(170-120)*cctslider.value/32))
                var blue : CGFloat = (CGFloat(40+(232-40)*cctslider.value/32))
                cctslider.minimumTrackTintColor = UIColor(red:red/255,green:green/255,blue:blue/255,alpha:1.0)
                cctslider.maximumTrackTintColor = UIColor(red:red/255,green:green/255,blue:blue/255,alpha:1.0)
                
                let color_value:CGFloat = (CGFloat(255*brtslider.value/100))
                brtslider.minimumTrackTintColor = UIColor(red:color_value/255,green:color_value/255,blue:color_value/255,alpha:1.0)
                brtslider.maximumTrackTintColor = UIColor(red:color_value/255,green:color_value/255,blue:color_value/255,alpha:1.0)
                stat_btn = 2
                temp_p1 = 0
                temp_p2 = 1
                temp_p3 = 0
                temp_p4 = 0
                p2btn.setAttributedTitle(NSAttributedString(string: "P2", attributes: preset_btn_design_white), for: .normal)
                p1btn.setAttributedTitle(NSAttributedString(string: "P1", attributes: preset_btn_design_gray), for: .normal)
                p4btn.setAttributedTitle(NSAttributedString(string: "P4", attributes: preset_btn_design_gray), for: .normal)
                p3btn.setAttributedTitle(NSAttributedString(string: "P3", attributes: preset_btn_design_gray), for: .normal)
                wifi_request(message: "sel20")
            }
            else{
                cctslider.isEnabled = true
                brtslider.isEnabled = true
                stat_btn = 0
                temp_p2 = 0
                p2btn.setAttributedTitle(NSAttributedString(string: "P2", attributes: preset_btn_design_gray), for: .normal)
                wifi_request(message: "sel50")
            }
        }
    }
    func pressbtn3(_ sender: UIButton){
        if stat_device {
            if stat_ch_btn[2] == 0 {
                if (multi_mat == mat_channel[2]) || (multi_mat == "Void") {
                    multi_mat = mat_channel[2]
                    stat_ch_btn[2] = 1
                    switch mat_channel[2] {
                    case "Single" : p3btn.setAttributedTitle(NSAttributedString(string: "CH3", attributes: Single_color_white), for: .normal);multi_mat_type(type: "Day");
                    multi_day_stat = 3
                    multi_slider.currentValue = Double(channel_value[2][1]);
                    multi_day_label.text = String(channel_value[2][1])+"%";break;
                    case "Bi" : p3btn.setAttributedTitle(NSAttributedString(string: "CH3", attributes: Bi_color_white), for: .normal);multi_mat_type(type: "Bi");
                    cctslider.value = Float(channel_value[2][0]);cctlabel.text = String(channel_value[2][0]*100+2800)+"K";
                    brtslider.value = Float(channel_value[2][1]);brtlabel.text = String(channel_value[2][1])+"%";
                    let red:CGFloat = (CGFloat(255+(77-255)*cctslider.value/32))
                    var green:CGFloat = (CGFloat(120+(170-120)*cctslider.value/32))
                    var blue : CGFloat = (CGFloat(40+(232-40)*cctslider.value/32))
                    cctslider.minimumTrackTintColor = UIColor(red:red/255,green:green/255,blue:blue/255,alpha:1.0)
                    cctslider.maximumTrackTintColor = UIColor(red:red/255,green:green/255,blue:blue/255,alpha:1.0)
                    var color_value:CGFloat = (CGFloat(255*brtslider.value/100))
                    brtslider.minimumTrackTintColor = UIColor(red:color_value/255,green:color_value/255,blue:color_value/255,alpha:1.0)
                    brtslider.maximumTrackTintColor = UIColor(red:color_value/255,green:color_value/255,blue:color_value/255,alpha:1.0)
                    default : break;
                    }
                }
            }
            else {
                stat_ch_btn[2] = 0
                switch mat_channel[2] {
                case "Single" : p3btn.setAttributedTitle(NSAttributedString(string: "CH3", attributes: Single_color_gray), for: .normal);break;
                case "Bi" : p3btn.setAttributedTitle(NSAttributedString(string: "CH3", attributes: Bi_color_gray), for: .normal);break;
                default : break;
                }
                for i in 0 ..< 4 {
                    if mat_channel[2] == mat_channel[i] {
                        if stat_ch_btn[i] == 1 {
                            if mat_channel[2] == "Bi" {
                                cctslider.value = Float(channel_value[i][0]);cctlabel.text = String(channel_value[i][0]*100+2800)+"K";
                                brtslider.value = Float(channel_value[i][1]);brtlabel.text = String(channel_value[i][1])+"%"
                                let red:CGFloat = (CGFloat(255+(77-255)*cctslider.value/32))
                                var green:CGFloat = (CGFloat(120+(170-120)*cctslider.value/32))
                                var blue : CGFloat = (CGFloat(40+(232-40)*cctslider.value/32))
                                cctslider.minimumTrackTintColor = UIColor(red:red/255,green:green/255,blue:blue/255,alpha:1.0)
                                cctslider.maximumTrackTintColor = UIColor(red:red/255,green:green/255,blue:blue/255,alpha:1.0)
                                var color_value:CGFloat = (CGFloat(255*brtslider.value/100))
                                brtslider.minimumTrackTintColor = UIColor(red:color_value/255,green:color_value/255,blue:color_value/255,alpha:1.0)
                                brtslider.maximumTrackTintColor = UIColor(red:color_value/255,green:color_value/255,blue:color_value/255,alpha:1.0)
                            }
                            else {
                                multi_slider.currentValue = Double(channel_value[i][1]);
                                multi_day_label.text = String(channel_value[i][1])+"%";
                            }
                        }
                    }
                }
                if (stat_ch_btn[0] == 0)&&(stat_ch_btn[1] == 0)&&(stat_ch_btn[3] == 0) {
                    multi_mat = "Void"
                }
            }
        }
        else {
            if temp_p3 == 0 {
                cctslider.isEnabled = false
                brtslider.isEnabled = false
                cctslider.value = Float(preset_value[2][0])
                cctlabel.text = String(preset_value[2][0]+28)+"00K"
                brtslider.value = Float(preset_value[2][1])
                brtlabel.text = String(preset_value[2][1])+"%"
                let red:CGFloat = (CGFloat(255+(77-255)*cctslider.value/32))
                var green:CGFloat = (CGFloat(120+(170-120)*cctslider.value/32))
                var blue : CGFloat = (CGFloat(40+(232-40)*cctslider.value/32))
                cctslider.minimumTrackTintColor = UIColor(red:red/255,green:green/255,blue:blue/255,alpha:1.0)
                cctslider.maximumTrackTintColor = UIColor(red:red/255,green:green/255,blue:blue/255,alpha:1.0)
                
                let color_value:CGFloat = (CGFloat(255*brtslider.value/100))
                brtslider.minimumTrackTintColor = UIColor(red:color_value/255,green:color_value/255,blue:color_value/255,alpha:1.0)
                brtslider.maximumTrackTintColor = UIColor(red:color_value/255,green:color_value/255,blue:color_value/255,alpha:1.0)
                stat_btn = 3
                temp_p1 = 0
                temp_p2 = 0
                temp_p3 = 1
                temp_p4 = 0
                p3btn.setAttributedTitle(NSAttributedString(string: "P3", attributes: preset_btn_design_white), for: .normal)
                p1btn.setAttributedTitle(NSAttributedString(string: "P1", attributes: preset_btn_design_gray), for: .normal)
                p2btn.setAttributedTitle(NSAttributedString(string: "P2", attributes: preset_btn_design_gray), for: .normal)
                p4btn.setAttributedTitle(NSAttributedString(string: "P4", attributes: preset_btn_design_gray), for: .normal)
                wifi_request(message: "sel30")
            }
            else{
                cctslider.isEnabled = true
                brtslider.isEnabled = true
                stat_btn = 0
                temp_p3 = 0
                p3btn.setAttributedTitle(NSAttributedString(string: "P3", attributes: preset_btn_design_gray), for: .normal)
                wifi_request(message: "sel50")
            }
        }
    }
    func pressbtn4(_ sender: UIButton){
        if stat_device {
            if stat_ch_btn[3] == 0 {
                if (multi_mat == mat_channel[3]) || (multi_mat == "Void") {
                    multi_mat = mat_channel[3]
                    stat_ch_btn[3] = 1
                    switch mat_channel[3] {
                    case "Single" : p4btn.setAttributedTitle(NSAttributedString(string: "CH4", attributes: Single_color_white), for: .normal);multi_mat_type(type: "Day");
                    multi_day_stat = 4
                    multi_slider.currentValue = Double(channel_value[3][1]);
                    multi_day_label.text = String(channel_value[3][1])+"%";break;
                    case "Bi" : p4btn.setAttributedTitle(NSAttributedString(string: "CH4", attributes: Bi_color_white), for: .normal);multi_mat_type(type: "Bi");
                    cctslider.value = Float(channel_value[3][0]);cctlabel.text = String(channel_value[3][0]*100+2800)+"K";
                    brtslider.value = Float(channel_value[3][1]);brtlabel.text = String(channel_value[3][1])+"%";
                    let red:CGFloat = (CGFloat(255+(77-255)*cctslider.value/32))
                    var green:CGFloat = (CGFloat(120+(170-120)*cctslider.value/32))
                    var blue : CGFloat = (CGFloat(40+(232-40)*cctslider.value/32))
                    cctslider.minimumTrackTintColor = UIColor(red:red/255,green:green/255,blue:blue/255,alpha:1.0)
                    cctslider.maximumTrackTintColor = UIColor(red:red/255,green:green/255,blue:blue/255,alpha:1.0)
                    var color_value:CGFloat = (CGFloat(255*brtslider.value/100))
                    brtslider.minimumTrackTintColor = UIColor(red:color_value/255,green:color_value/255,blue:color_value/255,alpha:1.0)
                    brtslider.maximumTrackTintColor = UIColor(red:color_value/255,green:color_value/255,blue:color_value/255,alpha:1.0)
                    default : break;
                    }
                }
            }
            else {
                stat_ch_btn[3] = 0
                switch mat_channel[3] {
                case "Single" : p4btn.setAttributedTitle(NSAttributedString(string: "CH4", attributes: Single_color_gray), for: .normal);break;
                case "Bi" : p4btn.setAttributedTitle(NSAttributedString(string: "CH4", attributes: Bi_color_gray), for: .normal);break;
                default : break;
                }
                for i in 0 ..< 4 {
                    if mat_channel[3] == mat_channel[i] {
                        if stat_ch_btn[i] == 1 {
                            if mat_channel[3] == "Bi" {
                                cctslider.value = Float(channel_value[i][0]);cctlabel.text = String(channel_value[i][0]*100+2800)+"K";
                                brtslider.value = Float(channel_value[i][1]);brtlabel.text = String(channel_value[i][1])+"%"
                                let red:CGFloat = (CGFloat(255+(77-255)*cctslider.value/32))
                                var green:CGFloat = (CGFloat(120+(170-120)*cctslider.value/32))
                                var blue : CGFloat = (CGFloat(40+(232-40)*cctslider.value/32))
                                cctslider.minimumTrackTintColor = UIColor(red:red/255,green:green/255,blue:blue/255,alpha:1.0)
                                cctslider.maximumTrackTintColor = UIColor(red:red/255,green:green/255,blue:blue/255,alpha:1.0)
                                var color_value:CGFloat = (CGFloat(255*brtslider.value/100))
                                brtslider.minimumTrackTintColor = UIColor(red:color_value/255,green:color_value/255,blue:color_value/255,alpha:1.0)
                                brtslider.maximumTrackTintColor = UIColor(red:color_value/255,green:color_value/255,blue:color_value/255,alpha:1.0)
                            }
                            else {
                                multi_slider.currentValue = Double(channel_value[i][1]);
                                multi_day_label.text = String(channel_value[i][1])+"%";
                            }
                        }
                    }
                }
                if (stat_ch_btn[0] == 0)&&(stat_ch_btn[1] == 0)&&(stat_ch_btn[2] == 0) {
                    multi_mat = "Void"
                }
            }
        }
        else {
            if temp_p4 == 0 {
                cctslider.isEnabled = false
                brtslider.isEnabled = false
                cctslider.value = Float(preset_value[3][0])
                cctlabel.text = String(preset_value[3][0]+28)+"00K"
                brtslider.value = Float(preset_value[3][1])
                brtlabel.text = String(preset_value[3][1])+"%"
                let red:CGFloat = (CGFloat(255+(77-255)*cctslider.value/32))
                var green:CGFloat = (CGFloat(120+(170-120)*cctslider.value/32))
                var blue : CGFloat = (CGFloat(40+(232-40)*cctslider.value/32))
                cctslider.minimumTrackTintColor = UIColor(red:red/255,green:green/255,blue:blue/255,alpha:1.0)
                cctslider.maximumTrackTintColor = UIColor(red:red/255,green:green/255,blue:blue/255,alpha:1.0)
                
                let color_value:CGFloat = (CGFloat(255*brtslider.value/100))
                brtslider.minimumTrackTintColor = UIColor(red:color_value/255,green:color_value/255,blue:color_value/255,alpha:1.0)
                brtslider.maximumTrackTintColor = UIColor(red:color_value/255,green:color_value/255,blue:color_value/255,alpha:1.0)
                stat_btn = 4
                temp_p1 = 0
                temp_p2 = 0
                temp_p3 = 0
                temp_p4 = 1
                p4btn.setAttributedTitle(NSAttributedString(string: "P4", attributes: preset_btn_design_white), for: .normal)
                p1btn.setAttributedTitle(NSAttributedString(string: "P1", attributes: preset_btn_design_gray), for: .normal)
                p2btn.setAttributedTitle(NSAttributedString(string: "P2", attributes: preset_btn_design_gray), for: .normal)
                p3btn.setAttributedTitle(NSAttributedString(string: "P3", attributes: preset_btn_design_gray), for: .normal)
                wifi_request(message: "sel40")
            }
            else{
                cctslider.isEnabled = true
                brtslider.isEnabled = true
                stat_btn = 0
                temp_p4 = 0
                p4btn.setAttributedTitle(NSAttributedString(string: "P4", attributes: preset_btn_design_gray), for: .normal)
                wifi_request(message: "sel50")
            }
        }
    }
    func cctslide(_ sender: Any){
        print("temp_cct:\(temp_cct), slide_value:\(cctslider.value)")
        if true {
            if temp_cct == Int(cctslider.value){
                return
            }
            
            temp_cct = Int(cctslider.value)
            cctlabel.text = String(Int(cctslider.value)*100+2800)+"K"
            let red:CGFloat = (CGFloat(255+(77-255)*cctslider.value/32))
            var green:CGFloat = (CGFloat(120+(170-120)*cctslider.value/32))
            var blue : CGFloat = (CGFloat(40+(232-40)*cctslider.value/32))
            cctslider.minimumTrackTintColor = UIColor(red:red/255,green:green/255,blue:blue/255,alpha:1.0)
            cctslider.maximumTrackTintColor = UIColor(red:red/255,green:green/255,blue:blue/255,alpha:1.0)
            if stat_device {
                if stat_ch_btn[0] == 1 {
                    channel_value[0][0] = temp_cct
                    cct1label.text = String(temp_cct*100+2800)+"K"
                    wifi_request_multi(channel: "1", message: "cct"+String(Int(cctslider.value)))
                }
                if stat_ch_btn[1] == 1 {
                    channel_value[1][0] = temp_cct
                    cct2label.text = String(temp_cct*100+2800)+"K"
                    wifi_request_multi(channel: "3", message: "cct"+String(Int(cctslider.value)))
                }
                if stat_ch_btn[2] == 1 {
                    channel_value[2][0] = temp_cct
                    cct3label.text = String(temp_cct*100+2800)+"K"
                    wifi_request_multi(channel: "4", message: "cct"+String(Int(cctslider.value)))
                }
                if stat_ch_btn[3] == 1 {
                    channel_value[3][0] = temp_cct
                    cct4label.text = String(temp_cct*100+2800)+"K"
                    wifi_request_multi(channel: "5", message: "cct"+String(Int(cctslider.value)))
                }
            }
            else {
                wifi_request(message: "cct"+String(Int(cctslider.value)))
            }
        }
        else {
            if ( temp_cct == Int(bigcctslider.value)){
                return
            }
                print(cctslider.value)
                temp_cct = Int(bigcctslider.value)
                cctlabel.text = String(Int(bigcctslider.value)*100+2800)+"K"
                var green:CGFloat = (CGFloat(120+(202-120)*bigcctslider.value/32))
                var blue : CGFloat = (CGFloat(40+(0-40)*bigcctslider.value/32))
                bigcctslider.minimumTrackTintColor = UIColor(red:255/255,green:green/255,blue:blue/255,alpha:1.0)
                wifi_request(message: "cct"+String(Int(bigcctslider.value)))
        }
    }
    
    func brtslide(_ sender: Any){
        if true {
            if ( temp_brt == Int(brtslider.value)){
                return
            }
            temp_brt = Int(brtslider.value)
            brtlabel.text = String(Int(brtslider.value))+"%"
            var color_value:CGFloat = (CGFloat(255*brtslider.value/100))
            brtslider.minimumTrackTintColor = UIColor(red:color_value/255,green:color_value/255,blue:color_value/255,alpha:1.0)
            brtslider.maximumTrackTintColor = UIColor(red:color_value/255,green:color_value/255,blue:color_value/255,alpha:1.0)
            if stat_device {
                if stat_ch_btn[0] == 1 {
                    channel_value[0][1] = temp_brt
                    brt1label.text = String(temp_brt)+"%"
                    wifi_request_multi(channel: "1", message: "brt"+String(Int(brtslider.value)))
                }
                if stat_ch_btn[1] == 1 {
                    channel_value[1][1] = temp_brt
                    brt2label.text = String(temp_brt)+"%"
                    wifi_request_multi(channel: "3", message: "brt"+String(Int(brtslider.value)))
                }
                if stat_ch_btn[2] == 1 {
                    channel_value[2][1] = temp_brt
                    brt3label.text = String(temp_brt)+"%"
                    wifi_request_multi(channel: "4", message: "brt"+String(Int(brtslider.value)))
                }
                if stat_ch_btn[3] == 1 {
                    channel_value[3][1] = temp_brt
                    brt4label.text = String(temp_brt)+"%"
                    wifi_request_multi(channel: "5", message: "brt"+String(Int(brtslider.value)))
                }
            }
            else {
                wifi_request(message: "brt"+String(Int(brtslider.value)))
            }
            
            
        }
        else {
            if ( temp_brt == Int(bigbrtslider.value)){
                return
            }
            
            temp_brt = Int(bigbrtslider.value)
            brtlabel.text = String(Int(bigbrtslider.value))+"%"
            var color_value:CGFloat = (CGFloat(255*bigbrtslider.value/100))
            print(color_value)
            bigbrtslider.minimumTrackTintColor = UIColor(red:color_value/255,green:color_value/255,blue:color_value/255,alpha:1.0)
            wifi_request(message: "brt"+String(Int(bigbrtslider.value)))
            
        }
        
    }
    func day_slide(_ sender: Any){
        if ( day_brt == Int(slider.currentValue)){
            return
        }
        day_brt = Int(slider.currentValue)
        
        day_brt = Int(slider.currentValue)
        day_label.text = String(day_brt)+"%"
        wifi_request(message: "brt"+String(day_brt))
        
    }
    func multi_day_slide(_ sender: Any) {
        if ( multi_day_brt == Int(multi_slider.currentValue)){
            return
        }
        multi_day_brt = Int(multi_slider.currentValue)
        
        if multi_day_stat == 0 {
            if stat_ch_btn[0] == 1 {
                channel_value[0][1] = multi_day_brt
                brt1label.text = String(channel_value[0][1])+"%"
                multi_day_label.text = String(channel_value[0][1])+"%"
                wifi_request_multi(channel: "1", message: "brt"+String(channel_value[0][1]))
            }
            if stat_ch_btn[1] == 1 {
                channel_value[1][1] = multi_day_brt
                brt2label.text = String(channel_value[1][1])+"%"
                multi_day_label.text = String(channel_value[1][1])+"%"
                wifi_request_multi(channel: "3", message: "brt"+String(channel_value[1][1]))
            }
            if stat_ch_btn[2] == 1 {
                channel_value[2][1] = multi_day_brt
                brt3label.text = String(channel_value[2][1])+"%"
                multi_day_label.text = String(channel_value[2][1])+"%"
                wifi_request_multi(channel: "4", message: "brt"+String(channel_value[2][1]))
            }
            if stat_ch_btn[3] == 1 {
                channel_value[3][1] = multi_day_brt
                brt4label.text = String(channel_value[3][1])+"%"
                multi_day_label.text = String(channel_value[3][1])+"%"
                wifi_request_multi(channel: "5", message: "brt"+String(channel_value[3][1]))
            }
        }
        else {
            switch multi_day_stat {
            case 1 :channel_value[0][1] = multi_day_brt
            brt1label.text = String(channel_value[0][1])+"%"
            multi_day_label.text = String(channel_value[0][1])+"%"
            wifi_request_multi(channel: "1", message: "brt"+String(channel_value[0][1]))
            case 2: channel_value[1][1] = multi_day_brt
            brt2label.text = String(channel_value[1][1])+"%"
            multi_day_label.text = String(channel_value[1][1])+"%"
            wifi_request_multi(channel: "3", message: "brt"+String(channel_value[1][1]))
            case 3 :
                channel_value[2][1] = multi_day_brt
                brt3label.text = String(channel_value[2][1])+"%"
                multi_day_label.text = String(channel_value[2][1])+"%"
                wifi_request_multi(channel: "4", message: "brt"+String(channel_value[2][1]))
            case 4: channel_value[3][1] = multi_day_brt
            brt4label.text = String(channel_value[3][1])+"%"
            multi_day_label.text = String(channel_value[3][1])+"%"
            wifi_request_multi(channel: "5", message: "brt"+String(channel_value[3][1]))
            default : break
            }
        }
        multi_day_stat = 0
    }
    func reset(_ sender: Any){
        if stat_device {
            let alertController = UIAlertController(title: "Reset error", message:"Reset is not possible in multi wifi", preferredStyle: .alert)
            let Action = UIAlertAction(title:"OK", style:.default)
            alertController.addAction(Action)
            self.present(alertController, animated: true, completion: nil)
        }
        else {
            if UserDefaults.standard.integer(forKey: "dev"+String(device_count)+"mode") == 1 {
                let alertController = UIAlertController(title: "Reset error", message:"Reset is not possible because another dimmer is connected", preferredStyle: .alert)
                let Action = UIAlertAction(title:"OK", style:.default)
                alertController.addAction(Action)
                self.present(alertController, animated: true, completion: nil)
            }
            else if UserDefaults.standard.integer(forKey: "dev"+String(device_count)+"mode") == 2 {
                let alertController = UIAlertController(title: "Reset error", message:"Reset is not possible because current dimmer is connected at another dimmer", preferredStyle: .alert)
                let Action = UIAlertAction(title:"OK", style:.default)
                alertController.addAction(Action)
                self.present(alertController, animated: true, completion: nil)
            }
            else {
                let alertController = UIAlertController(title: "Reset", message:"Are you sure you want to reset the WiFi", preferredStyle: .alert)
                
                let connectAction = UIAlertAction(title: "OK", style: .default, handler: { alert -> Void in
                    var reset_count:Int = 1
                    while(true) {
                        let text = UserDefaults.standard.string(forKey: "dev"+String(reset_count)) ?? ""
                        print(text)
                        if text == self.getWifissid() {
                            UserDefaults.standard.removeObject(forKey: "dev"+String(reset_count))
                            UserDefaults.standard.removeObject(forKey: "dev"+String(reset_count)+"password")
                            self.wifi_request(message: "res")
                            break
                        }
                        reset_count += 1
                    }
                    
                })
                let cancel_action = UIAlertAction(title: "CANCEL", style: .cancel, handler: { alert -> Void in
                    
                })
                alertController.addAction(connectAction)
                alertController.addAction(cancel_action)
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }
    func wifi_request(message: String){
        let urlpath = "http://192.168.4.1/"+message
        let url = NSURL(string:urlpath)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url! as URL, completionHandler:{
            (data,responds,error)->Void in
            
            if error == nil {
                let urlcontent = NSString(data:data!,encoding: String.Encoding.utf8.rawValue)
                print(urlcontent ?? "no content")
                
            }
            else{
                print("error")
            }
        })
        task.resume()

    }
    func wifi_request_multi(channel: String, message: String){
        
        let urlpath = "http://192.168.4."+channel+"/"+message
        let url = NSURL(string:urlpath)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url! as URL, completionHandler:{
            (data,responds,error)->Void in
            
            if error == nil {
                let urlcontent = NSString(data:data!,encoding: String.Encoding.utf8.rawValue)
                print(urlcontent ?? "no content")
                
            }
            else{
                print("error")
            }
        })
        task.resume()
        
    }
    func getdata(){
        
        let urlpath = "http://192.168.4.1/get"
        let url = NSURL(string:urlpath)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url! as URL, completionHandler:{
            (data,responds,error)->Void in
            print(error)
            if let check=data{
                if self.check_data(text: String(decoding: check, as: UTF8.self)){
                    DispatchQueue.main.async { // Correct
                        self.apply_data(text: String(decoding: check, as: UTF8.self))
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
    }
    
    func multi_getdata(ip:String) {
        let urlpath = "http://192.168.4."+ip+"/get"
        let url = NSURL(string:urlpath)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url! as URL, completionHandler:{
            (data,responds,error)->Void in
            print(error)
            if let check=data{
                if self.check_data(text: String(decoding: check, as: UTF8.self)){
                    DispatchQueue.main.async { // Correct
                        self.multi_apply_data(text: String(decoding: check, as: UTF8.self), ip_address: ip)
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
    }
    func multi_apply_data(text:String, ip_address:String) {
        if ip_address == "1" {
            p1btn.isHidden = false
            cct1label.isHidden = false
            brt1label.isHidden = false
            ch1label.isHidden = false
            ch1label.text = "CH1"
            cct1label.text = String(Int(text.substring(startIndex: 38, endIndex: 39))!*100+2800)+"K"
            brt1label.text = String(Int(text.substring(startIndex: 42, endIndex: 44))!)+"%"
            channel_value[0][0] = Int(text.substring(startIndex: 38, endIndex: 39))!
            channel_value[0][1] = Int(text.substring(startIndex: 42, endIndex: 44))!
            
            switch Int(text.substring(startIndex: 52, endIndex: 52)) {
            case 1, 4 :
                if stat_swipe == 0 {
                    if multi_mat == "Void" {
                        multi_mat = "Single"
                        mat_channel[0]="Single"
                        multi_mat_type(type: "Day")
                    }
                }
                if stat_ch_btn[0] == 1 {
                    p1btn.setAttributedTitle(NSAttributedString(string: "CH1", attributes: Single_color_white), for: .normal);cct1label.isHidden = true;
                }
                else {
                    p1btn.setAttributedTitle(NSAttributedString(string: "CH1", attributes: Single_color_gray), for: .normal);cct1label.isHidden = true;
                }
                
            multi_slider.currentValue = Double(text.substring(startIndex: 42, endIndex: 44))!;
            multi_day_label.text = String(Int(text.substring(startIndex: 42, endIndex: 44))!)+"%";
            break;
            case 2, 7, 8 :
                if stat_swipe == 0 {
                    if multi_mat == "Void" {
                        multi_mat = "Bi"
                        mat_channel[0]="Bi"
                        multi_mat_type(type: "Bi")
                    }
                }
                if stat_ch_btn[0] == 1 {
                    p1btn.setAttributedTitle(NSAttributedString(string: "CH1", attributes: Bi_color_white), for: .normal);cct1label.isHidden = false
                }
                else {
                    p1btn.setAttributedTitle(NSAttributedString(string: "CH1", attributes: Bi_color_gray), for: .normal);cct1label.isHidden = false;break;
                }
            default : break;
            }
        }
        else if ip_address == "3" {
            p2btn.isHidden = false
            cct2label.isHidden = false
            brt2label.isHidden = false
            ch2label.isHidden = false
            ch2label.text = "CH2"
            cct2label.text = String(Int(text.substring(startIndex: 38, endIndex: 39))!*100+2800)+"K"
            brt2label.text = String(Int(text.substring(startIndex: 42, endIndex: 44))!)+"%"
            channel_value[1][0] = Int(text.substring(startIndex: 38, endIndex: 39))!
            channel_value[1][1] = Int(text.substring(startIndex: 42, endIndex: 44))!
            switch Int(text.substring(startIndex: 52, endIndex: 52)) {
            case 1, 4 :
                if stat_ch_btn[1] == 1 {
                    p2btn.setAttributedTitle(NSAttributedString(string: "CH2", attributes: Single_color_white), for: .normal);mat_channel[1]="Single";cct2label.isHidden = true;
                }
                else {
                    p2btn.setAttributedTitle(NSAttributedString(string: "CH2", attributes: Single_color_gray), for: .normal);mat_channel[1]="Single";cct2label.isHidden = true;
                }
            break;
            case 2, 7, 8 :
                if stat_ch_btn[1] == 1 {
                    p2btn.setAttributedTitle(NSAttributedString(string: "CH2", attributes: Bi_color_white), for: .normal);mat_channel[1]="Bi";cct2label.isHidden = false;break;
                }
                else {
                    p2btn.setAttributedTitle(NSAttributedString(string: "CH2", attributes: Bi_color_gray), for: .normal);mat_channel[1]="Bi";cct2label.isHidden = false;break;
                }
            default : break;
            }
            
        }
        else if ip_address == "4" {
            p3btn.isHidden = false
            cct3label.isHidden = false
            brt3label.isHidden = false
            ch3label.isHidden = false
            ch3label.text = "CH3"
            cct3label.text = String(Int(text.substring(startIndex: 38, endIndex: 39))!*100+2800)+"K"
            brt3label.text = String(Int(text.substring(startIndex: 42, endIndex: 44))!)+"%"
            channel_value[2][0] = Int(text.substring(startIndex: 38, endIndex: 39))!
            channel_value[2][1] = Int(text.substring(startIndex: 42, endIndex: 44))!
            switch Int(text.substring(startIndex: 52, endIndex: 52)) {
            case 1, 4 :
                if stat_ch_btn[2] == 1 {
                    p3btn.setAttributedTitle(NSAttributedString(string: "CH3", attributes: Single_color_white), for: .normal);mat_channel[2]="Single";cct3label.isHidden = true;break;
                }
                else {
                    p3btn.setAttributedTitle(NSAttributedString(string: "CH3", attributes: Single_color_gray), for: .normal);mat_channel[2]="Single";cct3label.isHidden = true;break;
                }
            case 2, 7, 8 :
                if stat_ch_btn[2] == 1 {
                    p3btn.setAttributedTitle(NSAttributedString(string: "CH3", attributes: Bi_color_white), for: .normal);mat_channel[2]="Bi";cct3label.isHidden = false;break;
                }
                else {
                    p3btn.setAttributedTitle(NSAttributedString(string: "CH3", attributes: Bi_color_gray), for: .normal);mat_channel[2]="Bi";cct3label.isHidden = false;break;
                }
            default : break;
            }
        }
        else {
            p4btn.isHidden = false
            cct4label.isHidden = false
            brt4label.isHidden = false
            ch4label.isHidden = false
            ch4label.text = "CH4"
            cct4label.text = String(Int(text.substring(startIndex: 38, endIndex: 39))!*100+2800)+"K"
            brt4label.text = String(Int(text.substring(startIndex: 42, endIndex: 44))!)+"%"
            
            channel_value[3][0] = Int(text.substring(startIndex: 38, endIndex: 39))!
            channel_value[3][1] = Int(text.substring(startIndex: 42, endIndex: 44))!
            switch Int(text.substring(startIndex: 52, endIndex: 52)) {
            case 1, 4 :
                if stat_ch_btn[3] == 1 {
                    p4btn.setAttributedTitle(NSAttributedString(string: "CH4", attributes: Single_color_white), for: .normal);mat_channel[3]="Single";cct4label.isHidden = true;break;
                }
                else {
                    p4btn.setAttributedTitle(NSAttributedString(string: "CH4", attributes: Single_color_gray), for: .normal);mat_channel[3]="Single";cct4label.isHidden = true;break;
                }
            case 2, 7, 8 :
                if stat_ch_btn[3] == 1 {
                    p4btn.setAttributedTitle(NSAttributedString(string: "CH4", attributes: Bi_color_white), for: .normal);mat_channel[3]="Bi";cct4label.isHidden = false;break;
                }
                else {
                    p4btn.setAttributedTitle(NSAttributedString(string: "CH4", attributes: Bi_color_gray), for: .normal);mat_channel[3]="Bi";cct4label.isHidden = false;break;
                }
            default : break;
            }
        }
    }
    func slider_getdata(ip:String) {
        let urlpath = "http://192.168.4."+ip+"/get"
        let url = NSURL(string:urlpath)
        
        let session = URLSession.shared
        
        let task = session.dataTask(with: url! as URL, completionHandler:{
            (data,responds,error)->Void in
            print(error)
            if let check=data{
                if self.check_data(text: String(decoding: check, as: UTF8.self)){
                    DispatchQueue.main.async { // Correct
                        self.slider_apply_data(text: String(decoding: check, as: UTF8.self))
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
    }
    func slider_apply_data(text: String) {
        cctlabel.text = String(Int(text.substring(startIndex: 38, endIndex: 39))!*100+2800)+"K"
        cctslider.value = Float(Int(text.substring(startIndex: 38, endIndex: 39))!)
        brtlabel.text = String(Int(text.substring(startIndex: 42, endIndex: 44))!)+"%"
        brtslider.value = Float(Int(text.substring(startIndex: 42, endIndex: 44))!)
    }
    
    func apply_data(text: String){
        
        if Int(text.substring(startIndex: 52, endIndex: 52)) == 0{
            //show(not_connected(),sender : self)
        }
        
        if Int(text.substring(startIndex: 52, endIndex: 52)) == 1 {
            if mat != "N50S" {
                cct1label.text = String(Int(text.substring(startIndex: 2, endIndex: 3))!*100+2800)+"K"
                preset_value[0][0] = Int(text.substring(startIndex: 2, endIndex: 3))!
                brt1label.text = String(Int(text.substring(startIndex: 6, endIndex: 8))!)+"%"
                preset_value[0][1] = Int(text.substring(startIndex: 6, endIndex: 8))!
                cct2label.text = String(Int(text.substring(startIndex: 11, endIndex: 12))!*100+2800)+"K"
                preset_value[1][0] = Int(text.substring(startIndex: 11, endIndex: 12))!
                brt2label.text = String(Int(text.substring(startIndex: 15, endIndex: 17))!)+"%"
                preset_value[1][1] = Int(text.substring(startIndex: 15, endIndex: 17))!
                cct3label.text = String(Int(text.substring(startIndex: 20, endIndex: 21))!*100+2800)+"K"
                preset_value[2][0] = Int(text.substring(startIndex: 20, endIndex: 21))!
                brt3label.text = String(Int(text.substring(startIndex: 24, endIndex: 26))!)+"%"
                preset_value[2][1] = Int(text.substring(startIndex: 24, endIndex: 26))!
                cct4label.text = String(Int(text.substring(startIndex: 29, endIndex: 30))!*100+2800)+"K"
                preset_value[3][0] = Int(text.substring(startIndex: 29, endIndex: 30))!
                brt4label.text = String(Int(text.substring(startIndex: 33, endIndex: 35))!)+"%"
                preset_value[3][1] = Int(text.substring(startIndex: 33, endIndex: 35))!
                device_label.text = "1x1 DayLight"
                mat = "N50S"
                mat_type(mat_type: "DAY")
            }
        }
        else if Int(text.substring(startIndex: 52, endIndex: 52)) == 2 {
            if mat != "N50B" {
                cctlabel.text = String(Int(text.substring(startIndex: 38, endIndex: 39))!*100+2800)+"K"
                cctslider.value = Float(Int(text.substring(startIndex: 38, endIndex: 39))!)
                brtlabel.text = String(Int(text.substring(startIndex: 42, endIndex: 44))!)+"%"
                brtslider.value = Float(Int(text.substring(startIndex: 42, endIndex: 44))!)
                let red:CGFloat = (CGFloat(255+(77-255)*cctslider.value/32))
                var green:CGFloat = (CGFloat(120+(170-120)*cctslider.value/32))
                var blue : CGFloat = (CGFloat(40+(232-40)*cctslider.value/32))
                cctslider.minimumTrackTintColor = UIColor(red:red/255,green:green/255,blue:blue/255,alpha:1.0)
                cctslider.maximumTrackTintColor = UIColor(red:red/255,green:green/255,blue:blue/255,alpha:1.0)
                
                cct1label.text = String(Int(text.substring(startIndex: 2, endIndex: 3))!*100+2800)+"K"
                preset_value[0][0] = Int(text.substring(startIndex: 2, endIndex: 3))!
                brt1label.text = String(Int(text.substring(startIndex: 6, endIndex: 8))!)+"%"
                preset_value[0][1] = Int(text.substring(startIndex: 6, endIndex: 8))!
                cct2label.text = String(Int(text.substring(startIndex: 11, endIndex: 12))!*100+2800)+"K"
                preset_value[1][0] = Int(text.substring(startIndex: 11, endIndex: 12))!
                brt2label.text = String(Int(text.substring(startIndex: 15, endIndex: 17))!)+"%"
                preset_value[1][1] = Int(text.substring(startIndex: 15, endIndex: 17))!
                cct3label.text = String(Int(text.substring(startIndex: 20, endIndex: 21))!*100+2800)+"K"
                preset_value[2][0] = Int(text.substring(startIndex: 20, endIndex: 21))!
                brt3label.text = String(Int(text.substring(startIndex: 24, endIndex: 26))!)+"%"
                preset_value[2][1] = Int(text.substring(startIndex: 24, endIndex: 26))!
                cct4label.text = String(Int(text.substring(startIndex: 29, endIndex: 30))!*100+2800)+"K"
                preset_value[3][0] = Int(text.substring(startIndex: 29, endIndex: 30))!
                brt4label.text = String(Int(text.substring(startIndex: 33, endIndex: 35))!)+"%"
                preset_value[3][1] = Int(text.substring(startIndex: 33, endIndex: 35))!
                device_label.text = "1x1 Bi-Color"
                mat = "N50B"
                mat_type(mat_type: "BI")
            }
        }
        else if Int(text.substring(startIndex: 52, endIndex: 52)) == 4 {
            if mat != "N100S" {
                cct1label.text = String(Int(text.substring(startIndex: 2, endIndex: 3))!*100+2800)+"K"
                preset_value[0][0] = Int(text.substring(startIndex: 2, endIndex: 3))!
                brt1label.text = String(Int(text.substring(startIndex: 6, endIndex: 8))!)+"%"
                preset_value[0][1] = Int(text.substring(startIndex: 6, endIndex: 8))!
                cct2label.text = String(Int(text.substring(startIndex: 11, endIndex: 12))!*100+2800)+"K"
                preset_value[1][0] = Int(text.substring(startIndex: 11, endIndex: 12))!
                brt2label.text = String(Int(text.substring(startIndex: 15, endIndex: 17))!)+"%"
                preset_value[1][1] = Int(text.substring(startIndex: 15, endIndex: 17))!
                cct3label.text = String(Int(text.substring(startIndex: 20, endIndex: 21))!*100+2800)+"K"
                preset_value[2][0] = Int(text.substring(startIndex: 20, endIndex: 21))!
                brt3label.text = String(Int(text.substring(startIndex: 24, endIndex: 26))!)+"%"
                preset_value[2][1] = Int(text.substring(startIndex: 24, endIndex: 26))!
                cct4label.text = String(Int(text.substring(startIndex: 29, endIndex: 30))!*100+2800)+"K"
                preset_value[3][0] = Int(text.substring(startIndex: 29, endIndex: 30))!
                brt4label.text = String(Int(text.substring(startIndex: 33, endIndex: 35))!)+"%"
                preset_value[3][1] = Int(text.substring(startIndex: 33, endIndex: 35))!
                device_label.text = "1x2 DayLight"
                mat = "N100S"
                mat_type(mat_type: "DAY")
            }
        }
        else if Int(text.substring(startIndex: 52, endIndex: 52)) == 8 {
            if mat != "N100B" {
                cctlabel.text = String(Int(text.substring(startIndex: 38, endIndex: 39))!*100+2800)+"K"
                cctslider.value = Float(Int(text.substring(startIndex: 38, endIndex: 39))!)
                brtlabel.text = String(Int(text.substring(startIndex: 42, endIndex: 44))!)+"%"
                brtslider.value = Float(Int(text.substring(startIndex: 42, endIndex: 44))!)
                let red:CGFloat = (CGFloat(255+(77-255)*cctslider.value/32))
                var green:CGFloat = (CGFloat(120+(170-120)*cctslider.value/32))
                var blue : CGFloat = (CGFloat(40+(232-40)*cctslider.value/32))
                cctslider.minimumTrackTintColor = UIColor(red:red/255,green:green/255,blue:blue/255,alpha:1.0)
                cctslider.maximumTrackTintColor = UIColor(red:red/255,green:green/255,blue:blue/255,alpha:1.0)
                
                cct1label.text = String(Int(text.substring(startIndex: 2, endIndex: 3))!*100+2800)+"K"
                preset_value[0][0] = Int(text.substring(startIndex: 2, endIndex: 3))!
                brt1label.text = String(Int(text.substring(startIndex: 6, endIndex: 8))!)+"%"
                preset_value[0][1] = Int(text.substring(startIndex: 6, endIndex: 8))!
                cct2label.text = String(Int(text.substring(startIndex: 11, endIndex: 12))!*100+2800)+"K"
                preset_value[1][0] = Int(text.substring(startIndex: 11, endIndex: 12))!
                brt2label.text = String(Int(text.substring(startIndex: 15, endIndex: 17))!)+"%"
                preset_value[1][1] = Int(text.substring(startIndex: 15, endIndex: 17))!
                cct3label.text = String(Int(text.substring(startIndex: 20, endIndex: 21))!*100+2800)+"K"
                preset_value[2][0] = Int(text.substring(startIndex: 20, endIndex: 21))!
                brt3label.text = String(Int(text.substring(startIndex: 24, endIndex: 26))!)+"%"
                preset_value[2][1] = Int(text.substring(startIndex: 24, endIndex: 26))!
                cct4label.text = String(Int(text.substring(startIndex: 29, endIndex: 30))!*100+2800)+"K"
                preset_value[3][0] = Int(text.substring(startIndex: 29, endIndex: 30))!
                brt4label.text = String(Int(text.substring(startIndex: 33, endIndex: 35))!)+"%"
                preset_value[3][1] = Int(text.substring(startIndex: 33, endIndex: 35))!
                device_label.text = "1x2 Bi-Color"
                mat = "N100B"
                mat_type(mat_type: "BI")
            }
        }
        else if Int(text.substring(startIndex: 52, endIndex: 52)) == 7 {
            if mat != "N200B" {
                cct1label.text = String(Int(text.substring(startIndex: 2, endIndex: 3))!*100+2800)+"K"
                preset_value[0][0] = Int(text.substring(startIndex: 2, endIndex: 3))!
                brt1label.text = String(Int(text.substring(startIndex: 6, endIndex: 8))!)+"%"
                preset_value[0][1] = Int(text.substring(startIndex: 6, endIndex: 8))!
                cct2label.text = String(Int(text.substring(startIndex: 11, endIndex: 12))!*100+2800)+"K"
                preset_value[1][0] = Int(text.substring(startIndex: 11, endIndex: 12))!
                brt2label.text = String(Int(text.substring(startIndex: 15, endIndex: 17))!)+"%"
                preset_value[1][1] = Int(text.substring(startIndex: 15, endIndex: 17))!
                cct3label.text = String(Int(text.substring(startIndex: 20, endIndex: 21))!*100+2800)+"K"
                preset_value[2][0] = Int(text.substring(startIndex: 20, endIndex: 21))!
                brt3label.text = String(Int(text.substring(startIndex: 24, endIndex: 26))!)+"%"
                preset_value[2][1] = Int(text.substring(startIndex: 24, endIndex: 26))!
                cct4label.text = String(Int(text.substring(startIndex: 29, endIndex: 30))!*100+2800)+"K"
                preset_value[3][0] = Int(text.substring(startIndex: 29, endIndex: 30))!
                brt4label.text = String(Int(text.substring(startIndex: 33, endIndex: 35))!)+"%"
                preset_value[3][1] = Int(text.substring(startIndex: 33, endIndex: 35))!
                device_label.text = "1x3 Bi"
                mat = "N200B"
                mat_type(mat_type: "BI")
                brtslider.maximumValue = 65
            }
        }
        if (mat == "N50S")||(mat == "N100S") {
            day_label.text = String(Int(text.substring(startIndex: 42, endIndex: 44))!)+"%"
            day_label.textColor = UIColor(displayP3Red: 1, green: 1, blue: 1, alpha: CGFloat(0.5+(0.5*Float(Int(text.substring(startIndex: 42, endIndex: 44))!))/100))
            slider.currentValue = Double(Int(text.substring(startIndex: 42, endIndex: 44))!)
        }
        else {
            if get_data_init == 0 {
                switch Int(text.substring(startIndex: 52, endIndex: 52)) {
                case 1 : mat = "N50S";break;
                case 2 : mat = "N50B";break;
                case 4 : mat = "N100S";break;
                case 8 : mat = "N100B";break
                default : break;
                }
                get_data_init = 1
            }
            else if Int(text.substring(startIndex: 47, endIndex: 47)) == 5{
                cctslider.isEnabled = true
                brtslider.isEnabled = true
                
                
                cctlabel.text = String(Int(text.substring(startIndex: 38, endIndex: 39))!*100+2800)+"K"
                cctslider.value = Float(Int(text.substring(startIndex: 38, endIndex: 39))!)
                brtlabel.text = String(Int(text.substring(startIndex: 42, endIndex: 44))!)+"%"
                brtslider.value = Float(Int(text.substring(startIndex: 42, endIndex: 44))!)
                
                p1btn.setAttributedTitle(NSAttributedString(string: "P1", attributes: preset_btn_design_gray), for: .normal)
                p4btn.setAttributedTitle(NSAttributedString(string: "P4", attributes: preset_btn_design_gray), for: .normal)
                p2btn.setAttributedTitle(NSAttributedString(string: "P2", attributes: preset_btn_design_gray), for: .normal)
                p3btn.setAttributedTitle(NSAttributedString(string: "P3", attributes: preset_btn_design_gray), for: .normal)
                temp_p1 = 0
                temp_p2 = 0
                temp_p3 = 0
                temp_p4 = 0
                cct1label.text = String(Int(text.substring(startIndex: 2, endIndex: 3))!*100+2800)+"K"
                preset_value[0][0] = Int(text.substring(startIndex: 2, endIndex: 3))!
                brt1label.text = String(Int(text.substring(startIndex: 6, endIndex: 8))!)+"%"
                preset_value[0][1] = Int(text.substring(startIndex: 6, endIndex: 8))!
                cct2label.text = String(Int(text.substring(startIndex: 11, endIndex: 12))!*100+2800)+"K"
                preset_value[1][0] = Int(text.substring(startIndex: 11, endIndex: 12))!
                brt2label.text = String(Int(text.substring(startIndex: 15, endIndex: 17))!)+"%"
                preset_value[1][1] = Int(text.substring(startIndex: 15, endIndex: 17))!
                cct3label.text = String(Int(text.substring(startIndex: 20, endIndex: 21))!*100+2800)+"K"
                preset_value[2][0] = Int(text.substring(startIndex: 20, endIndex: 21))!
                brt3label.text = String(Int(text.substring(startIndex: 24, endIndex: 26))!)+"%"
                preset_value[2][1] = Int(text.substring(startIndex: 24, endIndex: 26))!
                cct4label.text = String(Int(text.substring(startIndex: 29, endIndex: 30))!*100+2800)+"K"
                preset_value[3][0] = Int(text.substring(startIndex: 29, endIndex: 30))!
                brt4label.text = String(Int(text.substring(startIndex: 33, endIndex: 35))!)+"%"
                preset_value[3][1] = Int(text.substring(startIndex: 33, endIndex: 35))!
            }
            else if Int(text.substring(startIndex: 47, endIndex: 47)) == 1{
                cctslider.isEnabled = false
                brtslider.isEnabled = false
                
                cctlabel.text = String(Int(text.substring(startIndex: 2, endIndex: 3))!*100+2800)+"K"
                cctslider.value = Float(Int(text.substring(startIndex: 2, endIndex: 3))!)
                brtlabel.text = String(Int(text.substring(startIndex: 6, endIndex: 8))!)+"%"
                brtslider.value = Float(Int(text.substring(startIndex: 6, endIndex: 8))!)
                
                cct1label.text = String(Int(text.substring(startIndex: 2, endIndex: 3))!*100+2800)+"K"
                brt1label.text = String(Int(text.substring(startIndex: 6, endIndex: 8))!)+"%"
                p1btn.setAttributedTitle(NSAttributedString(string: "P1", attributes: preset_btn_design_white), for: .normal)
                p4btn.setAttributedTitle(NSAttributedString(string: "P4", attributes: preset_btn_design_gray), for: .normal)
                p2btn.setAttributedTitle(NSAttributedString(string: "P2", attributes: preset_btn_design_gray), for: .normal)
                p3btn.setAttributedTitle(NSAttributedString(string: "P3", attributes: preset_btn_design_gray), for: .normal)
                temp_p1 = 1
                temp_p2 = 0
                temp_p3 = 0
                temp_p4 = 0
                cct1label.text = String(Int(text.substring(startIndex: 2, endIndex: 3))!*100+2800)+"K"
                preset_value[0][0] = Int(text.substring(startIndex: 2, endIndex: 3))!
                brt1label.text = String(Int(text.substring(startIndex: 6, endIndex: 8))!)+"%"
                preset_value[0][1] = Int(text.substring(startIndex: 6, endIndex: 8))!
                cct2label.text = String(Int(text.substring(startIndex: 11, endIndex: 12))!*100+2800)+"K"
                preset_value[1][0] = Int(text.substring(startIndex: 11, endIndex: 12))!
                brt2label.text = String(Int(text.substring(startIndex: 15, endIndex: 17))!)+"%"
                preset_value[1][1] = Int(text.substring(startIndex: 15, endIndex: 17))!
                cct3label.text = String(Int(text.substring(startIndex: 20, endIndex: 21))!*100+2800)+"K"
                preset_value[2][0] = Int(text.substring(startIndex: 20, endIndex: 21))!
                brt3label.text = String(Int(text.substring(startIndex: 24, endIndex: 26))!)+"%"
                preset_value[2][1] = Int(text.substring(startIndex: 24, endIndex: 26))!
                cct4label.text = String(Int(text.substring(startIndex: 29, endIndex: 30))!*100+2800)+"K"
                preset_value[3][0] = Int(text.substring(startIndex: 29, endIndex: 30))!
                brt4label.text = String(Int(text.substring(startIndex: 33, endIndex: 35))!)+"%"
                preset_value[3][1] = Int(text.substring(startIndex: 33, endIndex: 35))!
            }
            else if Int(text.substring(startIndex: 47, endIndex: 47)) == 2{
                cctslider.isEnabled = false
                brtslider.isEnabled = false
                
                cctlabel.text = String(Int(text.substring(startIndex: 11, endIndex: 12))!*100+2800)+"K"
                cctslider.value = Float(Int(text.substring(startIndex:11, endIndex: 12))!)
                brtlabel.text = String(Int(text.substring(startIndex: 15, endIndex: 17))!)+"%"
                brtslider.value = Float(Int(text.substring(startIndex: 15, endIndex: 17))!)
                
                cct2label.text = String(Int(text.substring(startIndex: 11, endIndex: 12))!*100+2800)+"K"
                brt2label.text = String(Int(text.substring(startIndex: 15, endIndex: 17))!)+"%"
                
                p2btn.setAttributedTitle(NSAttributedString(string: "P2", attributes: preset_btn_design_white), for: .normal)
                p1btn.setAttributedTitle(NSAttributedString(string: "P1", attributes: preset_btn_design_gray), for: .normal)
                p3btn.setAttributedTitle(NSAttributedString(string: "P3", attributes: preset_btn_design_gray), for: .normal)
                p4btn.setAttributedTitle(NSAttributedString(string: "P4", attributes: preset_btn_design_gray), for: .normal)
                temp_p1 = 0
                temp_p2 = 1
                temp_p3 = 0
                temp_p4 = 0
                cct1label.text = String(Int(text.substring(startIndex: 2, endIndex: 3))!*100+2800)+"K"
                preset_value[0][0] = Int(text.substring(startIndex: 2, endIndex: 3))!
                brt1label.text = String(Int(text.substring(startIndex: 6, endIndex: 8))!)+"%"
                preset_value[0][1] = Int(text.substring(startIndex: 6, endIndex: 8))!
                cct2label.text = String(Int(text.substring(startIndex: 11, endIndex: 12))!*100+2800)+"K"
                preset_value[1][0] = Int(text.substring(startIndex: 11, endIndex: 12))!
                brt2label.text = String(Int(text.substring(startIndex: 15, endIndex: 17))!)+"%"
                preset_value[1][1] = Int(text.substring(startIndex: 15, endIndex: 17))!
                cct3label.text = String(Int(text.substring(startIndex: 20, endIndex: 21))!*100+2800)+"K"
                preset_value[2][0] = Int(text.substring(startIndex: 20, endIndex: 21))!
                brt3label.text = String(Int(text.substring(startIndex: 24, endIndex: 26))!)+"%"
                preset_value[2][1] = Int(text.substring(startIndex: 24, endIndex: 26))!
                cct4label.text = String(Int(text.substring(startIndex: 29, endIndex: 30))!*100+2800)+"K"
                preset_value[3][0] = Int(text.substring(startIndex: 29, endIndex: 30))!
                brt4label.text = String(Int(text.substring(startIndex: 33, endIndex: 35))!)+"%"
                preset_value[3][1] = Int(text.substring(startIndex: 33, endIndex: 35))!
            }
            else if Int(text.substring(startIndex: 47, endIndex: 47)) == 3{
                cctslider.isEnabled = false
                brtslider.isEnabled = false
                
                cctlabel.text = String(Int(text.substring(startIndex: 20, endIndex: 21))!*100+2800)+"K"
                cctslider.value = Float(Int(text.substring(startIndex:20, endIndex: 21))!)
                brtlabel.text = String(Int(text.substring(startIndex: 24, endIndex: 26))!)+"%"
                brtslider.value = Float(Int(text.substring(startIndex: 24, endIndex: 26))!)
                
                cct3label.text = String(Int(text.substring(startIndex: 20, endIndex: 21))!*100+2800)+"K"
                brt3label.text = String(Int(text.substring(startIndex: 24, endIndex: 26))!)+"%"
                
                p3btn.setAttributedTitle(NSAttributedString(string: "P3", attributes: preset_btn_design_white), for: .normal)
                p1btn.setAttributedTitle(NSAttributedString(string: "P1", attributes: preset_btn_design_gray), for: .normal)
                p2btn.setAttributedTitle(NSAttributedString(string: "P2", attributes: preset_btn_design_gray), for: .normal)
                p4btn.setAttributedTitle(NSAttributedString(string: "P4", attributes: preset_btn_design_gray), for: .normal)
                temp_p1 = 0
                temp_p2 = 0
                temp_p3 = 1
                temp_p4 = 0
                cct1label.text = String(Int(text.substring(startIndex: 2, endIndex: 3))!*100+2800)+"K"
                preset_value[0][0] = Int(text.substring(startIndex: 2, endIndex: 3))!
                brt1label.text = String(Int(text.substring(startIndex: 6, endIndex: 8))!)+"%"
                preset_value[0][1] = Int(text.substring(startIndex: 6, endIndex: 8))!
                cct2label.text = String(Int(text.substring(startIndex: 11, endIndex: 12))!*100+2800)+"K"
                preset_value[1][0] = Int(text.substring(startIndex: 11, endIndex: 12))!
                brt2label.text = String(Int(text.substring(startIndex: 15, endIndex: 17))!)+"%"
                preset_value[1][1] = Int(text.substring(startIndex: 15, endIndex: 17))!
                cct3label.text = String(Int(text.substring(startIndex: 20, endIndex: 21))!*100+2800)+"K"
                preset_value[2][0] = Int(text.substring(startIndex: 20, endIndex: 21))!
                brt3label.text = String(Int(text.substring(startIndex: 24, endIndex: 26))!)+"%"
                preset_value[2][1] = Int(text.substring(startIndex: 24, endIndex: 26))!
                cct4label.text = String(Int(text.substring(startIndex: 29, endIndex: 30))!*100+2800)+"K"
                preset_value[3][0] = Int(text.substring(startIndex: 29, endIndex: 30))!
                brt4label.text = String(Int(text.substring(startIndex: 33, endIndex: 35))!)+"%"
                preset_value[3][1] = Int(text.substring(startIndex: 33, endIndex: 35))!
            }
            else if Int(text.substring(startIndex: 47, endIndex: 47)) == 4{
                cctslider.isEnabled = false
                brtslider.isEnabled = false
                
                cctlabel.text = String(Int(text.substring(startIndex: 29, endIndex: 30))!*100+2800)+"K"
                cctslider.value = Float(Int(text.substring(startIndex:29, endIndex: 30))!)
                brtlabel.text = String(Int(text.substring(startIndex: 33, endIndex: 35))!)+"%"
                brtslider.value = Float(Int(text.substring(startIndex: 33, endIndex: 35))!)
                
                cct4label.text = String(Int(text.substring(startIndex: 29, endIndex: 30))!*100+2800)+"K"
                brt4label.text = String(Int(text.substring(startIndex: 33, endIndex: 35))!)+"%"
                
                p4btn.setAttributedTitle(NSAttributedString(string: "P4", attributes: preset_btn_design_white), for: .normal)
                p1btn.setAttributedTitle(NSAttributedString(string: "P1", attributes: preset_btn_design_gray), for: .normal)
                p2btn.setAttributedTitle(NSAttributedString(string: "P2", attributes: preset_btn_design_gray), for: .normal)
                p3btn.setAttributedTitle(NSAttributedString(string: "P3", attributes: preset_btn_design_gray), for: .normal)
                temp_p1 = 0
                temp_p2 = 0
                temp_p3 = 0
                temp_p4 = 1
                cct1label.text = String(Int(text.substring(startIndex: 2, endIndex: 3))!*100+2800)+"K"
                preset_value[0][0] = Int(text.substring(startIndex: 2, endIndex: 3))!
                brt1label.text = String(Int(text.substring(startIndex: 6, endIndex: 8))!)+"%"
                preset_value[0][1] = Int(text.substring(startIndex: 6, endIndex: 8))!
                cct2label.text = String(Int(text.substring(startIndex: 11, endIndex: 12))!*100+2800)+"K"
                preset_value[1][0] = Int(text.substring(startIndex: 11, endIndex: 12))!
                brt2label.text = String(Int(text.substring(startIndex: 15, endIndex: 17))!)+"%"
                preset_value[1][1] = Int(text.substring(startIndex: 15, endIndex: 17))!
                cct3label.text = String(Int(text.substring(startIndex: 20, endIndex: 21))!*100+2800)+"K"
                preset_value[2][0] = Int(text.substring(startIndex: 20, endIndex: 21))!
                brt3label.text = String(Int(text.substring(startIndex: 24, endIndex: 26))!)+"%"
                preset_value[2][1] = Int(text.substring(startIndex: 24, endIndex: 26))!
                cct4label.text = String(Int(text.substring(startIndex: 29, endIndex: 30))!*100+2800)+"K"
                preset_value[3][0] = Int(text.substring(startIndex: 29, endIndex: 30))!
                brt4label.text = String(Int(text.substring(startIndex: 33, endIndex: 35))!)+"%"
                preset_value[3][1] = Int(text.substring(startIndex: 33, endIndex: 35))!
            }
            let red:CGFloat = (CGFloat(255+(77-255)*cctslider.value/32))
            var green:CGFloat = (CGFloat(120+(170-120)*cctslider.value/32))
            var blue : CGFloat = (CGFloat(40+(232-40)*cctslider.value/32))
            cctslider.minimumTrackTintColor = UIColor(red:red/255,green:green/255,blue:blue/255,alpha:1.0)
            cctslider.maximumTrackTintColor = UIColor(red:red/255,green:green/255,blue:blue/255,alpha:1.0)
            
            let color_value:CGFloat = (CGFloat(255*brtslider.value/100))
            brtslider.minimumTrackTintColor = UIColor(red:color_value/255,green:color_value/255,blue:color_value/255,alpha:1.0)
            brtslider.maximumTrackTintColor = UIColor(red:color_value/255,green:color_value/255,blue:color_value/255,alpha:1.0)
            
            ch1label.text = "P1"
            ch2label.text = "P2"
            ch3label.text = "P3"
            ch4label.text = "P4"
        }
    }
    
    func check_data(text: String)-> Bool {
        print(text)
        if text.isEmpty{
            return false
        }
        //"c100b1100c200b2100c300b3100c400b4100c500b5100ch50mat00"
        for i in 0..<5{
            
            if Int(text.substring(startIndex: 9*i+2, endIndex: 9*i+3)) == nil{
                return false
            }
            if Int(text.substring(startIndex: 9*i+6, endIndex: 9*i+8)) == nil{
                return false
            }
        }
        if Int(text.substring(startIndex: 47, endIndex: 48)) == nil{
            return false
        }
        if Int(text.substring(startIndex: 52, endIndex: 53)) == nil{
            return false
        }
        return true
    }
    func getWifissid() -> String? {
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
    
    
    func cctslide_preset(_ sender: Any){
        print("temp_cct:\(temp_cct), slide_value:\(cctslider.value)")
        if true {
            if cct_preset_value == Int(cctslider_preset.value){
                return
            }
            
            cct_preset_value = Int(cctslider_preset.value)
            cct_preset.text = String(Int(cctslider_preset.value)*100+2800)+"K"
            let red:CGFloat = (CGFloat(255+(77-255)*cctslider_preset.value/32))
            var green:CGFloat = (CGFloat(120+(170-120)*cctslider_preset.value/32))
            var blue : CGFloat = (CGFloat(40+(232-40)*cctslider_preset.value/32))
            cctslider_preset.minimumTrackTintColor = UIColor(red:red/255,green:green/255,blue:blue/255,alpha:1.0)
            cctslider_preset.maximumTrackTintColor = UIColor(red:red/255,green:green/255,blue:blue/255,alpha:1.0)
        }
        else {
            if ( temp_cct == Int(bigcctslider.value)){
                return
            }
            print(cctslider.value)
            temp_cct = Int(bigcctslider.value)
            cctlabel.text = String(Int(bigcctslider.value)*100+2800)+"K"
            var green:CGFloat = (CGFloat(120+(202-120)*bigcctslider.value/32))
            var blue : CGFloat = (CGFloat(40+(0-40)*bigcctslider.value/32))
            bigcctslider.minimumTrackTintColor = UIColor(red:255/255,green:green/255,blue:blue/255,alpha:1.0)
        }
    }
    
    func brtslide_preset(_ sender: Any){
        if true {
            if ( brt_preset_value == Int(brtslider_preset.value)){
                return
            }
            brt_preset_value = Int(brtslider_preset.value)
            brt_preset.text = String(Int(brtslider_preset.value))+"%"
            var color_value:CGFloat = (CGFloat(255*brtslider_preset.value/100))
            
        }
        else {
            if ( temp_brt == Int(bigbrtslider.value)){
                return
            }
            
            temp_brt = Int(bigbrtslider.value)
            brtlabel.text = String(Int(bigbrtslider.value))+"%"
            var color_value:CGFloat = (CGFloat(255*bigbrtslider.value/100))
            print(color_value)
            bigbrtslider.minimumTrackTintColor = UIColor(red:color_value/255,green:color_value/255,blue:color_value/255,alpha:1.0)
            wifi_request(message: "brt"+String(Int(bigbrtslider.value)))
            
        }
    }
    
    func mat_type(mat_type:String) {
        if mat_type == "DAY" {
            p1btn.isHidden = true
            p2btn.isHidden = true
            p3btn.isHidden = true
            p4btn.isHidden = true
            
            cctlabel.isHidden = true
            cctslider.isHidden = true
            brtlabel.isHidden = true
            brtslider.isHidden = true
            
            ch1label.isHidden = true
            ch2label.isHidden = true
            ch3label.isHidden = true
            ch4label.isHidden = true
            
            cct1label.isHidden = true
            cct2label.isHidden = true
            cct3label.isHidden = true
            cct4label.isHidden = true
            
            brt1label.isHidden = true
            brt2label.isHidden = true
            brt3label.isHidden = true
            brt4label.isHidden = true
            
            slider.isHidden = false
            day_label.isHidden = false
        }
        else {
            p1btn.isHidden = false
            p2btn.isHidden = false
            p3btn.isHidden = false
            p4btn.isHidden = false
            
            cctlabel.isHidden = false
            cctslider.isHidden = false
            brtlabel.isHidden = false
            brtslider.isHidden = false
            ch1label.isHidden = false
            ch2label.isHidden = false
            ch3label.isHidden = false
            ch4label.isHidden = false
            
            cct1label.isHidden = false
            cct2label.isHidden = false
            cct3label.isHidden = false
            cct4label.isHidden = false
            
            brt1label.isHidden = false
            brt2label.isHidden = false
            brt3label.isHidden = false
            brt4label.isHidden = false
            
            slider.isHidden = true
            day_label.isHidden = true
        }
    }
    
    func multi_mat_type(type:String) {
       if type == "Day" {
            cctlabel.isHidden = true
            cctslider.isHidden = true
            brtlabel.isHidden = true
            brtslider.isHidden = true
            slider.isHidden = true
            day_label.isHidden = true
            
            multi_slider.isHidden = false
            multi_day_label.isHidden = false
        }
        else {
            cctlabel.isHidden = false
            cctslider.isHidden = false
            brtlabel.isHidden = false
            brtslider.isHidden = false
            slider.isHidden = true
            day_label.isHidden = true
            
            multi_slider.isHidden = true
            multi_day_label.isHidden = true
        }
    }
    
    func find_device_number(wifi_name:String) -> Int {
        var find_count:Int = 0
        while find_count<=UserDefaults.standard.integer(forKey: "count") {
            if wifi_name == UserDefaults.standard.string(forKey: "dev"+String(find_count)) {
                return find_count
            }
            find_count += 1
        }
        return 0
    }
    func toast_message(message : String){
        let toastLabel = UILabel()
        
        view.addSubview(toastLabel)
        toastLabel.lineBreakMode = .byWordWrapping
        toastLabel.numberOfLines = 0
        toastLabel.frame = CGRect(x: 0, y: view.frame.height*6/7, width: view.frame.width*5/6, height: 0)
        toastLabel.backgroundColor = .black
        toastLabel.text = message
        toastLabel.alpha = 1
        toastLabel.textColor = .white
        if device == IPAD_NINE_INCH {
            toastLabel.font = UIFont.systemFont(ofSize:35)
        }
        else if device == IPAD_SEVEN_INCH {
            toastLabel.font = UIFont.systemFont(ofSize:30)
        }
        else if device == IPAD_TWELVE_INCH {
            toastLabel.font = UIFont.systemFont(ofSize:40)
        }
        else {
            toastLabel.font = UIFont.systemFont(ofSize:18)
        }
        toastLabel.sizeToFit()
        toastLabel.center.x = view.center.x
        
        /*
        toastLabel.translatesAutoresizingMaskIntoConstraints = false
        toastLabel.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        toastLabel.widthAnchor.constraint(equalToConstant: view.frame.size.width*3/2).isActive = true
        if device == IPAD_NINE_INCH {
            toastLabel.bottomAnchor.constraint(equalTo:view.bottomAnchor,constant:-60).isActive = true
            toastLabel.heightAnchor.constraint(equalToConstant:100).isActive = true
        }
        else if device == IPAD_TWELVE_INCH {
            toastLabel.bottomAnchor.constraint(equalTo:view.bottomAnchor,constant:-80).isActive = true
            toastLabel.heightAnchor.constraint(equalToConstant:100).isActive = true
        }
        else {
            toastLabel.bottomAnchor.constraint(equalTo:view.bottomAnchor,constant:-40).isActive = true
            toastLabel.heightAnchor.constraint(equalToConstant:40).isActive = true
        }
 
        toastLabel.backgroundColor = .black
        toastLabel.textColor = .white
        toastLabel.alpha = 1.0
        toastLabel.textAlignment = .center
        toastLabel.text = message
        if device == IPAD_NINE_INCH {
            toastLabel.font = UIFont.systemFont(ofSize:35)
        }
        else if device == IPAD_TWELVE_INCH {
            toastLabel.font = UIFont.systemFont(ofSize:40)
        }
        else {
            toastLabel.font = UIFont.systemFont(ofSize:20)
        }
        
        toastLabel.layer.cornerRadius = 10
        toastLabel.clipsToBounds = true
        */
        UIView.animate(withDuration: 3, animations: {toastLabel.alpha = 2}, completion: {(complete) in
            UIView.animate(withDuration: 2, animations: {
                toastLabel.alpha = 0.0
            }) { (complete) in
                toastLabel.removeFromSuperview()
            }
        })
    }
    
    func check_wifi() {
        for i in 1 ..< UserDefaults.standard.integer(forKey: "count") {
            if getWifissid() == UserDefaults.standard.string(forKey: "dev"+String(i)) {
                break
            }
            else {
                for v in view.subviews {
                    v.alpha = 0.3
                    toast_message(message: "connect V2 DIMMER WiFi")
                }
            }
        }
    }
    
    func error_check() {
        var check_client:Int = 0
        for i in 1 ..< UserDefaults.standard.integer(forKey: "count")+1 {
            if UserDefaults.standard.integer(forKey: "dev"+String(i)+"mode") == 0 {
                for j in 3 ..< 6 {
                    if UserDefaults.standard.integer(forKey: "dev"+String(i)+"client"+String(j)+"count") == 1 {
                        UserDefaults.standard.set(1,forKey:"dev"+String(i)+"mode")
                    }
                }
            }
            else if UserDefaults.standard.integer(forKey: "dev"+String(i)+"mode") == 1 {
                for j in 3 ..< 6 {
                    if UserDefaults.standard.integer(forKey: "dev"+String(i)+"client"+String(j)+"count") == 0 {
                        check_client += 1
                    }
                }
                if check_client == 3 {
                    UserDefaults.standard.set(0,forKey:"dev"+String(i)+"mode")
                }
            }
        }
    }
    
    func remove_presetbtn_gesture() {
        for gesture in p1btn.gestureRecognizers ?? [] {
            p1btn.removeGestureRecognizer(gesture)
        }
        for gesture in p2btn.gestureRecognizers ?? [] {
            p2btn.removeGestureRecognizer(gesture)
        }
        for gesture in p3btn.gestureRecognizers ?? [] {
            p3btn.removeGestureRecognizer(gesture)
        }
        for gesture in p4btn.gestureRecognizers ?? [] {
            p4btn.removeGestureRecognizer(gesture)
        }
    }
}

var pings:[String] = ["192.168.4.3","192.168.4.4","192.168.4.5"]
func multi_check() -> Int{
    guard pings.count > 0 else {
        return 1
    }
    
    let ping = pings.removeFirst()
    print("ip : "+ping)
    PlainPing.ping(ping,withTimeout: 1, completionBlock: { (timeElapsed:Double?, error:Error?) in
        if let latency = timeElapsed {
            print(ping+"connect")
            connect_device[2-pings.count]=1
            check_ping[2-pings.count] = 1
        }
        if let error = error {
            print("error: \(error.localizedDescription)")
        }
        multi_check()
    })
    return 0
}
