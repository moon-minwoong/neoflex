////
////  Regist.swift
////  mydream
////
////  Created by 문민웅 on 2018. 5. 17..
////  Copyright © 2018년 moon. All rights reserved.
////
//
import Foundation
import UIKit
import NetworkExtension
import SystemConfiguration.CaptiveNetwork
import PlainPing

class ipad_seven_inch: UIViewController{
    
    var type:String = "BASE"
    var multi_check_timer:Timer?
    var longclick = UILongPressGestureRecognizer()
    var clicked_preset:Int = 0
    let swipe_view = UIView()
    let info_view = UIView()
    var wifi_check_timer:Timer?
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        alert_view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.white
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        swipe_view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 350)
        info_view.frame = CGRect(x: 0, y: 0, width: 80, height: view.frame.height)
        view.addSubview(swipe_view)
        view.addSubview(info_view)
        
        swipe.addTarget(self, action: #selector(down(_:)))
        info.addTarget(self, action: #selector(show_info(_:)))
        disapper.addTarget(self, action: #selector(disappear_info(_:)))
        
        swipe.direction = .down
        info.direction = .right
        disapper.direction = .left
        
        swipe_view.addGestureRecognizer(swipe)
        info_view.addGestureRecognizer(info)
        view.addGestureRecognizer(disapper)
        disapper.isEnabled = false
        
        device_count = current_device_count()

        for i in 0 ..< 3 {
            print(connect_device[i])
            if connect_device[i] == 1 {
                stat_device = true
            }
        }
        
        setuplayout()
        channellayout()
        sliderlayout()
        labellayout()
        
        
        if stat_device {
            device_label.text = "Multi WiFi"
            multi_getdata(ip: String(1))
            for i in 0 ..< 3 {
                if connect_device[i] == 1 {
                    multi_getdata(ip: String(i+3))
                }
                else {
                    if i == 0 {
                        p2btn.isHidden = true
                        ch2label.isHidden = true
                        cct2label.isHidden = true
                        brt2label.isHidden = true
                    }
                    else if i == 1 {
                        p3btn.isHidden = true
                        ch3label.isHidden = true
                        cct3label.isHidden = true
                        brt3label.isHidden = true
                    }
                    else {
                        p4btn.isHidden = true
                        ch4label.isHidden = true
                        cct4label.isHidden = true
                        brt4label.isHidden = true
                    }
                }
            }
            if stat_ch_btn[0] == 1 {
                slider_getdata(ip: String(1))
            }
            else if stat_ch_btn[1] == 1 {
                slider_getdata(ip: String(3))
            }
            else if stat_ch_btn[2] == 1 {
                slider_getdata(ip: String(4))
            }
            else if stat_ch_btn[3] == 1 {
                slider_getdata(ip: String(5))
            }
        }
        else {
            apply_data(text: check_mat)
        }
        
        view.addSubview(background_preset)
        view.addSubview(text_preset)
        view.addSubview(cctslider_preset)
        view.addSubview(brtslider_preset)
        view.addSubview(cct_preset)
        view.addSubview(brt_preset)
        view.addSubview(ok_preset)
        view.addSubview(cancel_preset)
        
        stat_preset_view(stat: false)
        
        if stat_device == false {
            if let timer = mTimer {
                if !timer.isValid {
                    mTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(getdata), userInfo: nil, repeats: true)
                }
            }
            else {
                mTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(getdata), userInfo: nil, repeats: true)
            }
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func setuplayout() {
        view.backgroundColor = .black
        view.addSubview(westcottimage)
        view.addSubview(device_label)
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(mode_change(tapGestureRecognizer:)))
        
        device_label.translatesAutoresizingMaskIntoConstraints = false
        device_label.topAnchor.constraint(equalTo:view.safeAreaLayoutGuide.topAnchor, constant: view.frame.height/40+7.5).isActive = true
        device_label.leftAnchor.constraint(equalTo:view.leftAnchor, constant:30).isActive = true
        device_label.text=""
        device_label.textColor = .white
        device_label.font = UIFont.boldSystemFont(ofSize: 45)
        
        westcottimage.translatesAutoresizingMaskIntoConstraints = false
        westcottimage.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        //        imageview.centerYAnchor.constraint(equalTo:view.centerYAnchor).isActive = true
        westcottimage.topAnchor.constraint(equalTo:device_label.bottomAnchor,constant:view.frame.size.height/30).isActive = true
        westcottimage.widthAnchor.constraint(equalToConstant: view.frame.size.width-20).isActive = true
        westcottimage.heightAnchor.constraint(equalToConstant: view.frame.size.height/10).isActive = true
        
        if stat_device {
            reset_btn.isHidden = true
        }
    }
    
    private func labellayout(){
        view.addSubview(ch1label)
        view.addSubview(ch2label)
        view.addSubview(ch3label)
        view.addSubview(ch4label)
        
        view.addSubview(cct1label)
        view.addSubview(cct2label)
        view.addSubview(cct3label)
        view.addSubview(cct4label)
        
        view.addSubview(brt1label)
        view.addSubview(brt2label)
        view.addSubview(brt3label)
        view.addSubview(brt4label)
        
        ch1label.translatesAutoresizingMaskIntoConstraints = false
        ch1label.bottomAnchor.constraint(equalTo:view.bottomAnchor, constant:-(view.frame.size.height/5)).isActive = true
        ch1label.leftAnchor.constraint(equalTo:view.leftAnchor, constant:view.frame.size.width/10).isActive = true
        ch1label.textColor = .white
        if stat_device {
            ch1label.text = "CH1"
        }
        else
        {
            ch1label.text = "P1"
        }
        
        ch1label.font = UIFont.systemFont(ofSize:70)
        
        cct1label.translatesAutoresizingMaskIntoConstraints = false
        cct1label.leftAnchor.constraint(equalTo:ch1label.rightAnchor, constant: 21).isActive = true
        cct1label.topAnchor.constraint(equalTo:ch1label.topAnchor).isActive = true
        cct1label.text = "2800K"
        cct1label.textColor = .white
        cct1label.font = UIFont.systemFont(ofSize:30)
        
        brt1label.translatesAutoresizingMaskIntoConstraints = false
        brt1label.leftAnchor.constraint(equalTo:cct1label.leftAnchor).isActive = true
        brt1label.bottomAnchor.constraint(equalTo:ch1label.bottomAnchor).isActive = true
        brt1label.text = "100%"
        brt1label.textColor = .white
        brt1label.font = UIFont.systemFont(ofSize:30)
        
        cct2label.translatesAutoresizingMaskIntoConstraints = false
        cct2label.topAnchor.constraint(equalTo:ch1label.topAnchor).isActive = true
        cct2label.rightAnchor.constraint(equalTo:view.rightAnchor,constant:-view.frame.size.width/10).isActive = true
        cct2label.text = "2800K"
        cct2label.textColor = .white
        cct2label.font = UIFont.systemFont(ofSize:30)
        
        ch2label.translatesAutoresizingMaskIntoConstraints = false
        ch2label.topAnchor.constraint(equalTo:ch1label.topAnchor).isActive = true
        ch2label.rightAnchor.constraint(equalTo:cct2label.leftAnchor,constant:-10).isActive = true
        ch2label.text = "P2"
        ch2label.textColor = .white
        ch2label.font = UIFont.systemFont(ofSize:70)
        
        brt2label.translatesAutoresizingMaskIntoConstraints = false
        brt2label.bottomAnchor.constraint(equalTo:ch1label.bottomAnchor).isActive = true
        brt2label.leftAnchor.constraint(equalTo:cct2label.leftAnchor,constant:0).isActive = true
        brt2label.text = "100%"
        brt2label.textColor = .white
        brt2label.font = UIFont.systemFont(ofSize:30)
        
        ch3label.translatesAutoresizingMaskIntoConstraints = false
        ch3label.topAnchor.constraint(equalTo:ch1label.bottomAnchor, constant:view.frame.size.height/15).isActive = true
        ch3label.leftAnchor.constraint(equalTo:view.leftAnchor, constant:view.frame.size.width/10).isActive = true
        ch3label.textColor = .white
        ch3label.text = "P3"
        ch3label.font = UIFont.systemFont(ofSize:70)
        
        cct3label.translatesAutoresizingMaskIntoConstraints = false
        cct3label.leftAnchor.constraint(equalTo:ch3label.rightAnchor, constant: 10).isActive = true
        cct3label.topAnchor.constraint(equalTo:ch3label.topAnchor).isActive = true
        cct3label.text = "2800K"
        cct3label.textColor = .white
        cct3label.font = UIFont.systemFont(ofSize:30)
        
        brt3label.translatesAutoresizingMaskIntoConstraints = false
        brt3label.leftAnchor.constraint(equalTo:cct3label.leftAnchor).isActive = true
        brt3label.bottomAnchor.constraint(equalTo:ch3label.bottomAnchor).isActive = true
        brt3label.text = "100%"
        brt3label.textColor = .white
        brt3label.font = UIFont.systemFont(ofSize:30)
        
        cct4label.translatesAutoresizingMaskIntoConstraints = false
        cct4label.topAnchor.constraint(equalTo:ch3label.topAnchor).isActive = true
        cct4label.rightAnchor.constraint(equalTo:view.rightAnchor,constant:-view.frame.size.width/10).isActive = true
        cct4label.text = "2800K"
        cct4label.textColor = .white
        cct4label.font = UIFont.systemFont(ofSize:30)
        
        ch4label.translatesAutoresizingMaskIntoConstraints = false
        ch4label.topAnchor.constraint(equalTo:ch3label.topAnchor).isActive = true
        ch4label.rightAnchor.constraint(equalTo:cct4label.leftAnchor,constant:-10).isActive = true
        ch4label.text = "P4"
        ch4label.textColor = .white
        ch4label.font = UIFont.systemFont(ofSize:70)
        
        brt4label.translatesAutoresizingMaskIntoConstraints = false
        brt4label.bottomAnchor.constraint(equalTo:ch3label.bottomAnchor).isActive = true
        brt4label.leftAnchor.constraint(equalTo:cct4label.leftAnchor,constant:0).isActive = true
        brt4label.text = "100%"
        brt4label.textColor = .white
        brt4label.font = UIFont.systemFont(ofSize:30)
        
        if stat_device {
            if connect_device[0] == 0 {
                ch2label.isHidden = true
                cct2label.isHidden = true
                brt2label.isHidden = true
            }
            else {
                ch2label.text = "CH2"
            }
            if connect_device[1] == 0 {
                ch3label.isHidden = true
                cct3label.isHidden = true
                brt3label.isHidden = true
            }
            else {
                ch3label.text = "CH3"
            }
            if connect_device[2] == 0 {
                ch4label.isHidden = true
                cct4label.isHidden = true
                brt4label.isHidden = true
            }
            else {
                ch4label.text = "CH4"
            }
        }
    }
    private func sliderlayout(){
        view.addSubview(cctlabel)
        view.addSubview(cctslider)
        view.addSubview(brtlabel)
        view.addSubview(brtslider)
        
        cctlabel.translatesAutoresizingMaskIntoConstraints = false
        cctlabel.textColor = .white
        cctlabel.text = "2800K"
        cctlabel.font = UIFont.systemFont(ofSize: 45)
        cctlabel.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        cctlabel.topAnchor.constraint(equalTo:p1btn.bottomAnchor,constant:view.frame.size.height/15).isActive = true
        
        cctslider.translatesAutoresizingMaskIntoConstraints = false
        cctslider.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        cctslider.topAnchor.constraint(equalTo: cctlabel.bottomAnchor,constant:10).isActive = true
        cctslider.backgroundColor = .white
        cctslider.minimumValue = 0
        cctslider.maximumValue = 32
        cctslider.backgroundColor = .black
        cctslider.leftAnchor.constraint(equalTo:view.leftAnchor,constant:7).isActive = true
        cctslider.widthAnchor.constraint(equalToConstant:view.frame.size.width).isActive = true
        cctslider.minimumTrackTintColor = UIColor(red:255/255,green:120/255,blue:40/255,alpha:1.0)
        cctslider.maximumTrackTintColor = UIColor(red:255/255,green:120/255,blue:40/255,alpha:1.0)
        cctslider.addTarget(self, action: #selector(cctslide(_:)), for: .valueChanged)
        
        brtlabel.translatesAutoresizingMaskIntoConstraints = false
        brtlabel.textColor = .white
        brtlabel.text = "100%"
        brtlabel.font = UIFont.systemFont(ofSize: 45)
        brtlabel.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        brtlabel.topAnchor.constraint(equalTo:cctslider.bottomAnchor,constant:35).isActive = true
        brtslider.translatesAutoresizingMaskIntoConstraints = false
        brtslider.centerXAnchor.constraint(equalTo:view.centerXAnchor).isActive = true
        brtslider.topAnchor.constraint(equalTo: brtlabel.bottomAnchor,constant:7).isActive = true
        brtslider.backgroundColor = .white
        brtslider.minimumValue = 0
        brtslider.maximumValue = 100
        brtslider.value=100
        brtslider.backgroundColor = .black
        brtslider.leftAnchor.constraint(equalTo:view.leftAnchor,constant:20).isActive = true
        brtslider.widthAnchor.constraint(equalToConstant:view.frame.size.width).isActive = true
        brtslider.minimumTrackTintColor = UIColor(red:255/255,green:255/255,blue:255/255,alpha:1.0)
        brtslider.maximumTrackTintColor = UIColor(red:255/255,green:255/255,blue:255/255,alpha:1.0)
        brtslider.addTarget(self, action: #selector(brtslide(_:)), for: .valueChanged)
        
        
        multi_slider.frame = CGRect(x: (view.frame.size.width/2)-185, y: 390, width: 370, height: 370)
        multi_slider.currentValue = (100.0*3)/4
        multi_slider.maximumAngle = 270.0
        multi_slider.lineWidth = 35
        multi_slider.filledColor = UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 1.0)
        multi_slider.unfilledColor = UIColor.gray
        multi_slider.handleType = .doubleCircle
        multi_slider.handleColor = UIColor(red: 255 / 255.0, green: 69 / 255.0, blue: 96 / 255.0, alpha: 1.0)
        multi_slider.handleEnlargementPoints = 12
        multi_slider.addTarget(self, action: #selector(multi_day_slide(_:)), for: .valueChanged)
        multi_day_label.frame = CGRect(x: (view.frame.size.width/2)-145, y: 425, width: 300, height: 300)
        multi_day_label.text = "100%"
        multi_day_label.textAlignment = .center
        multi_day_label.textColor = .white
        multi_day_label.font = UIFont.systemFont(ofSize: 90)
        
        
        slider.frame = CGRect(x: (view.frame.size.width/2)-275, y: 380, width: 550, height: 550)
        slider.currentValue = (100.0*3)/4
        slider.maximumAngle = 270.0
        slider.lineWidth = 50
        slider.filledColor = UIColor(red: 255 / 255.0, green: 255 / 255.0, blue: 255 / 255.0, alpha: 1.0)
        slider.unfilledColor = UIColor.gray
        slider.handleType = .doubleCircle
        slider.handleColor = UIColor(red: 255 / 255.0, green: 69 / 255.0, blue: 96 / 255.0, alpha: 1.0)
        slider.handleEnlargementPoints = 12
        slider.addTarget(self, action: #selector(day_slide(_:)), for: .valueChanged)
        day_label.frame = CGRect(x: (view.frame.size.width/2)-140, y: 500, width: 300, height: 300)
        day_label.text = "100%"
        day_label.textAlignment = .center
        day_label.textColor = .white
        day_label.font = UIFont.systemFont(ofSize: 120)
        
        
        view.addSubview(slider)
        view.addSubview(day_label)
        view.addSubview(multi_slider)
        view.addSubview(multi_day_label)
        
        cctlabel.isHidden = true
        cctslider.isHidden = true
        brtlabel.isHidden = true
        brtslider.isHidden = true
        slider.isHidden = true
        day_label.isHidden = true
        multi_slider.isHidden = true
        multi_day_label.isHidden = true
        
    }
    private func channellayout(){
        view.addSubview(p1btn)
        view.addSubview(p2btn)
        view.addSubview(p3btn)
        view.addSubview(p4btn)
        
        p1btn.backgroundColor = .black
        if stat_device {
            p1btn.setTitle("CH1", for: .normal)
            p1btn.setTitleColor(.white, for: .normal)
            //p1btn.setAttributedTitle(NSAttributedString(string: "CH1", attributes: strokeTextAttributes), for: .normal)
        }
        else {
            p1btn.setAttributedTitle(NSAttributedString(string: "P1", attributes: preset_btn_design_gray), for: .normal)
            let longpress1 = UILongPressGestureRecognizer(target: self, action: #selector(Longclick_p1(recogizer:)))
            longpress1.minimumPressDuration = 0.7
            p1btn.addGestureRecognizer(longpress1)
            let longpress2 = UILongPressGestureRecognizer(target: self, action: #selector(Longclick_p2(recogizer:)))
            longpress2.minimumPressDuration = 0.7
            p2btn.addGestureRecognizer(longpress2)
            let longpress3 = UILongPressGestureRecognizer(target: self, action: #selector(Longclick_p3(recogizer:)))
            longpress3.minimumPressDuration = 0.7
            p3btn.addGestureRecognizer(longpress3)
            let longpress4 = UILongPressGestureRecognizer(target: self, action: #selector(Longclick_p4(recogizer:)))
            longpress4.minimumPressDuration = 0.7
            p4btn.addGestureRecognizer(longpress4)
        }
        p1btn.titleLabel?.font=UIFont(name:"HelveticaNeue-Bold",size:55)
        p1btn.translatesAutoresizingMaskIntoConstraints = false
        p1btn.topAnchor.constraint(equalTo:westcottimage.bottomAnchor,constant:view.frame.size.height/20).isActive = true
        p1btn.leftAnchor.constraint(equalTo:view.leftAnchor,constant:0).isActive = true
        p1btn.widthAnchor.constraint(equalToConstant:view.frame.size.width/4).isActive = true
        p1btn.addTarget(self, action: #selector(self.pressbtn1(_:)), for: .touchUpInside)
        
        p2btn.setAttributedTitle(NSAttributedString(string: "P2", attributes: preset_btn_design_gray), for: .normal)
        p2btn.setTitleColor(UIColor(red:102/255,green:102/255,blue:102/255,alpha:1.0), for: .normal)
        p2btn.titleLabel?.font=UIFont(name:"HelveticaNeue-Bold",size:55)
        p2btn.translatesAutoresizingMaskIntoConstraints = false
        p2btn.topAnchor.constraint(equalTo:westcottimage.bottomAnchor,constant:view.frame.size.height/20).isActive = true
        p2btn.leftAnchor.constraint(equalTo:view.leftAnchor,constant:view.frame.size.width/4).isActive = true
        p2btn.widthAnchor.constraint(equalToConstant:view.frame.size.width/4).isActive = true
        
        p2btn.layer.borderWidth = 1.0
        p2btn.addTarget(self, action: #selector(self.pressbtn2(_:)), for: .touchUpInside)
        
        p3btn.setAttributedTitle(NSAttributedString(string: "P3", attributes: preset_btn_design_gray), for: .normal)
        p3btn.setTitleColor(UIColor(red:102/255,green:102/255,blue:102/255,alpha:1.0), for: .normal)
        p3btn.titleLabel?.font=UIFont(name:"HelveticaNeue-Bold",size:55)
        p3btn.translatesAutoresizingMaskIntoConstraints = false
        p3btn.topAnchor.constraint(equalTo:westcottimage.bottomAnchor,constant:view.frame.size.height/20).isActive = true
        p3btn.leftAnchor.constraint(equalTo:view.leftAnchor,constant:view.frame.size.width*2/4).isActive = true
        p3btn.widthAnchor.constraint(equalToConstant:view.frame.size.width/4).isActive = true
        p3btn.addTarget(self, action: #selector(self.pressbtn3(_:)), for: .touchUpInside)
        
        p4btn.setAttributedTitle(NSAttributedString(string: "P4", attributes: preset_btn_design_gray), for: .normal)
        p4btn.setTitleColor(UIColor(red:102/255,green:102/255,blue:102/255,alpha:1.0), for: .normal)
        p4btn.titleLabel?.font=UIFont(name:"HelveticaNeue-Bold",size:55)
        p4btn.translatesAutoresizingMaskIntoConstraints = false
        p4btn.topAnchor.constraint(equalTo:westcottimage.bottomAnchor,constant:view.frame.size.height/20).isActive = true
        p4btn.leftAnchor.constraint(equalTo:view.leftAnchor,constant:view.frame.size.width*3/4).isActive = true
        p4btn.widthAnchor.constraint(equalToConstant:view.frame.size.width/4).isActive = true
        p4btn.addTarget(self, action: #selector(self.pressbtn4(_:)), for: .touchUpInside)
        
        if stat_device {
            if connect_device[0] == 0 {
                p2btn.isHidden = true
            }
            else {
                p2btn.setTitle("CH2", for: .normal)
            }
            if connect_device[1] == 0 {
                p3btn.isHidden = true
            }
            else {
                p3btn.setTitle("CH3", for: .normal)
            }
            if connect_device[2] == 0 {
                p4btn.isHidden = true
            }
            else {
                p4btn.setTitle("CH4", for: .normal)
            }
        }
    }
    func setting_preset() {
        print("preset value : \(preset_value[0][0])")
        view.backgroundColor = UIColor(white: 0.0, alpha: 0.3)
        view_alpha(alpha: 0.3)
        stat_preset_view(stat: true)
        
        
        background_preset.backgroundColor = .white
        background_preset.frame = CGRect(x: 0, y: 0, width: view.frame.width*4/5, height: view.frame.height*9/24)
        background_preset.center.x = view.center.x
        background_preset.center.y = view.center.y
        
        text_preset.translatesAutoresizingMaskIntoConstraints = false
        text_preset.topAnchor.constraint(equalTo:background_preset.topAnchor,constant:10).isActive = true
        text_preset.leftAnchor.constraint(equalTo:background_preset.leftAnchor,constant:20).isActive = true
        text_preset.text = "Setting Preset"+String(Int(clicked_preset))
        text_preset.font = UIFont.boldSystemFont(ofSize: 30)
        
        cct_preset.translatesAutoresizingMaskIntoConstraints = false
        cct_preset.topAnchor.constraint(equalTo:text_preset.bottomAnchor,constant:40).isActive = true
        cct_preset.centerXAnchor.constraint(equalTo:background_preset.centerXAnchor).isActive = true
        switch clicked_preset {
        case 1:cct_preset.text = String(preset_value[0][0]*100+2800)+"K"
        case 2:cct_preset.text = String(preset_value[1][0]*100+2800)+"K"
        case 3:cct_preset.text = String(preset_value[2][0]*100+2800)+"K"
        case 4:cct_preset.text = String(preset_value[3][0]*100+2800)+"K"
        default: break
        }
        cct_preset.font = UIFont.systemFont(ofSize: 30)
        
        
        cctslider_preset.translatesAutoresizingMaskIntoConstraints = false
        cctslider_preset.topAnchor.constraint(equalTo:cct_preset.bottomAnchor).isActive = true
        cctslider_preset.leftAnchor.constraint(equalTo:background_preset.leftAnchor, constant:30).isActive = true
        cctslider_preset.backgroundColor = .white
        cctslider_preset.minimumValue = 0
        cctslider_preset.maximumValue = 32
        cctslider_preset.widthAnchor.constraint(equalToConstant:background_preset.frame.width-60).isActive = true
        
        switch clicked_preset {
        case 1:cctslider_preset.value = Float(preset_value[0][0])
        case 2:cctslider_preset.value = Float(preset_value[1][0])
        case 3:cctslider_preset.value = Float(preset_value[2][0])
        case 4:cctslider_preset.value = Float(preset_value[3][0])
        default:break
        }
        let red:CGFloat = (CGFloat(255+(77-255)*cctslider_preset.value/32))
        var green:CGFloat = (CGFloat(120+(170-120)*cctslider_preset.value/32))
        var blue : CGFloat = (CGFloat(40+(232-40)*cctslider_preset.value/32))
        cctslider_preset.minimumTrackTintColor = UIColor(red:red/255,green:green/255,blue:blue/255,alpha:1.0)
        cctslider_preset.maximumTrackTintColor = UIColor(red:red/255,green:green/255,blue:blue/255,alpha:1.0)
        cctslider_preset.addTarget(self, action: #selector(cctslide_preset(_:)), for: .valueChanged)
        
        brt_preset.translatesAutoresizingMaskIntoConstraints = false
        brt_preset.topAnchor.constraint(equalTo:cctslider_preset.bottomAnchor,constant:40).isActive = true
        brt_preset.centerXAnchor.constraint(equalTo:background_preset.centerXAnchor).isActive = true
        switch clicked_preset {
        case 1:brt_preset.text = String(preset_value[0][1])+"%"
        case 2:brt_preset.text = String(preset_value[1][1])+"%"
        case 3:brt_preset.text = String(preset_value[2][1])+"%"
        case 4:brt_preset.text = String(preset_value[3][1])+"%"
        default: break
        }
        brt_preset.font = UIFont.systemFont(ofSize: 30)
        
        brtslider_preset.translatesAutoresizingMaskIntoConstraints = false
        brtslider_preset.topAnchor.constraint(equalTo:brt_preset.bottomAnchor).isActive = true
        brtslider_preset.leftAnchor.constraint(equalTo:background_preset.leftAnchor, constant:30).isActive = true
        brtslider_preset.backgroundColor = .white
        brtslider_preset.minimumValue = 0
        brtslider_preset.maximumValue = 100
        brtslider_preset.widthAnchor.constraint(equalToConstant:background_preset.frame.width-60).isActive = true
        brtslider_preset.minimumTrackTintColor = UIColor(red:0/255,green:0/255,blue:0/255,alpha:1.0)
        brtslider_preset.maximumTrackTintColor = UIColor(red:0/255,green:0/255,blue:00/255,alpha:1.0)
        switch clicked_preset {
        case 1:brtslider_preset.value = Float(preset_value[0][1])
        case 2:brtslider_preset.value = Float(preset_value[1][1])
        case 3:brtslider_preset.value = Float(preset_value[2][1])
        case 4:brtslider_preset.value = Float(preset_value[3][1])
        default:break
        }
        brtslider_preset.addTarget(self, action: #selector(brtslide_preset(_:)), for: .valueChanged)
        
        cancel_preset.translatesAutoresizingMaskIntoConstraints = false
        cancel_preset.rightAnchor.constraint(equalTo:cctslider_preset.rightAnchor).isActive = true
        cancel_preset.bottomAnchor.constraint(equalTo:background_preset.bottomAnchor,constant:-20).isActive = true
        cancel_preset.setTitle("CANCEL", for: .normal)
        cancel_preset.setTitleColor(.black, for: .normal)
        cancel_preset.titleLabel?.font=UIFont(name:"HelveticaNeue-Bold",size:30)
        cancel_preset.addTarget(self, action: #selector(cancel_preset_action(_:)), for: .touchUpInside)
        
        ok_preset.translatesAutoresizingMaskIntoConstraints = false
        ok_preset.rightAnchor.constraint(equalTo:cancel_preset.leftAnchor,constant:-30).isActive = true
        ok_preset.bottomAnchor.constraint(equalTo:background_preset.bottomAnchor,constant:-20).isActive = true
        ok_preset.setTitle("OK", for: .normal)
        ok_preset.setTitleColor(.black, for: .normal)
        ok_preset.titleLabel?.font=UIFont(name:"HelveticaNeue-Bold",size:30)
        ok_preset.addTarget(self, action: #selector(ok_preset_action(_:)), for: .touchUpInside)
 
        cct_preset_value = Int(cctslider_preset.value)
        brt_preset_value = Int(brtslider_preset.value)
    }
    @objc func Longclick_p1(recogizer: UILongPressGestureRecognizer) {
        clicked_preset = 1
        setting_preset()
    }
    @objc func Longclick_p2(recogizer: UILongPressGestureRecognizer) {
        clicked_preset = 2
        setting_preset()
    }
    @objc func Longclick_p3(recogizer: UILongPressGestureRecognizer) {
        clicked_preset = 3
        setting_preset()
    }
    @objc func Longclick_p4(recogizer: UILongPressGestureRecognizer) {
        clicked_preset = 4
        setting_preset()
    }
    @objc func ok_preset_action(_ sender: Any){
        switch clicked_preset {
        case 1:cct1label.text = String(cct_preset_value*100+2800)+"K";brt1label.text = String(brt_preset_value)+"%"
        case 2:cct2label.text = String(cct_preset_value*100+2800)+"K";brt2label.text = String(brt_preset_value)+"%"
        case 3:cct3label.text = String(cct_preset_value*100+2800)+"K";brt3label.text = String(brt_preset_value)+"%"
        case 4:cct4label.text = String(cct_preset_value*100+2800)+"K";brt4label.text = String(brt_preset_value)+"%"
        default:break
        }
        view_alpha(alpha: 1)
        
        wifi_request(message: "pres"+String(clicked_preset)+"c"+String(cct_preset_value)+"b"+String(brt_preset_value))
        stat_preset_view(stat: false)
    }
    
    @objc func cancel_preset_action(_ sender: Any){
        view_alpha(alpha: 1)
        
        stat_preset_view(stat: false)
    }
    
    func stat_preset_view(stat:Bool) {
        background_preset.isHidden = !stat
        text_preset.isHidden = !stat
        cctslider_preset.isHidden = !stat
        brtslider_preset.isHidden = !stat
        cct_preset.isHidden = !stat
        brt_preset.isHidden = !stat
        ok_preset.isHidden = !stat
        cancel_preset.isHidden = !stat
    }
    
    
    
    @objc func multi_timer() {
        
        if getWifissid() == name {
            if let timer = multi_check_timer {
                if ( timer.isValid ) {
                    timer.invalidate()
                }
            }
            pings = ["192.168.4.3","192.168.4.4","192.168.4.5"]
            swipe_multi_check(stat:0)
        }
        else {
            
        }
    }
    func create_alert(mode:String,stat_textfield:Bool, title:String, title_font:CGFloat, text:String, text_font:CGFloat) {
        stat_alert = 1
        for v in info_background.subviews {
            v.isUserInteractionEnabled = false
        }
        for v in function_background.subviews {
            v.isUserInteractionEnabled = false
        }
        let alert_title = UILabel()
        let alert_text = UILabel()
        
        let alert_connect = UIButton()
        let alert_cancel = UIButton()
        
        enable(stat: false)
        alert_view.frame = CGRect(x: 0, y: 0, width: view.frame.width*2/3, height: 330)
        
        alert_view.backgroundColor = UIColor(red: 204/255, green: 204/255, blue: 204/255, alpha: 1)
        alert_view.layer.cornerRadius = 18
        
        
        alert_title.frame = CGRect(x: 0, y: 30, width: alert_view.frame.width-60, height: 0)
        alert_title.text = title
        alert_title.font = UIFont.boldSystemFont(ofSize: title_font)
        alert_title.textColor = .black
        alert_title.lineBreakMode = .byWordWrapping
        alert_title.numberOfLines = 0
        alert_title.sizeToFit()
        alert_title.center.x = alert_view.bounds.midX
        alert_view.addSubview(alert_title)
        
        alert_text.frame = CGRect(x: 0, y: alert_title.frame.maxY+20, width: alert_view.frame.width-60, height:0)
        alert_text.text = text
        alert_text.textColor = .black
        alert_text.lineBreakMode = .byWordWrapping
        alert_text.numberOfLines = 0
        alert_text.font = UIFont.systemFont(ofSize: text_font)
        alert_text.textAlignment = .center
        alert_text.sizeToFit()
        alert_text.center.x = alert_view.bounds.midX
        alert_view.addSubview(alert_text)
        if mode == "Error" {
            alert_cancel.frame = CGRect(x: 0, y: alert_text.frame.maxY+40, width: alert_view.frame.width, height:80)
            alert_cancel.setTitle("OK", for: .normal)
            alert_cancel.setTitleColor(UIColor(red: 0, green: 122/255, blue: 1, alpha: 1), for: .normal)
            alert_cancel.titleLabel?.font = UIFont.boldSystemFont(ofSize: 33)
            alert_cancel.titleLabel?.textAlignment = .center
            alert_cancel.layer.borderWidth = 0.7
            alert_cancel.layer.borderColor = UIColor.black.cgColor
            alert_cancel.setBackgroundColor(color: .gray, forState: .highlighted)
            alert_cancel.clipsToBounds = true
            alert_cancel.layer.cornerRadius = 18
            alert_cancel.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
            alert_cancel.addTarget(self, action: #selector(alert_cancel_selector(_:)), for: .touchUpInside)
            alert_view.addSubview(alert_cancel)
        }
        else if mode == "Slave" {
            if stat_textfield {
                alert_wifi_name.frame = CGRect(x: alert_text.frame.minX, y: alert_text.frame.maxY+30, width: alert_view.frame.width-60, height: 40)
                alert_wifi_name.placeholder = "WiFi Name"
                alert_wifi_name.backgroundColor = .white
                alert_wifi_name.layer.borderColor = UIColor.black.cgColor
                alert_wifi_name.layer.borderWidth = 0.5
                alert_wifi_name.font = UIFont.systemFont(ofSize: 25)
                alert_view.addSubview(alert_wifi_name)
                
                alert_wifi_password.frame = CGRect(x: alert_text.frame.minX, y: alert_wifi_name.frame.maxY, width: alert_view.frame.width-60, height: 40)
                alert_wifi_password.placeholder = "WiFi Password"
                alert_wifi_password.backgroundColor = .white
                alert_wifi_password.layer.borderColor = UIColor.black.cgColor
                alert_wifi_password.layer.borderWidth = 0.5
                alert_wifi_password.font = UIFont.systemFont(ofSize: 25)
                alert_view.addSubview(alert_wifi_password)
                
                alert_cancel.frame = CGRect(x: 0, y: alert_wifi_password.frame.maxY+20, width: alert_view.frame.width/2, height: 60)
                alert_cancel.setTitle("Cancel", for: .normal)
                alert_cancel.setTitleColor(UIColor(red: 0, green: 122/255, blue: 1, alpha: 1), for: .normal)
                alert_cancel.titleLabel?.font = UIFont.systemFont(ofSize: 33)
                alert_cancel.titleLabel?.textAlignment = .center
                alert_cancel.layer.borderWidth = 0.7
                alert_cancel.layer.borderColor = UIColor.black.cgColor
                alert_cancel.setBackgroundColor(color: .gray, forState: .highlighted)
                alert_cancel.clipsToBounds = true
                alert_cancel.layer.cornerRadius = 18
                alert_cancel.layer.maskedCorners = [.layerMinXMaxYCorner]
                alert_view.addSubview(alert_cancel)
                alert_cancel.addTarget(self, action: #selector(alert_cancel_selector(_:)), for: .touchUpInside)
                
                alert_connect.frame = CGRect(x: alert_cancel.frame.maxX, y: alert_wifi_password.frame.maxY+20, width: alert_view.frame.width/2, height: 60)
                alert_connect.setTitle("Connect", for: .normal)
                alert_connect.setTitleColor(UIColor(red: 0, green: 122/255, blue: 1, alpha: 1), for: .normal)
                alert_connect.titleLabel?.font = UIFont.boldSystemFont(ofSize: 33)
                alert_connect.titleLabel?.textAlignment = .center
                alert_connect.layer.borderWidth = 0.7
                alert_connect.layer.borderColor = UIColor.black.cgColor
                alert_connect.setBackgroundColor(color: .gray, forState: .highlighted)
                alert_connect.clipsToBounds = true
                alert_connect.layer.cornerRadius = 18
                alert_connect.layer.maskedCorners = [.layerMaxXMaxYCorner]
                alert_connect.addTarget(self, action: #selector(alert_connect_selector(_:)), for: .touchUpInside)
                alert_view.addSubview(alert_connect)
                alert_wifi_name.becomeFirstResponder()
            }
                
            else {
                alert_cancel.frame = CGRect(x: 0, y: alert_text.frame.maxY+40, width: alert_view.frame.width, height:80)
                alert_cancel.setTitle("OK", for: .normal)
                alert_cancel.setTitleColor(UIColor(red: 0, green: 122/255, blue: 1, alpha: 1), for: .normal)
                alert_cancel.titleLabel?.font = UIFont.boldSystemFont(ofSize: 33)
                alert_cancel.titleLabel?.textAlignment = .center
                alert_cancel.layer.borderWidth = 0.7
                alert_cancel.layer.borderColor = UIColor.black.cgColor
                alert_cancel.setBackgroundColor(color: .gray, forState: .highlighted)
                alert_cancel.clipsToBounds = true
                alert_cancel.layer.cornerRadius = 18
                alert_cancel.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
                alert_cancel.addTarget(self, action: #selector(alert_cancel_selector(_:)), for: .touchUpInside)
                alert_view.addSubview(alert_cancel)
            }
        }
        else if mode == "Reset" {
            alert_cancel.frame = CGRect(x: 0, y: alert_text.frame.maxY+30, width: alert_view.frame.width/2, height: 60)
            alert_cancel.setTitle("Cancel", for: .normal)
            alert_cancel.setTitleColor(UIColor(red: 0, green: 122/255, blue: 1, alpha: 1), for: .normal)
            alert_cancel.titleLabel?.font = UIFont.systemFont(ofSize: 33)
            alert_cancel.titleLabel?.textAlignment = .center
            alert_cancel.layer.borderWidth = 0.7
            alert_cancel.layer.borderColor = UIColor.black.cgColor
            alert_cancel.setBackgroundColor(color: .gray, forState: .highlighted)
            alert_cancel.clipsToBounds = true
            alert_cancel.layer.cornerRadius = 18
            alert_cancel.layer.maskedCorners = [.layerMinXMaxYCorner]
            alert_view.addSubview(alert_cancel)
            alert_cancel.addTarget(self, action: #selector(alert_cancel_selector(_:)), for: .touchUpInside)
            
            alert_connect.frame = CGRect(x: alert_cancel.frame.maxX, y: alert_text.frame.maxY+30, width: alert_view.frame.width/2, height: 60)
            alert_connect.setTitle("Ok", for: .normal)
            alert_connect.setTitleColor(UIColor(red: 0, green: 122/255, blue: 1, alpha: 1), for: .normal)
            alert_connect.titleLabel?.font = UIFont.boldSystemFont(ofSize: 33)
            alert_connect.titleLabel?.textAlignment = .center
            alert_connect.layer.borderWidth = 0.7
            alert_connect.layer.borderColor = UIColor.black.cgColor
            alert_connect.setBackgroundColor(color: .gray, forState: .highlighted)
            alert_connect.clipsToBounds = true
            alert_connect.layer.cornerRadius = 18
            alert_connect.layer.maskedCorners = [.layerMaxXMaxYCorner]
            alert_connect.addTarget(self, action: #selector(reset_selector(_:)), for: .touchUpInside)
            alert_view.addSubview(alert_connect)
        }
        else {
            alert_cancel.frame = CGRect(x: 0, y: alert_text.frame.maxY+30, width: alert_view.frame.width/2, height: 60)
            alert_cancel.setTitle("Cancel", for: .normal)
            alert_cancel.setTitleColor(UIColor(red: 0, green: 122/255, blue: 1, alpha: 1), for: .normal)
            alert_cancel.titleLabel?.font = UIFont.systemFont(ofSize: 33)
            alert_cancel.titleLabel?.textAlignment = .center
            alert_cancel.layer.borderWidth = 0.7
            alert_cancel.layer.borderColor = UIColor.black.cgColor
            alert_cancel.setBackgroundColor(color: .gray, forState: .highlighted)
            alert_cancel.clipsToBounds = true
            alert_cancel.layer.cornerRadius = 18
            alert_cancel.layer.maskedCorners = [.layerMinXMaxYCorner]
            alert_view.addSubview(alert_cancel)
            alert_cancel.addTarget(self, action: #selector(alert_cancel_selector(_:)), for: .touchUpInside)
            
            alert_connect.frame = CGRect(x: alert_cancel.frame.maxX, y: alert_text.frame.maxY+30, width: alert_view.frame.width/2, height: 60)
            alert_connect.setTitle("Ok", for: .normal)
            alert_connect.setTitleColor(UIColor(red: 0, green: 122/255, blue: 1, alpha: 1), for: .normal)
            alert_connect.titleLabel?.font = UIFont.boldSystemFont(ofSize: 33)
            alert_connect.titleLabel?.textAlignment = .center
            alert_connect.layer.borderWidth = 0.7
            alert_connect.layer.borderColor = UIColor.black.cgColor
            alert_connect.setBackgroundColor(color: .gray, forState: .highlighted)
            alert_connect.clipsToBounds = true
            alert_connect.layer.cornerRadius = 18
            alert_connect.layer.maskedCorners = [.layerMaxXMaxYCorner]
            alert_connect.addTarget(self, action: #selector(mode_to_master_selector(_:)), for: .touchUpInside)
            alert_view.addSubview(alert_connect)
        }
        alert_view.frame = CGRect(x: 0, y: 0, width: view.frame.width*2/3, height: alert_view.subviews[alert_view.subviews.endIndex-1].frame.maxY)
        alert_view.center.x = view.center.x
        alert_view.center.y = view.center.y
        view.addSubview(alert_view)
        for v in view.subviews {
            v.alpha = 0.3
        }
        info_background.alpha = 0.5
        function_background.alpha = 0.5
        
        alert_view.alpha = 1
        for v in alert_view.subviews {
            v.alpha = 1
        }
        enable(stat: false)
    }
    
    @objc func mode_change(tapGestureRecognizer: UITapGestureRecognizer){
        if stat_device {
            if stat_ch_btn[0] == 1 {
                create_alert(mode:"Error",stat_textfield: true, title: "Multi Wifi error", title_font: 30, text: "Client mode is not possible because another dimmer is connected at current dimmer", text_font: 25)
            }
            else if (stat_ch_btn[0] == 0) && (stat_ch_btn[1] == 0) && (stat_ch_btn[2] == 0) && (stat_ch_btn[3] == 0) {
                create_alert(mode:"Error",stat_textfield: true, title: "No channels are selected", title_font: 30, text: "Please select a channel and try again", text_font: 25)
            }
            else {
                create_alert(mode:"Master",stat_textfield: false, title: "Client -> Host", title_font: 30, text: "Are you sure you want to go back to Host", text_font: 25)
            }
        }
        else {
            if UserDefaults.standard.integer(forKey: "dev"+String(self.current_device_count())+"mode") == 1 {
                create_alert(mode:"Error",stat_textfield: true, title: "Multi Wifi error", title_font: 30, text: "Client mode is not possible because another dimmer is connected at current dimmer", text_font: 25)
                return
            }
            else if UserDefaults.standard.integer(forKey: "dev"+String(self.current_device_count())+"mode") == 2 {
                create_alert(mode:"Master",stat_textfield: false, title: "Client -> Host", title_font: 30, text: "Are you sure you want to go back to Host", text_font: 25)
            }
            else {
                create_alert(mode:"Slave",stat_textfield: true, title: "Host -> Client", title_font: 30, text: "enter the name and password of the WiFi you want to connect to", text_font: 25)
            }
        }
    }
    
    @objc func alert_cancel_selector(_ sender: Any) {
        UIView.animate(withDuration: 0.2, animations: {alert_view.alpha = 0
            for v in self.view.subviews {
                if v != self.view.subviews[self.view.subviews.endIndex-1] {
                    v.alpha = 1
                }
            }
        }, completion: {(complete:Bool) in for v in alert_view.subviews {
            v.removeFromSuperview()
            }
            for v in info_background.subviews {
                v.isUserInteractionEnabled = true
            }
            for v in function_background.subviews {
                v.isUserInteractionEnabled = true
            }
            stat_alert = 0
            alert_view.removeFromSuperview()
            self.enable(stat: true)
            alert_wifi_name.text = ""
            alert_wifi_password.text = ""
        })
    }
    @objc func alert_connect_selector(_ sender: Any) {
        UIView.animate(withDuration: 0.2, animations: {alert_view.alpha = 0
            for v in self.view.subviews {
                if v != self.view.subviews[self.view.subviews.endIndex-1] {
                    v.alpha = 1
                }
            }
        }, completion: {(complete:Bool) in for v in alert_view.subviews {
            v.removeFromSuperview()
            }
            stat_alert = 0
            for v in info_background.subviews {
                v.isUserInteractionEnabled = true
            }
            for v in function_background.subviews {
                v.isUserInteractionEnabled = true
            }
            let wifi_name = alert_wifi_name.text!
            let wifi_password = alert_wifi_password.text!
            alert_wifi_name.text = ""
            alert_wifi_password.text = ""
            name = wifi_name
            password = wifi_password
            
            var count:Int = 1
            client_count = 3
            var finish:Bool = false
            while !finish{
                let text = UserDefaults.standard.string(forKey: "dev"+String(count)) ?? ""
                if name == self.getWifissid() {
                    self.toast_message(message: "Can not connect to a self dimmer.")
                    break
                }
                if count > (UserDefaults.standard.integer(forKey: "count") ?? 0) {
                    self.toast_message(message: "check your WiFi name")
                    break
                }
                
                if name == text {
                    if password != UserDefaults.standard.string(forKey: "dev"+String(count)+"password") {
                        self.toast_message(message: "check your WiFi password")
                        break
                    }
                    while true {
                        let count_client = UserDefaults.standard.integer(forKey: "dev"+String(count)+"client"+String(client_count)+"count") ?? 0
                        if UserDefaults.standard.integer(forKey: "dev"+String(count)+"mode") == 2 {
                            self.toast_message(message: "The dimmer you want to connect to is already connect to another dimmer")
                            finish = true
                            break
                        }
                        if client_count > 5 {
                            self.toast_message(message:"Connectable WiFi is exceeded")
                            finish = true
                            break
                        }
                        if count_client == 1 {
                            client_count += 1
                        }
                        else {
                            if let timer = mTimer {
                                if timer.isValid {
                                    timer.invalidate()
                                }
                            }
                            
                            
                            UserDefaults.standard.set(1,forKey: "dev"+String(count)+"client"+String(client_count)+"count")
                            UserDefaults.standard.set(UserDefaults.standard.string(forKey: "dev"+String(self.current_device_count())),forKey:"dev"+String(count)+"client"+String(client_count))
                            UserDefaults.standard.set(1,forKey:"dev"+String(count)+"mode")//master
                            UserDefaults.standard.set(2,forKey:"dev"+String(self.current_device_count())+"mode")//slave
                            UserDefaults.standard.set(UserDefaults.standard.string(forKey: "dev"+String(count)),forKey:"dev"+String(self.current_device_count())+"master")
                            print("client : \(name)+\(password)+\(client_count)")
                            let urlpath = "http://192.168.4.1/"
                            let special = "wif\(name)+\(password)+\(client_count)"
                            let url = NSURL(string:urlpath+special.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!)
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
                            finish = true
                            self.remove_presetbtn_gesture()
                            DispatchQueue.global(qos: .background).async {
                                
                                let hotspotconfig = NEHotspotConfiguration(ssid:name, passphrase:password,isWEP:false)
                                hotspotconfig.joinOnce = true
                                NEHotspotConfigurationManager.shared.apply(hotspotconfig){ (error) in
                                    if error != nil{
                                        if error?.localizedDescription == "already associatted."
                                        {
                                            print("connected")
                                        }
                                        else{
                                            print("no connected")
                                            self.toast_message(message: "Connect WiFi directly and restart app")
                                        }
                                    }
                                    else{
                                        print("connected")
                                    }
                                }
                            }
                            
                            if let timer = self.multi_check_timer {
                                if !timer.isValid {
                                    self.multi_check_timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.multi_timer), userInfo: nil, repeats: true)
                                }
                            }
                            else {
                                self.multi_check_timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.multi_timer), userInfo: nil, repeats: true)
                            }
                            
                            self.view_alpha(alpha: 0.3)
                            
                            Indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
                            Indicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
                            Indicator.center = self.view.center
                            Indicator.hidesWhenStopped = true
                            
                            self.view.addSubview(Indicator)
                            
                            Indicator.startAnimating()
                            for v in self.view.subviews {
                                v.isUserInteractionEnabled = false
                            }
                            break
                        }
                    }
                }
                count += 1
            }
        })
    }
    
    @objc func mode_to_master_selector(_ sender:Any) {
        UIView.animate(withDuration: 0.2, animations: {alert_view.alpha = 0
            for v in self.view.subviews {
                if v != self.view.subviews[self.view.subviews.endIndex-1] {
                    v.alpha = 1
                }
            }
        }, completion: {(complete:Bool) in for v in alert_view.subviews {
            v.removeFromSuperview()
            }
            alert_view.removeFromSuperview()
            for v in info_background.subviews {
                v.isUserInteractionEnabled = true
            }
            for v in function_background.subviews {
                v.isUserInteractionEnabled = true
            }
            stat_alert = 0
            self.enable(stat: true)
            if !stat_device {
                let text = self.getWifissid()
                for i in 1 ..< UserDefaults.standard.integer(forKey: "count")+1 {
                    if  text == UserDefaults.standard.string(forKey:"dev"+String(i)) {
                        UserDefaults.standard.set(0,forKey: "dev"+String(i)+"mode")
                        for j in 1 ..< UserDefaults.standard.integer(forKey: "count")+1 {
                            if UserDefaults.standard.string(forKey: "dev"+String(i)+"master") == UserDefaults.standard.string(forKey: "dev"+String(j)) {
                                for k in 3 ..< 6 {
                                    if UserDefaults.standard.string(forKey: "dev"+String(j)+"client"+String(k)) == text {
                                        UserDefaults.standard.set(0,forKey:"dev"+String(j)+"client"+String(k)+"count")
                                        UserDefaults.standard.removeObject(forKey: "dev"+String(j)+"client"+String(k))
                                        self.wifi_request_multi(channel: "1", message: "mas")
                                        break
                                    }
                                }
                                break
                            }
                        }
                        break
                    }
                }
            }
            else {
                if stat_ch_btn[1] == 1 {
                    self.wifi_request_multi(channel: "3", message: "mas")
                    multi_mat = "Void"
                    connect_device[0] = 0
                    p2btn.isHidden = true
                    ch2label.isHidden = true
                    cct2label.isHidden = true
                    brt2label.isHidden = true
                }
                if stat_ch_btn[2] == 1 {
                    self.wifi_request_multi(channel: "4", message: "mas")
                    multi_mat = "Void"
                    connect_device[1] = 0
                    p3btn.isHidden = true
                    ch3label.isHidden = true
                    cct3label.isHidden = true
                    brt3label.isHidden = true
                }
                if stat_ch_btn[3] == 1 {
                    self.wifi_request_multi(channel: "5", message: "mas")
                    multi_mat = "Void"
                    connect_device[2] = 0
                    p4btn.isHidden = true
                    ch4label.isHidden = true
                    cct4label.isHidden = true
                    brt4label.isHidden = true
                }
                var slave_count:Int=1
                while(true) {
                    let text = UserDefaults.standard.string(forKey: "dev"+String(slave_count)) ?? ""
                    print(text)
                    if self.getWifissid() == text {
                        if stat_ch_btn[1] == 1 {
                            stat_ch_btn[1] = 0
                            
                            UserDefaults.standard.set(0,forKey: "dev"+String(slave_count)+"client3"+"count")
                            UserDefaults.standard.set(0,forKey: "dev"+String(self.find_device_number(wifi_name: UserDefaults.standard.string(forKey: "dev"+String(slave_count)+"client3") ?? ""))+"mode")
                            UserDefaults.standard.removeObject(forKey: "dev"+String(slave_count)+"client3")
                            print("dev\(slave_count)client3 remove")
                        }
                        if stat_ch_btn[2] == 1 {
                            stat_ch_btn[2] = 0
                            UserDefaults.standard.set(0,forKey: "dev"+String(slave_count)+"client4"+"count")
                            UserDefaults.standard.set(0,forKey: "dev"+String(self.find_device_number(wifi_name: UserDefaults.standard.string(forKey: "dev"+String(slave_count)+"client4") ?? ""))+"mode")
                            UserDefaults.standard.removeObject(forKey: "dev"+String(slave_count)+"client4")
                            print("dev\(slave_count)client4 remove")
                        }
                        if stat_ch_btn[3] == 1 {
                            stat_ch_btn[3] = 0
                            UserDefaults.standard.set(0,forKey: "dev"+String(slave_count)+"client5"+"count")
                            UserDefaults.standard.set(0,forKey: "dev"+String(self.find_device_number(wifi_name: UserDefaults.standard.string(forKey: "dev"+String(slave_count)+"client5") ?? ""))+"mode")
                            UserDefaults.standard.removeObject(forKey: "dev"+String(slave_count)+"client5")
                            print("dev\(slave_count)client5 remove")
                        }
                        break
                    }
                    slave_count += 1
                }
                if (connect_device[0] == 0)&&(connect_device[1] == 0)&&(connect_device[2] == 0) {
                    reset_btn.isHidden = false
                    UserDefaults.standard.set(0,forKey: "dev"+String(self.current_device_count())+"mode")
                    mat = "Void"
                    stat_device = false
                    if false { //mat_channel[0] == "Single" {
                        multi_slider.isHidden = true
                        multi_day_label.isHidden = true
                    }
                    else {
                        multi_slider.isHidden = true
                        multi_day_label.isHidden = true
                        p1btn.setAttributedTitle(NSAttributedString(string: "P1", attributes: preset_btn_design_gray), for: .normal)
                        p2btn.setAttributedTitle(NSAttributedString(string: "P2", attributes: preset_btn_design_gray), for: .normal)
                        p3btn.setAttributedTitle(NSAttributedString(string: "P3", attributes: preset_btn_design_gray), for: .normal)
                        p4btn.setAttributedTitle(NSAttributedString(string: "P4", attributes: preset_btn_design_gray), for: .normal)
                        
                        let longpress1 = UILongPressGestureRecognizer(target: self, action: #selector(self.Longclick_p1(recogizer:)))
                        longpress1.minimumPressDuration = 0.7
                        p1btn.addGestureRecognizer(longpress1)
                        let longpress2 = UILongPressGestureRecognizer(target: self, action: #selector(self.Longclick_p2(recogizer:)))
                        longpress2.minimumPressDuration = 0.7
                        p2btn.addGestureRecognizer(longpress2)
                        let longpress3 = UILongPressGestureRecognizer(target: self, action: #selector(self.Longclick_p3(recogizer:)))
                        longpress3.minimumPressDuration = 0.7
                        p3btn.addGestureRecognizer(longpress3)
                        let longpress4 = UILongPressGestureRecognizer(target: self, action: #selector(self.Longclick_p4(recogizer:)))
                        longpress4.minimumPressDuration = 0.7
                        p4btn.addGestureRecognizer(longpress4)
                        ch1label.text = "P1"
                        ch2label.text = "P2"
                        ch3label.text = "P3"
                        ch4label.text = "P4"
                        
                    }
                    if let timer = mTimer {
                        if !timer.isValid {
                            mTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.getdata), userInfo: nil, repeats: true)
                        }
                    }
                    else {
                        mTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.getdata), userInfo: nil, repeats: true)
                    }
                    
                }
            }
        })
    }
    
    @objc func down(_ sender:UISwipeGestureRecognizer){
        info.isEnabled = false
        view_alpha(alpha: 0.3)
        Indicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        Indicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        Indicator.center = self.view.center
        Indicator.hidesWhenStopped = true
        
        self.view.addSubview(Indicator)
        if let timer = mTimer {
            if timer.isValid {
                timer.invalidate()
            }
        }
        Indicator.startAnimating()
        
        pings = ["192.168.4.3","192.168.4.4","192.168.4.5"]
        if stat_device {
            swipe_multi_check(stat:1)
        }
        else {
            swipe_multi_check(stat:0)
        }
    }
    
    func current_device_count() -> Int{
        var dev_count = 1
        
        while dev_count <= UserDefaults.standard.integer(forKey: "count") {
            if self.getWifissid() == UserDefaults.standard.string(forKey: "dev"+String(dev_count)) {
                return dev_count
            }
            dev_count += 1
        }
        return 0
    }
    func swipe_multi_check(stat:Int) -> Int{
        guard pings.count > 0 else {
            return 1
        }
        enable(stat: false)
        stat_device = false
        let ping = pings.removeFirst()
        print("ip : "+ping)
        PlainPing.ping(ping,withTimeout: 1, completionBlock: { (timeElapsed:Double?, error:Error?) in
            if let latency = timeElapsed {
                print(ping+"connect")
                connect_device[2-pings.count]=1
                if pings.count == 0 {
                    self.view_alpha(alpha: 1)
                    Indicator.stopAnimating()
                    for i in 0 ..< 3 {
                        if connect_device[i] == 1 {
                            stat_device = true
                        }
                    }
                    
                    if stat_device {
                        device_label.text = "Multi WiFi"
                        if let timer = mTimer {
                            if timer.isValid {
                                timer.invalidate()
                            }
                        }
                        self.remove_presetbtn_gesture()
                        stat_swipe = stat
                        self.multi_getdata(ip: String(1))
                        for i in 0 ..< 3 {
                            if connect_device[i] == 1 {
                                self.multi_getdata(ip: String(i+3))
                            }
                            else {
                                if i == 0 {
                                    p2btn.isHidden = true
                                    ch2label.isHidden = true
                                    cct2label.isHidden = true
                                    brt2label.isHidden = true
                                }
                                else if i == 1 {
                                    p3btn.isHidden = true
                                    ch3label.isHidden = true
                                    cct3label.isHidden = true
                                    brt3label.isHidden = true
                                }
                                else {
                                    p4btn.isHidden = true
                                    ch4label.isHidden = true
                                    cct4label.isHidden = true
                                    brt4label.isHidden = true
                                }
                            }
                        }
                    }
                    else {
                        mat = "Void"
                        stat_device = false
                        if mat_channel[0] == "Single" {
                            multi_slider.isHidden = true
                            multi_day_label.isHidden = true
                        }
                        else {
                            multi_slider.isHidden = true
                            multi_day_label.isHidden = true
                            p1btn.setAttributedTitle(NSAttributedString(string: "P1", attributes: preset_btn_design_gray), for: .normal)
                            p2btn.setAttributedTitle(NSAttributedString(string: "P2", attributes: preset_btn_design_gray), for: .normal)
                            p3btn.setAttributedTitle(NSAttributedString(string: "P3", attributes: preset_btn_design_gray), for: .normal)
                            p4btn.setAttributedTitle(NSAttributedString(string: "P4", attributes: preset_btn_design_gray), for: .normal)
                            
                            let longpress1 = UILongPressGestureRecognizer(target: self, action: #selector(self.Longclick_p1(recogizer:)))
                            longpress1.minimumPressDuration = 0.7
                            p1btn.addGestureRecognizer(longpress1)
                            let longpress2 = UILongPressGestureRecognizer(target: self, action: #selector(self.Longclick_p2(recogizer:)))
                            longpress2.minimumPressDuration = 0.7
                            p2btn.addGestureRecognizer(longpress2)
                            let longpress3 = UILongPressGestureRecognizer(target: self, action: #selector(self.Longclick_p3(recogizer:)))
                            longpress3.minimumPressDuration = 0.7
                            p3btn.addGestureRecognizer(longpress3)
                            let longpress4 = UILongPressGestureRecognizer(target: self, action: #selector(self.Longclick_p4(recogizer:)))
                            longpress4.minimumPressDuration = 0.7
                            p4btn.addGestureRecognizer(longpress4)
                            ch1label.text = "P1"
                            ch2label.text = "P2"
                            ch3label.text = "P3"
                            ch4label.text = "P4"
                            
                        }
                        if let timer = mTimer {
                            if !timer.isValid {
                                mTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.getdata), userInfo: nil, repeats: true)
                            }
                        }
                        else {
                            mTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.getdata), userInfo: nil, repeats: true)
                        }
                    }
                    self.enable(stat: true)
                    info.isEnabled = true
                    for v in self.view.subviews {
                        v.isUserInteractionEnabled = true
                    }
                }
            }
            if let error = error {
                print("error: \(error.localizedDescription)")
                connect_device[2-pings.count]=0
                if pings.count == 0 {
                    self.view_alpha(alpha: 1)
                    Indicator.stopAnimating()
                    for i in 0 ..< 3 {
                        if connect_device[i] == 1 {
                            stat_device = true
                        }
                    }
                    
                    if stat_device {
                        device_label.text = "Multi WiFi"
                        if let timer = mTimer {
                            if timer.isValid {
                                timer.invalidate()
                            }
                        }
                        self.remove_presetbtn_gesture()
                        stat_swipe = stat
                        self.multi_getdata(ip: String(1))
                        for i in 0 ..< 3 {
                            if connect_device[i] == 1 {
                                self.multi_getdata(ip: String(i+3))
                            }
                            else {
                                if i == 0 {
                                    p2btn.isHidden = true
                                    ch2label.isHidden = true
                                    cct2label.isHidden = true
                                    brt2label.isHidden = true
                                }
                                else if i == 1 {
                                    p3btn.isHidden = true
                                    ch3label.isHidden = true
                                    cct3label.isHidden = true
                                    brt3label.isHidden = true
                                }
                                else {
                                    p4btn.isHidden = true
                                    ch4label.isHidden = true
                                    cct4label.isHidden = true
                                    brt4label.isHidden = true
                                }
                            }
                        }
                        if stat_ch_btn[0] == 1 {
                            self.slider_getdata(ip: String(1))
                        }
                        else if stat_ch_btn[1] == 1 {
                            self.slider_getdata(ip: String(3))
                        }
                        else if stat_ch_btn[2] == 1 {
                            self.slider_getdata(ip: String(4))
                        }
                        else if stat_ch_btn[3] == 1 {
                            self.slider_getdata(ip: String(5))
                        }
                    }
                    else {
                        print("not multi")
                        mat = "Void"
                        stat_device = false
                        if mat_channel[0] == "Single" {
                            multi_slider.isHidden = true
                            multi_day_label.isHidden = true
                        }
                        else {
                            multi_slider.isHidden = true
                            multi_day_label.isHidden = true
                            p1btn.setAttributedTitle(NSAttributedString(string: "P1", attributes: preset_btn_design_gray), for: .normal)
                            p2btn.setAttributedTitle(NSAttributedString(string: "P2", attributes: preset_btn_design_gray), for: .normal)
                            p3btn.setAttributedTitle(NSAttributedString(string: "P3", attributes: preset_btn_design_gray), for: .normal)
                            p4btn.setAttributedTitle(NSAttributedString(string: "P4", attributes: preset_btn_design_gray), for: .normal)
                            
                            let longpress1 = UILongPressGestureRecognizer(target: self, action: #selector(self.Longclick_p1(recogizer:)))
                            longpress1.minimumPressDuration = 0.7
                            p1btn.addGestureRecognizer(longpress1)
                            let longpress2 = UILongPressGestureRecognizer(target: self, action: #selector(self.Longclick_p2(recogizer:)))
                            longpress2.minimumPressDuration = 0.7
                            p2btn.addGestureRecognizer(longpress2)
                            let longpress3 = UILongPressGestureRecognizer(target: self, action: #selector(self.Longclick_p3(recogizer:)))
                            longpress3.minimumPressDuration = 0.7
                            p3btn.addGestureRecognizer(longpress3)
                            let longpress4 = UILongPressGestureRecognizer(target: self, action: #selector(self.Longclick_p4(recogizer:)))
                            longpress4.minimumPressDuration = 0.7
                            p4btn.addGestureRecognizer(longpress4)
                            ch1label.text = "P1"
                            ch2label.text = "P2"
                            ch3label.text = "P3"
                            ch4label.text = "P4"
                            
                        }
                        if let timer = mTimer {
                            if !timer.isValid {
                                mTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.getdata), userInfo: nil, repeats: true)
                            }
                        }
                        else {
                            mTimer = Timer.scheduledTimer(timeInterval: 0.5, target: self, selector: #selector(self.getdata), userInfo: nil, repeats: true)
                        }
                    }
                    self.enable(stat: true)
                    info.isEnabled = true
                    for v in self.view.subviews {
                        v.isUserInteractionEnabled = true
                    }
                }
            }
            self.swipe_multi_check(stat:stat)
        })
        return 0
    }
    
    @objc func show_info(_ sender:UISwipeGestureRecognizer) {
        let current_device_number:Int = find_device_number(wifi_name: getWifissid() ?? "")
        if let timer = mTimer {
            if timer.isValid {
                timer.invalidate()
            }
        }
        swipe.isEnabled = false
        disapper.isEnabled = true
        enable(stat: false)
        let font_size:CGFloat = 33
        let interval:CGFloat = 15
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(mode_change(tapGestureRecognizer:)))
        
        function_background.frame = CGRect(x: 0, y: view.frame.height*6/7, width: view.frame.width/2, height: view.frame.height/7)
        function_background.backgroundColor = .black
        function_background.alpha = 0.9
        function_background.center.x -= function_background.frame.size.width
        function_background.layer.addBorder([.top], color: .white, width: 1)
        
        let change_mode = UIView(frame: CGRect(x: 0, y: 0, width: function_background.frame.width, height: function_background.frame.height/2))
        function_background.addSubview(change_mode)
        change_mode.isUserInteractionEnabled = true
        change_mode.addGestureRecognizer(tapGestureRecognizer)
        
        let change_mode_label = UILabel(frame: CGRect(x: function_background.frame.width/6, y: 0, width: change_mode.frame.width, height: change_mode.frame.height))
        change_mode_label.text = "Change Mode"
        change_mode_label.textColor = .white
        change_mode_label.font = UIFont.systemFont(ofSize: font_size)
        change_mode.addSubview(change_mode_label)
        
        let function_reset = UIButton(frame: CGRect(x: function_background.frame.width/6, y: change_mode.frame.maxY, width: function_background.frame.width, height: function_background.frame.height/2))
        
        function_reset.setTitle("Reset", for: .normal)
        function_reset.setTitleColor(UIColor(red:255/255,green:255/255,blue:255/255,alpha:1.0), for: .normal)
        function_reset.titleLabel?.font=UIFont.systemFont(ofSize: font_size)
        function_reset.addTarget(self, action: #selector(ipad_reset(_:)), for: .touchUpInside)
        function_reset.contentHorizontalAlignment = .left
        function_background.addSubview(function_reset)
        
        info_background.backgroundColor = .black
        info_background.alpha = 0.9
        info_background.frame = CGRect(x: 0, y: 00, width: view.frame.width/2, height: view.frame.height*6/7)
        info_background.center.x -= info_background.frame.size.width
        
        UIView.animate(withDuration: 0.4, animations: {info_background.center.x += info_background.frame.size.width
            function_background.center.x += function_background.frame.size.width
        })
        
        let header_of_info = UILabel(frame: CGRect(x: 0, y: info_background.frame.height/15, width: info_background.frame.width, height: 0))
        info_background.addSubview(header_of_info)
        header_of_info.text = "Connected Dimmers"
        header_of_info.textColor = .white
        header_of_info.font = UIFont.systemFont(ofSize: font_size)
        header_of_info.sizeToFit()
        let header_underline = UIView(frame: CGRect(x: 0, y: header_of_info.frame.maxY+3, width: header_of_info.frame.width, height: 3))
        info_background.addSubview(header_underline)
        header_underline.backgroundColor = .white
        
        let subheader_of_info1 = UILabel()
        subheader_of_info1.frame = CGRect(x: info_background.frame.width/16, y: header_underline.frame.maxY+25, width: info_background.frame.width, height: 0)
        subheader_of_info1.text = "Host Dimmer"
        subheader_of_info1.textColor = .white
        subheader_of_info1.font = UIFont.boldSystemFont(ofSize: font_size)
        subheader_of_info1.sizeToFit()
        
        info_background.addSubview(subheader_of_info1)
        let name_of_hostdimmer = UILabel(frame: CGRect(x: info_background.frame.width/6, y: subheader_of_info1.frame.maxY+5, width: info_background.frame.width-info_background.frame.width/6, height: 0))
        if UserDefaults.standard.integer(forKey: "dev"+String(current_device_number)+"mode") == 2 {
            name_of_hostdimmer.text = UserDefaults.standard.string(forKey: "dev"+String(current_device_number)+"master")
            name_of_hostdimmer.textColor = .white
        }
        else {
            name_of_hostdimmer.text = getWifissid()
            name_of_hostdimmer.textColor = .green
        }
        name_of_hostdimmer.font = UIFont.systemFont(ofSize: font_size)
        name_of_hostdimmer.lineBreakMode = .byCharWrapping
        name_of_hostdimmer.numberOfLines = 0
        name_of_hostdimmer.sizeToFit()
        info_background.addSubview(name_of_hostdimmer)
        
        let subheader_of_info2 = UILabel(frame: CGRect(x: info_background.frame.width/16, y: name_of_hostdimmer.frame.maxY+15, width: info_background.frame.width, height: 0))
        subheader_of_info2.text = "Client Dimmer(s)"
        subheader_of_info2.textColor = .white
        subheader_of_info2.font = UIFont.boldSystemFont(ofSize: font_size)
        subheader_of_info2.sizeToFit()
        info_background.addSubview(subheader_of_info2)
        
        if UserDefaults.standard.integer(forKey: "dev"+String(current_device_number)+"mode") == 0 {
            for i in 3 ..< 6 {
                let name_of_client = UILabel()
                if i == 3 {
                    name_of_client.frame = CGRect(x: info_background.frame.width/6, y: info_background.subviews[info_background.subviews.count-1].frame.maxY+5, width: info_background.frame.width-info_background.frame.width/6, height: 0)
                }
                else {
                    name_of_client.frame = CGRect(x: info_background.frame.width/6, y: info_background.subviews[info_background.subviews.count-1].frame.maxY+15, width: info_background.frame.width-info_background.frame.width/6, height: 0)
                }
                name_of_client.text = "None"
                name_of_client.textColor = .red
                name_of_client.font = UIFont.systemFont(ofSize: font_size)
                name_of_client.sizeToFit()
                info_background.addSubview(name_of_client)
            }
        }
        else if UserDefaults.standard.integer(forKey: "dev"+String(current_device_number)+"mode") == 1 {
            for i in 3 ..< 6 {
                let name_of_client = UILabel()
                if i == 3 {
                    name_of_client.frame = CGRect(x: info_background.frame.width/6, y: info_background.subviews[info_background.subviews.count-1].frame.maxY+5, width: info_background.frame.width-info_background.frame.width/6, height: 0)
                }
                else {
                    name_of_client.frame = CGRect(x: info_background.frame.width/6, y: info_background.subviews[info_background.subviews.count-1].frame.maxY+15, width: info_background.frame.width-info_background.frame.width/6, height: 0)
                }
                if UserDefaults.standard.integer(forKey: "dev"+String(current_device_number)+"client"+String(i)+"count") == 0 {
                    name_of_client.text = "None"
                    name_of_client.textColor = .red
                }
                else {
                    name_of_client.text = UserDefaults.standard.string(forKey: "dev"+String(current_device_number)+"client"+String(i))
                    name_of_client.textColor = .white
                }
                name_of_client.lineBreakMode = .byCharWrapping
                name_of_client.numberOfLines = 0
                name_of_client.font = UIFont.systemFont(ofSize: font_size)
                name_of_client.sizeToFit()
                info_background.addSubview(name_of_client)
            }
        }
        if UserDefaults.standard.integer(forKey: "dev"+String(current_device_number)+"mode") == 2 {
            for i in 3 ..< 6 {
                let name_of_client = UILabel()
                if i == 3 {
                    name_of_client.frame = CGRect(x: info_background.frame.width/6, y: info_background.subviews[info_background.subviews.count-1].frame.maxY+5, width: info_background.frame.width-info_background.frame.width/6, height: 0)
                }
                else {
                    name_of_client.frame = CGRect(x: info_background.frame.width/6, y: info_background.subviews[info_background.subviews.count-1].frame.maxY+15, width: info_background.frame.width-info_background.frame.width/6, height: 0)
                }
                if UserDefaults.standard.integer(forKey: "dev"+String(find_device_number(wifi_name: UserDefaults.standard.string(forKey: "dev"+String(current_device_number)+"master") ?? ""))+"client"+String(i)+"count") == 0 {
                    name_of_client.text = "None"
                    name_of_client.textColor = .red
                }
                else {
                    name_of_client.text = UserDefaults.standard.string(forKey: "dev"+String(find_device_number(wifi_name: UserDefaults.standard.string(forKey: "dev"+String(current_device_number)+"master") ?? ""))+"client"+String(i))
                    if name_of_client.text == getWifissid() {
                        name_of_client.textColor = .green
                    }
                    else {
                        name_of_client.textColor = .white
                    }
                }
                name_of_client.lineBreakMode = .byCharWrapping
                name_of_client.numberOfLines = 0
                name_of_client.font = UIFont.systemFont(ofSize: font_size)
                name_of_client.sizeToFit()
                info_background.addSubview(name_of_client)
            }
        }
        /*
         let window = UIApplication.shared.keyWindow
         var subview_count:Int = 0
         var master_device:[String] = []
         for i in 1 ..< (UserDefaults.standard.integer(forKey: "count")+1) {
         if let nil_check = UserDefaults.standard.string(forKey: "dev"+String(i)) {
         if  UserDefaults.standard.integer(forKey: "dev"+String(i)+"mode") != 2 {
         master_device.append(nil_check)
         //master_device = [dimmer1,dimmer4]
         }
         }
         }
         for i in 0 ..< master_device.count {
         if UserDefaults.standard.integer(forKey: "dev"+String(self.find_device_number(wifi_name: master_device[i]))+"mode") == 0 {
         
         let list_device_label = UILabel()
         list_device_label.frame = CGRect(x: 0, y: info_background.subviews[subview_count].frame.maxY+interval, width: info_background.frame.width, height: font_size)
         list_device_label.text = master_device[i]
         list_device_label.textColor = .white
         list_device_label.font = UIFont.boldSystemFont(ofSize: font_size)
         list_device_label.tag = self.find_device_number(wifi_name: master_device[i])
         list_device_label.layer.borderColor = UIColor.white.cgColor
         list_device_label.lineBreakMode = .byCharWrapping
         list_device_label.numberOfLines = 0
         list_device_label.sizeToFit()
         if list_device_label.text == getWifissid() {
         list_device_label.textColor = .green
         }
         let info_device = UITapGestureRecognizer(target: self, action: #selector(enter_device_information(tapGestureRecognizer:)))
         list_device_label.isUserInteractionEnabled = true
         list_device_label.addGestureRecognizer(info_device)
         info_background.addSubview(list_device_label)
         
         subview_count += 1
         }
         else {
         let list_device_label1 = UILabel()
         list_device_label1.frame = CGRect(x: 0, y: Int(info_background.subviews[subview_count].frame.maxY+interval), width: Int(info_background.frame.width), height: Int(font_size))
         list_device_label1.text = master_device[i]
         list_device_label1.textColor = .white
         list_device_label1.font = UIFont.boldSystemFont(ofSize: font_size)
         list_device_label1.tag = self.find_device_number(wifi_name: master_device[i])
         list_device_label1.layer.borderColor = UIColor.white.cgColor
         list_device_label1.lineBreakMode = .byCharWrapping
         list_device_label1.numberOfLines = 0
         list_device_label1.sizeToFit()
         if list_device_label1.text == getWifissid() {
         list_device_label1.textColor = .green
         }
         let info_device = UITapGestureRecognizer(target: self, action: #selector(enter_device_information(tapGestureRecognizer:)))
         list_device_label1.isUserInteractionEnabled = true
         list_device_label1.addGestureRecognizer(info_device)
         info_background.addSubview(list_device_label1)
         subview_count += 1
         for j in 3 ..< 6 {
         if UserDefaults.standard.integer(forKey: "dev"+String(self.find_device_number(wifi_name: master_device[i]))+"client"+String(j)+"count") == 1 {
         print("OK")
         let list_device_label = UILabel()
         list_device_label.frame = CGRect(x: 20, y: info_background.subviews[subview_count].frame.maxY+interval, width: info_background.frame.width, height: font_size)
         switch j {
         case 3:list_device_label.text = "Ch2:"
         case 4:list_device_label.text = "Ch3:"
         case 5:list_device_label.text = "Ch4:"
         default:break
         }
         list_device_label.text?.append(UserDefaults.standard.string(forKey: "dev"+String(self.find_device_number(wifi_name: master_device[i]))+"client"+String(j))!)
         list_device_label.textColor = .white
         list_device_label.font = UIFont.boldSystemFont(ofSize: font_size)
         list_device_label.tag = self.find_device_number(wifi_name: UserDefaults.standard.string(forKey: "dev"+String(self.find_device_number(wifi_name: master_device[i]))+"client"+String(j))!)
         list_device_label.layer.borderColor = UIColor.white.cgColor
         list_device_label.lineBreakMode = .byCharWrapping
         list_device_label.numberOfLines = 0
         list_device_label.sizeToFit()
         if UserDefaults.standard.string(forKey: "dev"+String(self.find_device_number(wifi_name: master_device[i]))+"client"+String(j)) == getWifissid() {
         list_device_label.textColor = .green
         }
         let info_device = UITapGestureRecognizer(target: self, action: #selector(enter_device_information(tapGestureRecognizer:)))
         list_device_label.isUserInteractionEnabled = true
         list_device_label.addGestureRecognizer(info_device)
         info_background.addSubview(list_device_label)
         
         subview_count += 1
         }
         }
         }
         }
         */
        view.addSubview(function_background)
        view.addSubview(info_background)
    }
    @objc func disappear_info(_ sender:UISwipeGestureRecognizer) {
        if stat_alert == 0 {
            swipe.isEnabled = true
            UIView.animate(withDuration: 0.4, animations: {info_background.center.x -= info_background.frame.size.width
                function_background.center.x -= function_background.frame.size.width
            }, completion: {(a) in
                if !stat_device {
                    if let timer = mTimer {
                        if !timer.isValid {
                            mTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.getdata), userInfo: nil, repeats: true)
                        }
                    }
                    else {
                        mTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.getdata), userInfo: nil, repeats: true)
                    }
                }
                for v in info_background.subviews {
                    v.removeFromSuperview()
                }
                self.enable(stat: true)
                disapper.isEnabled = false})
        }
    }
    func enable(stat:Bool) {
        p1btn.isEnabled = stat
        p2btn.isEnabled = stat
        p3btn.isEnabled = stat
        p4btn.isEnabled = stat
        
        cctslider.isEnabled = stat
        brtslider.isEnabled = stat
        
        slider.isEnabled = stat
        multi_slider.isEnabled = stat
    }
    
    @objc func enter_device_information(tapGestureRecognizer: UITapGestureRecognizer){
        info_device_num = tapGestureRecognizer.view!.tag
        
        information_view.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        information_view.backgroundColor = .black
        view.addSubview(information_view)
        
        let info_title = UILabel()
        let device_name_label = UILabel()
        let device_name = UILabel()
        let device_password_label = UILabel()
        let device_password = UILabel()
        
        let master_device = UILabel()
        let slave_device1 = UILabel()
        let slave_device2 = UILabel()
        let slave_device3 = UILabel()
        
        let stat_mode = UILabel()
        let stat_mode_label = UILabel()
        
        let line_to_ch0 = UIBezierPath()
        let line_to_ch1 = UIBezierPath()
        let line_to_ch2 = UIBezierPath()
        let line_to_ch3 = UIBezierPath()
        
        let shape0 = CAShapeLayer()
        let shape1 = CAShapeLayer()
        let shape2 = CAShapeLayer()
        let shape3 = CAShapeLayer()
        
        let title_font_size:CGFloat = 50
        let title_interval:CGFloat = 80
        let font_size:CGFloat = 35
        let interval:CGFloat = 35
        let slave_font_size:CGFloat = 30
        let line1:CGFloat = 60
        let return_font_size:CGFloat = 50
        
        information_view.addSubview(info_title)
        information_view.addSubview(device_name_label)
        information_view.addSubview(device_name)
        information_view.addSubview(device_password_label)
        information_view.addSubview(device_password)
        information_view.addSubview(master_device)
        information_view.addSubview(slave_device1)
        information_view.addSubview(slave_device2)
        information_view.addSubview(slave_device3)
        information_view.addSubview(stat_mode)
        information_view.addSubview(stat_mode_label)
        
        info_title.frame = CGRect(x: 0, y: window?.safeAreaInsets.top ?? 0, width: view.frame.width, height: title_font_size)
        info_title.text = "Device Information"
        info_title.font = UIFont.boldSystemFont(ofSize: title_font_size)
        info_title.textColor = .white
        info_title.textAlignment = .center
        
        
        device_name_label.frame = CGRect(x: 0, y: info_title.frame.maxY+title_interval, width: 0, height: font_size)
        device_name_label.text = "Device Name : "
        device_name_label.font = UIFont.systemFont(ofSize: font_size)
        device_name_label.textColor = .white
        device_name_label.sizeToFit()
        
        device_name.frame = CGRect(x: device_name_label.frame.maxX, y: info_title.frame.maxY+title_interval, width: view.frame.width-device_name_label.frame.width, height: font_size)
        device_name.text = UserDefaults.standard.string(forKey: "dev"+String(info_device_num))
        device_name.textColor = .white
        device_name.font = UIFont.systemFont(ofSize: font_size)
        device_name.lineBreakMode = .byCharWrapping
        device_name.numberOfLines = 0
        device_name.sizeToFit()
        
        device_password_label.frame = CGRect(x: 0, y: device_name.frame.maxY+interval, width: 0, height: font_size)
        device_password_label.text = "Device Password : "
        device_password_label.textColor = .white
        device_password_label.font = UIFont.systemFont(ofSize: font_size)
        device_password_label.sizeToFit()
        
        device_password.frame = CGRect(x: device_password_label.frame.maxX, y: device_name.frame.maxY+interval, width: view.frame.width-device_password_label.frame.width, height: font_size)
        device_password.text = UserDefaults.standard.string(forKey: "dev"+String(info_device_num)+"password")
        device_password.textColor = .white
        device_password.font = UIFont.systemFont(ofSize: font_size)
        device_password.lineBreakMode = .byCharWrapping
        device_password.numberOfLines = 0
        device_password.sizeToFit()
        
        stat_mode_label.frame = CGRect(x: 0, y: device_password.frame.maxY+interval, width: 0, height: font_size)
        stat_mode_label.text = "Mode : "
        stat_mode_label.textColor = .white
        stat_mode_label.font = UIFont.systemFont(ofSize: font_size)
        stat_mode_label.sizeToFit()
        
        stat_mode.frame = CGRect(x: stat_mode_label.frame.maxX, y: device_password.frame.maxY+interval, width: view.frame.width-stat_mode_label.frame.width, height: font_size)
        if UserDefaults.standard.integer(forKey: "dev"+String(info_device_num)+"mode") == 2 {
            stat_mode.text = "Client"
        }
        else {
            stat_mode.text = "Host"
        }
        stat_mode.textColor = .white
        stat_mode.font = UIFont.systemFont(ofSize: font_size)
        
        master_device.frame = CGRect(x: 0, y: stat_mode_label.frame.maxY+40, width: view.frame.width, height: 50)
        if UserDefaults.standard.integer(forKey: "dev"+String(info_device_num)+"mode") == 2 {
            master_device.text = UserDefaults.standard.string(forKey: "dev"+String(info_device_num)+"master")
        }
        else {
            master_device.text = UserDefaults.standard.string(forKey: "dev"+String(info_device_num))
        }
        master_device.textColor = .white
        master_device.textAlignment = .center
        master_device.font = UIFont.systemFont(ofSize: font_size)
        master_device.lineBreakMode = .byCharWrapping
        master_device.numberOfLines = 0
        
        line_to_ch0.move(to: CGPoint(x: master_device.center.x, y: master_device.frame.maxY))
        line_to_ch0.addLine(to: CGPoint(x: master_device.center.x, y: master_device.frame.maxY+line1))
        
        shape0.path = line_to_ch0.cgPath
        shape0.strokeColor = UIColor.red.cgColor
        shape0.lineWidth = 2
        
        line_to_ch1.move(to: CGPoint(x: master_device.center.x, y: master_device.frame.maxY+line1))
        line_to_ch1.addLine(to: CGPoint(x: (view.frame.width/3)-view.frame.width/6, y: master_device.frame.maxY+line1))
        line_to_ch1.addLine(to: CGPoint(x: (view.frame.width/3)-view.frame.width/6, y: master_device.frame.maxY+line1*3))
        
        shape1.path = line_to_ch1.cgPath
        shape1.lineWidth = 2
        
        line_to_ch2.move(to: CGPoint(x: master_device.center.x, y: master_device.frame.maxY+line1))
        line_to_ch2.addLine(to: CGPoint(x: (view.frame.width*2/3)-view.frame.width/6, y: master_device.frame.maxY+line1*3))
        
        shape2.path = line_to_ch2.cgPath
        shape2.lineWidth = 2
        
        line_to_ch3.move(to: CGPoint(x: master_device.center.x, y: master_device.frame.maxY+line1))
        line_to_ch3.addLine(to: CGPoint(x: (view.frame.width)-view.frame.width/6, y: master_device.frame.maxY+line1))
        line_to_ch3.addLine(to: CGPoint(x: (view.frame.width)-view.frame.width/6, y: master_device.frame.maxY+line1*3))
        
        shape3.path = line_to_ch3.cgPath
        shape3.lineWidth = 2
        
        slave_device1.frame  = CGRect(x: 0, y: master_device.frame.maxY+line1*3, width: view.frame.width/3, height: slave_font_size*2.5)
        slave_device1.text = "None"
        slave_device1.textColor = .white
        slave_device1.font = UIFont.systemFont(ofSize: slave_font_size)
        slave_device1.textAlignment = .center
        slave_device1.lineBreakMode = .byCharWrapping
        slave_device1.numberOfLines = 0
        
        slave_device2.frame  = CGRect(x: view.frame.width/3, y: master_device.frame.maxY+line1*3, width: view.frame.width/3, height: slave_font_size*2.5)
        slave_device2.text = "None"
        slave_device2.textColor = .white
        slave_device2.font = UIFont.systemFont(ofSize: slave_font_size)
        slave_device2.textAlignment = .center
        slave_device2.lineBreakMode = .byCharWrapping
        slave_device2.numberOfLines = 0
        
        slave_device3.frame  = CGRect(x: view.frame.width*2/3, y: master_device.frame.maxY+line1*3, width: view.frame.width/3, height: slave_font_size*2.5)
        slave_device3.text = "None"
        slave_device3.textColor = .white
        slave_device3.font = UIFont.systemFont(ofSize: slave_font_size)
        slave_device3.textAlignment = .center
        slave_device3.lineBreakMode = .byCharWrapping
        slave_device3.numberOfLines = 0
        
        if UserDefaults.standard.integer(forKey: "dev"+String(info_device_num)+"mode") != 2 {
            if UserDefaults.standard.integer(forKey: "dev"+String(info_device_num)+"client3count") == 1 {
                slave_device1.text = UserDefaults.standard.string(forKey: "dev"+String(info_device_num)+"client3")
                slave_device1.textColor = .green
                shape0.strokeColor = UIColor.green.cgColor
                shape1.strokeColor = UIColor.green.cgColor
            }
            else {
                slave_device1.text = "None"
                slave_device1.textColor = .red
                shape1.strokeColor = UIColor.red.cgColor
            }
            if UserDefaults.standard.integer(forKey: "dev"+String(info_device_num)+"client4count") == 1 {
                slave_device2.text = UserDefaults.standard.string(forKey: "dev"+String(info_device_num)+"client4")
                slave_device2.textColor = .green
                shape0.strokeColor = UIColor.green.cgColor
                shape2.strokeColor = UIColor.green.cgColor
            }
            else {
                slave_device2.text = "None"
                slave_device2.textColor = .red
                shape2.strokeColor = UIColor.red.cgColor
                
            }
            if UserDefaults.standard.integer(forKey: "dev"+String(info_device_num)+"client5count") == 1 {
                slave_device3.text = UserDefaults.standard.string(forKey: "dev"+String(info_device_num)+"client5")
                slave_device3.textColor = .green
                shape0.strokeColor = UIColor.green.cgColor
                shape3.strokeColor = UIColor.green.cgColor
            }
            else {
                slave_device3.text = "None"
                slave_device3.textColor = .red
                shape3.strokeColor = UIColor.red.cgColor
            }
            information_view.layer.addSublayer(shape0)
            information_view.layer.addSublayer(shape1)
            information_view.layer.addSublayer(shape2)
            information_view.layer.addSublayer(shape3)
        }
        else {
            
            slave_device1.text = ""
            slave_device2.text = UserDefaults.standard.string(forKey: "dev"+String(info_device_num))
            slave_device3.text = ""
            shape0.borderColor = UIColor.white.cgColor
            shape0.borderWidth = 2
            shape2.strokeColor = UIColor.red.cgColor
            information_view.layer.addSublayer(shape2)
            information_view.layer.addSublayer(shape0)
        }
        
        let return_btn = UIButton()
        information_view.addSubview(return_btn)
        return_btn.translatesAutoresizingMaskIntoConstraints = false
        return_btn.bottomAnchor.constraint(equalTo:information_view.bottomAnchor, constant : -30).isActive = true
        return_btn.rightAnchor.constraint(equalTo:information_view.rightAnchor, constant:-20).isActive = true
        return_btn.setTitle("Return", for: .normal)
        return_btn.setTitleColor(UIColor.white, for: .normal)
        return_btn.titleLabel?.font=UIFont(name:"HelveticaNeue-Bold",size:return_font_size)
        return_btn.addTarget(self, action: #selector(return_information(_:)), for: .touchUpInside)
    }

    @objc func return_information(_ sender: Any) {
        for v in information_view.subviews {
            v.removeFromSuperview()
        }
        information_view.layer.sublayers = nil
        information_view.removeFromSuperview()
    }
    func view_alpha(alpha:CGFloat) {
        deviceimage.alpha = alpha
        westcottimage.alpha = alpha
        p1btn.alpha = alpha
        p2btn.alpha = alpha
        p3btn.alpha = alpha
        p4btn.alpha = alpha
        ch1label.alpha = alpha
        cct1label.alpha = alpha
        brt1label.alpha = alpha
        ch2label.alpha = alpha
        cct2label.alpha = alpha
        brt2label.alpha = alpha
        ch3label.alpha = alpha
        cct3label.alpha = alpha
        brt3label.alpha = alpha
        ch4label.alpha = alpha
        cct4label.alpha = alpha
        brt4label.alpha = alpha
        reset_btn.alpha = alpha
        cctslider.alpha = alpha
        cctlabel.alpha = alpha
        brtlabel.alpha = alpha
        brtslider.alpha = alpha
        slider.alpha = alpha
        day_label.alpha = alpha
        multi_slider.alpha = alpha
        multi_day_label.alpha = alpha
        device_label.alpha = alpha
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let Thetouches = touches.first {
            let point = Thetouches.location(in: view)
            if stat_alert == 0 {
                if disapper.isEnabled {
                    if point.x > view.center.x {
                        UIView.animate(withDuration: 0.4, animations: {info_background.center.x -= info_background.frame.size.width
                            function_background.center.x -= function_background.frame.size.width
                        }, completion: {(a) in
                            if !stat_device {
                                if let timer = mTimer {
                                    if !timer.isValid {
                                        mTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.getdata), userInfo: nil, repeats: true)
                                    }
                                }
                                else {
                                    mTimer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.getdata), userInfo: nil, repeats: true)
                                }
                            }
                            for v in info_background.subviews {
                                v.removeFromSuperview()
                            }
                            swipe.isEnabled = true
                            self.enable(stat: true)
                            disapper.isEnabled = false})
                    }
                }
            }
        }
    }
    @objc func ipad_reset(_ sender: Any){
        if stat_device {
            create_alert(mode:"Error",stat_textfield: true, title: "Reset error", title_font: 30, text: "Reset is not possible in multi wifi", text_font: 25)
        }
        else {
            if UserDefaults.standard.integer(forKey: "dev"+String(device_count)+"mode") == 1 {
                create_alert(mode:"Error",stat_textfield: true, title: "Reset error", title_font: 30, text: "Reset is not possible because another dimmer is connected", text_font: 25)
            }
            else if UserDefaults.standard.integer(forKey: "dev"+String(device_count)+"mode") == 2 {
                create_alert(mode:"Error",stat_textfield: true, title: "Reset error", title_font: 30, text: "Reset is not possible because current dimmer is connected at another dimmer", text_font: 25)
            }
            else {
                create_alert(mode:"Reset",stat_textfield: true, title: "Reset", title_font: 30, text: "Are you sure you want to reset the WiFi", text_font: 25)
            }
        }
    }
    @objc func reset_selector(_ sender:Any) {
        stat_alert = 0
        for v in info_background.subviews {
            v.isUserInteractionEnabled = true
        }
        for v in function_background.subviews {
            v.isUserInteractionEnabled = true
        }
        self.enable(stat: true)
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
        UIView.animate(withDuration: 0.2, animations: {alert_view.alpha = 0
            for v in self.view.subviews {
                if v != self.view.subviews[self.view.subviews.endIndex-1] {
                    v.alpha = 1
                }
            }
        }, completion: {(complete:Bool) in for v in alert_view.subviews {
            v.removeFromSuperview()
            }
            alert_view.removeFromSuperview()
        })
    }
}
