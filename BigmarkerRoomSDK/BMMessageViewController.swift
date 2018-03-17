//
//  BMMessageViewController.swift
//  BigmarkerRoomSDK
//
//  Created by Han Qing on 12/3/2018.
//  Copyright © 2018 bigmarker. All rights reserved.
//

import UIKit

class BMMessageViewController: UIViewController {
    
    var conference: Conference!
    
    init(frame: CGRect) {
        super.init(nibName: nil, bundle: nil)
        self.view.frame = frame
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy private var navView : BMNavView = { [weak self] in
        let navView = BMNavView(frame: CGRect(x: 0, y: 0, width: self!.view.frame.width, height: 64), conference: self!.conference)
        //navView.delegate = self as! BMNavViewDelegate?
        return navView
        }()
    


    override func viewDidLoad() {
        super.viewDidLoad()
        //self.view.addSubview(self.navView)
        
        let image = UIImage(named: "icon_chat_active")?.withRenderingMode(.alwaysOriginal)
        let selectedImage = UIImage(named: "icon_chat_active")?.withRenderingMode(.alwaysOriginal)
        
        // 声明新的无标题TabBarItem
        let tabBarItem = UITabBarItem(title: nil, image: image, selectedImage: selectedImage)
        // 设置 tabBarItem 的 imageInsets 可以使图标居中显示
        tabBarItem.imageInsets = UIEdgeInsetsMake(6, 0, -6, 0)
        
        self.tabBarItem = tabBarItem
        

        
   
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}
