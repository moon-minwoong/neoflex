//
//  selector.swift
//  mydream
//
//  Created by 문민웅 on 2018. 6. 26..
//  Copyright © 2018년 moon. All rights reserved.
//

import Foundation
import UIKit
import MSCircularSlider

let p1btn = UIButton()
let p2btn = UIButton()
let p3btn = UIButton()
let p4btn = UIButton()
let reset_btn = UIButton()

let deviceimage : UIImageView = {
    let imageView = UIImageView(image:#imageLiteral(resourceName: "device"))
    return imageView
}()

let westcottimage : UIImageView = {
    let imageView = UIImageView(image:#imageLiteral(resourceName: "west"))
    return imageView
}()

let thick_slider = slider_thickness()

let device_label = UILabel()

let cctlabel = UILabel()
let brtlabel = UILabel()

let cctslider = UISlider()
let brtslider = UISlider()

var slider = MSCircularSlider()
var multi_slider = MSCircularSlider()
var day_label = UILabel()
var multi_day_label = UILabel()
let bigcctslider :UISlider = slider_thickness(frame: CGRect(x: 10, y: 10, width: 100, height: 100))
let bigbrtslider :UISlider = slider_thickness(frame: CGRect(x: 10, y: 10, width: 100, height: 100))

let ch1label = UILabel()
let ch2label = UILabel()
let ch3label = UILabel()
let ch4label = UILabel()

let cct1label = UILabel()
let cct2label = UILabel()
let cct3label = UILabel()
let cct4label = UILabel()

let brt1label = UILabel()
let brt2label = UILabel()
let brt3label = UILabel()
let brt4label = UILabel()

let background_preset = UILabel(frame: CGRect(x:20,y:186.75,width:335,height:293.5))
let text_preset = UILabel()
let cctslider_preset = UISlider()
let brtslider_preset = UISlider()
let cct_preset = UILabel()
let brt_preset = UILabel()
let ok_preset = UIButton()
let cancel_preset = UIButton()

let info_background = UIView()

let Indicator:UIActivityIndicatorView=UIActivityIndicatorView()

let IPHONE_X = 0
let IPHONE_BASE = 1
let IPHONE_5S_SE = 2
let IPHONE_PLUS = 3
let IPHONE_XR = 4
let IPHONE_XS_MAX = 5
let IPAD_NINE_INCH = 6
let IPAD_TEN_INCH = 7
let IPAD_TWELVE_INCH = 8
let IPAD_SEVEN_INCH = 9

var device:Int = IPHONE_BASE

var temp_cct:Int = 0
var temp_brt:Int = 100
var day_brt:Int = 100
var multi_day_brt:Int = 100
var temp_p1:Int = 0
var temp_p2:Int = 0
var temp_p3:Int = 0
var temp_p4:Int = 0

var cct_preset_value:Int = 0
var brt_preset_value:Int = 0

var stat_device:Bool=false
var stat_btn:Int = 0
var stat_ch_btn:[Int] = [1,0,0,0]

var is_iphone:Bool = false
var count:Int=0
var model : String?

var mTimer:Timer?

var device_count:Int = 0
var get_data_init:Int=0
var connect_device:[Int]=[0,0,0,0]
var client_count:Int = 3
var check_ping:[Int]=[0,0,0]

var preset_value:[[Int]] = [[0,100],[0,100],[0,100],[0,100]]
var mat:String=""
var mat_channel:[String] = ["","","",""]
var multi_mat:String = "Void"
var check_mat:String = ""
let preset_btn_design_gray : [NSAttributedStringKey : Any] = [
    NSAttributedStringKey.foregroundColor : UIColor.gray,
]
let preset_btn_design_white : [NSAttributedStringKey : Any] = [
    NSAttributedStringKey.foregroundColor : UIColor.white,
]

let Bi_color_gray: [NSAttributedStringKey : Any] = [
    NSAttributedStringKey.strokeColor : UIColor.orange,
    NSAttributedStringKey.foregroundColor : UIColor.gray,
    NSAttributedStringKey.strokeWidth : -2.5,
]
let Bi_color_white: [NSAttributedStringKey : Any] = [
    NSAttributedStringKey.foregroundColor : UIColor.orange,
]
let Single_color_gray: [NSAttributedStringKey : Any] = [
    NSAttributedStringKey.strokeColor : UIColor.white,
    NSAttributedStringKey.foregroundColor : UIColor.gray,
    NSAttributedStringKey.strokeWidth : -2.5,
]
let Single_color_white: [NSAttributedStringKey : Any] = [
    NSAttributedStringKey.foregroundColor : UIColor.white,
]

var channel_value:[[Int]] = [[0,100],[0,100],[0,100],[0,100]]

var info_device_num = 0

var device_list_array:[UILabel] = []
let information_view = UIView()

let swipe = UISwipeGestureRecognizer()
let info = UISwipeGestureRecognizer()
let disapper = UISwipeGestureRecognizer()
let window = UIApplication.shared.keyWindow

let alert_view = UIView()
let alert_wifi_name = UITextField()
let alert_wifi_password = UITextField()

var multi_day_stat:Int = 0

var stat_swipe:Int = 0

let function_background = UIView()

var stat_alert:Int = 0
