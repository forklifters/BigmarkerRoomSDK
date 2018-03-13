//
//  BMNavView.swift
//  bigmarker
//
//  Created by Han Qing on 2/12/2017.
//  Copyright © 2017 hanqing. All rights reserved.
//
@objc protocol BMNavViewDelegate{
    @objc optional func quiteRoomNotification()
}

import UIKit
class BMNavView: UIView {
    
    var titleLabel: UILabel?
    var settingButton: UIButton?
    var conference:  Conference?
    var delegate: BMNavViewDelegate?
    

    
    init(frame: CGRect, conference: Conference?) {
        super.init(frame: frame)
        self.frame = frame
        self.conference = conference
        self.backgroundColor = UIColor(red: 38/255, green: 48/255, blue: 68/255, alpha: 1)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI(){
        self.titleLabel = UILabel.init(frame: CGRect.init(x: 15, y: 27, width: 230, height: 24))
        self.titleLabel?.textColor = UIColor.white
        self.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        self.titleLabel?.text = "1111"//self.conference?.channel?.name
        self.titleLabel?.minimumScaleFactor = 0.5
        self.titleLabel?.baselineAdjustment = UIBaselineAdjustment.alignCenters
        self.titleLabel?.adjustsFontSizeToFitWidth = true
        self.addSubview(titleLabel!)
        let x = UIScreen.main.bounds.width - 40
        let settingButton = UIButton(frame: CGRect(x: x, y: 25, width: 30, height: 30))
        settingButton.setImage(UIImage(named: "setting"), for: UIControlState.normal)
        settingButton.addTarget(self, action: #selector(clickButton), for: .touchUpInside)
        
        
        self.addSubview(settingButton)

    }
    
    func clickButton(sender: AnyObject){
//        let action = PopoverAction.init(image: UIImage.init(named: "icon-leave"), title: "Leave webinar", handler: {action in
//            self.delegate?.quiteRoomNotification!()
//        })
//
//
//        let view = PopoverView()
//        view.style = PopoverViewStyle.Default
//        view.showShade = true
//        view.showToView(sender as! UIView, withActions: [action])
    }
    
}
