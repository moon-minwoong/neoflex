//
//  deivce_information.swift
//  mydream
//
//  Created by 문민웅 on 2019. 1. 7..
//  Copyright © 2019년 moon. All rights reserved.
//

import Foundation
import UIKit

class device_information:UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    
        UIApplication.shared.statusBarView?.backgroundColor = UIColor.white
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .black
        

    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

