//
//  BigRoomMessageController.swift
//  bigmarker
//
//  Created by Han Qing on 12/19/16.
//  Copyright © 2016 hanqing. All rights reserved.
//

import UIKit
import BMroomSDK

struct PeopleMessage {
    static var chatCount = "0"
    static var totalMessages: [Message]  = []
    static var bigTotalMessages : [Message] = []
    static var pollCount = "0"
}


class BMMessageController:  UIViewController {
    
    var conference: Conference!
    var bm:BMRoom!
    var peopleController: BMPeopleViewController!
    var chatController: BMChatListViewController!
    
    lazy  var scrollView : UIScrollView = { [weak self] in
        let scrollViewHeight = (self?.view.frame.height)! - (self?.navView.frame.height)! - (self?.segmentView.frame.height)!
        
       
        let scrollView = UIScrollView(frame: CGRect(x: 0, y: (self?.navView.frame.height)! + (self?.segmentView.frame.height)!, width:(self?.view.frame.width)!, height: scrollViewHeight))
        scrollView.delegate = self
        
        self?.automaticallyAdjustsScrollViewInsets = false
        scrollView.isUserInteractionEnabled = true
        
        return scrollView
        }()
    
    lazy  var navView : BMNavView = { [weak self] in
        let navView = BMNavView(frame: CGRect(x: 0, y: 0, width: self!.view.frame.width, height: 64), conference: self!.conference)
        navView.delegate = self
        return navView
        }()
    
    
    lazy  var segmentView : SegmentedView = { [weak self] in
        let segmentY = (self?.navView.frame.origin.y)! + (self?.navView.frame.height)!
        let segmentView = SegmentedView(frame: CGRect(x: 0, y: segmentY, width: (self?.view.frame.width)!, height: 40))
        segmentView.switchSegmentDelegate = self
        return segmentView
        }()
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
//        if let youtubeView = self.tabBarController?.view.viewWithTag(100) as? YouTubeVideoView {
//            youtubeView.hidden = true
//        }
        //显示chat的badge通知
//        NotificationCenter.default.addObserver(self, selector: #selector(BMMessageController.chatBadgeCount), name: NSNotification.Name(rawValue: "chatBadgeCount"), object: nil)
//        //显示people的badge改变的通知
//        NotificationCenter.default.addObserver(self, selector: #selector(BMMessageController.changePeopleMessageCount), name: NSNotification.Name(rawValue: "peopleMessageChange"), object: nil)
//        //修改投票数
//        NotificationCenter.default.addObserver(self, selector: #selector(BMMessageController.changePollCount), name: NSNotification.Name(rawValue: "changePollCount"), object: nil)
//        //QA
//        NotificationCenter.default.addObserver(self, selector: #selector(BMMessageController.changeQA), name: NSNotification.Name(rawValue: "changeQA"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
//        if let youtubeView = self.tabBarController?.view.viewWithTag(100) as? YouTubeVideoView {
//            youtubeView.hidden = false
//        }
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "chatBadgeCount"), object: nil)
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "peopleMessageChange"), object: nil)
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "changePollCount"), object: nil)
//        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "changeQA"), object: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        clearBadgeValue()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
    func setupUI(){
        self.view.addSubview(self.navView)
        self.view.addSubview(self.segmentView)
        self.view.addSubview(self.scrollView)
        
        let y = self.navView.frame.height + self.segmentView.frame.height
        let h = ScreenH - self.navView.frame.height - self.segmentView.frame.height - TabbarH
        let frame = CGRect(x: 0, y: y, width: ScreenW, height: h)
  
        self.chatController = BMChatListViewController.init(frame: frame, bm: self.bm, conference: self.conference)
        self.addChildViewController(chatController)
        
        self.peopleController = BMPeopleViewController.init(frame: frame, bm: self.bm, conference: self.conference)
        self.addChildViewController(peopleController)
        
        let count = self.childViewControllers.count
        let contentH = self.scrollView.bounds.size.height
        
        for i in 0..<count {
            let vc: UIViewController = self.childViewControllers[i]
            vc.view.frame = CGRect(x: CGFloat(i) * ScreenW, y: 0, width: ScreenW, height: contentH)
            self.scrollView.addSubview(vc.view)
        }
        
        //设置内容滚动区的范围
        self.scrollView.contentSize = CGSize.init(width: ScreenW * CGFloat(count), height: 0)
        self.scrollView.showsHorizontalScrollIndicator = false
        self.scrollView.isPagingEnabled = true
    }
    
    func clearBadgeValue(){
        //self.tabBarController?.tabBar.items![1].badgeValue = nil
        (self.tabBarController as! BMTabBarController).removeBadge()
    }
    

}

extension BMMessageController: BMNavViewDelegate, BigRoomChatDelegate{
    
     func bigRoomNotificationDelegateMsgAdd(message: [NSObject : AnyObject]){
        self.chatController.msgAdd(message: message)
    }
     func bigRoomNotificationDelegateMsgDel(message: [NSObject : AnyObject]){
        self.chatController.msgDel(message: message)
    }
     func bigRoomNotificationDelegateMsgLoad(messages: [NSObject : AnyObject]){
        self.chatController.msgLoad(messages: messages)
    }
     func bigRoomNotificationDelegateMsgLock(status: Int){
        self.chatController.msgLock(status: status)
    }
     func bigRoomNotificationDelegateMsgChangeRole(status: Int){
        self.chatController.changeRole(status: status)
    }
    
    
    func quiteRoomNotification() {
        let vc = self.tabBarController?.viewControllers![0] as? BMVideoViewController
        vc!.quiteRoom()
    }
}

extension BMMessageController: UIScrollViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let x: CGFloat = scrollView.contentOffset.x
        let w: CGFloat = self.view.frame.width
        let page = x/w
        self.segmentView.segmentedControl.selectedSegmentIndex = Int(page)
    }
}

extension BMMessageController: SwitchSegmentNotification{
    func notifySwitchSegment(index: Int) {
        self.scrollView.setContentOffset(CGPoint(x: CGFloat(index) * self.view.frame.width, y: self.scrollView.bounds.origin.y), animated: false)
    }
}


