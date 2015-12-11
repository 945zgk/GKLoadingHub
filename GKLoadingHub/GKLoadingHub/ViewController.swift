//
//  ViewController.swift
//  GKLoadingHub
//
//  Created by 做功课 on 15/12/12.
//  Copyright (c) 2015年 做功课. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let loadingHubView = GKLoadingHubView(frame: CGRect(x: 100, y: 100, width: 100, height: 100))
        
        self.view.addSubview(loadingHubView)
        
        loadingHubView.showHub()
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

