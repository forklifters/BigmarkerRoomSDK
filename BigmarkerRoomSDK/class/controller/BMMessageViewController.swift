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


class BMMessageController:  WMPageController {
    
    var conference: Conference!
    
//    let bigRoomPollsViewController = BigRoomPollsViewController()
//    let bigRoomQAViewController = BigRoomQAViewController()
    var bm:BMRoom!
    //    var gobackView : UIView!
    
    lazy  var navView : BMNavView = { [weak self] in
        let navView = BMNavView(frame: CGRect(x: 0, y: 0, width: self!.view.frame.width, height: 64), conference: self!.conference)
        navView.delegate = self
        return navView
        }()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        if let youtubeView = self.tabBarController?.view.viewWithTag(100) as? YouTubeVideoView {
            youtubeView.isHidden = true
        }
        //显示chat的badge通知
        NotificationCenter.default.addObserver(self, selector: #selector(BMMessageController.chatBadgeCount), name: NSNotification.Name(rawValue: "chatBadgeCount"), object: nil)
        //显示people的badge改变的通知
        NotificationCenter.default.addObserver(self, selector: #selector(BMMessageController.changePeopleMessageCount), name: NSNotification.Name(rawValue: "peopleMessageChange"), object: nil)
        //修改投票数
        NotificationCenter.default.addObserver(self, selector: #selector(BMMessageController.changePollCount), name: NSNotification.Name(rawValue: "changePollCount"), object: nil)
        //QA
        NotificationCenter.default.addObserver(self, selector: #selector(BMMessageController.changeQA), name: NSNotification.Name(rawValue: "changeQA"), object: nil)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        if let youtubeView = self.tabBarController?.view.viewWithTag(100) as? YouTubeVideoView {
            youtubeView.isHidden = false
        }
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "chatBadgeCount"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "peopleMessageChange"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "changePollCount"), object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name(rawValue: "changeQA"), object: nil)
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        clearBadgeValue()
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(navView)
        
        //        self.gobackView = UIView.init(frame:navView.gobackButton.frame)
        //        let tap = UITapGestureRecognizer(target: self, action: #selector(BigRoomMessageController.quiteRoom))
        //        self.gobackView.addGestureRecognizer(tap)
        //        self.view.addSubview(self.gobackView)
        
        self.menuView?.item(at: 0).numberLabel.isHidden = true
        self.menuView?.item(at: 0).numberLabel.text = "0"
        self.menuView?.item(at: 3).numberLabel.isHidden = true
        self.viewFrame = CGRect(x: 0, y: navView.frame.size.height, width: ScreenW, height: ScreenH)

        if PeopleMessage.totalMessages.count == 0 {
            self.menuView?.item(at: 1).numberLabel.isHidden = true
        }else{
            self.menuView?.item(at: 1).numberLabel.isHidden = false
            self.menuView?.item(at: 1).numberLabel.text = ""
        }
        
        if PeopleMessage.pollCount == "0" {
            
            self.menuView?.item(at: 2).numberLabel.isHidden = true
        }else{
            self.menuView?.item(at: 2).numberLabel.isHidden = false
            //self.menuView?.itemAtIndex(2).numberLabel.text = PeopleMessage.pollCount
            self.menuView?.item(at: 2).numberLabel.text = ""
        }
        
        self.delegate = self
    }
    
    
    private func clearBadgeValue(){
         (self.tabBarController as! BMTabBarController).removeBadge()
    }
    
    
    override func numbersOfChildControllers(in pageController: WMPageController) -> Int {
        self.menuViewStyle = WMMenuViewStyle.line;
        self.titleSizeSelected = 15;
        self.titleSizeNormal = 13;
        self.menuHeight = 50
        //self.titleFontName = SFUIDisplay_Bold
        self.showOnNavigationBar = false;
        self.menuBGColor = UIColor.clear
        self.titleColorNormal = UIColor(red: 162/255.0, green: 171/255.0, blue: 187/255.0, alpha: 1.0)
        self.titleColorSelected = UIColor(red: 43/255.0, green: 55/255.0, blue: 77/255.0, alpha: 1.0)
        self.progressColor = UIColor(red: 16/255.0, green: 137/255.0, blue: 245/255.0, alpha: 1.0)
        self.progressHeight = 3
        return 4
    }
    
    
    override func pageController(_ pageController: WMPageController, viewControllerAt index: Int) -> UIViewController {
        if index == 0 {
            let chatViewController = BMChatListViewController(frame: CGRect.zero, bm: self.bm, conference: self.conference)
            (self.tabBarController as! BMTabBarController).bmroomChatDelegate = chatViewController
            return chatViewController
        }else if index == 1{
            return BMPeopleViewController(frame: CGRect.zero, bm: self.bm, conference: self.conference)
        }else if index == 2{
             let bmPollsViewController = BMPollsViewController(frame: CGRect.zero, bm: self.bm, conference: self.conference)
            (self.tabBarController as! BMTabBarController).bmroomPollDelegate = bmPollsViewController
            return bmPollsViewController
        }
        else if index == 3{
            let bmQAViewController = BMQAViewController(frame: CGRect.zero, bm: self.bm, conference: self.conference)
            (self.tabBarController as! BMTabBarController).bmroomQADelegate = bmQAViewController
            return bmQAViewController
        }
        else{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.orange
            return vc
        }

    }
    
    
    override func pageController(_ pageController: WMPageController, titleAt index: Int) -> String {
        switch index {
        case 0:
            return "Chat"
            
        case 1:
            return "People"
            
        case 2:
            return "Polls"
            
        case 3:
            return "Q&A"
            
        default:
            return ""
        }
    }
    
    
    override func pageController(_ pageController: WMPageController, didEnter viewController: UIViewController, withInfo info: [AnyHashable : Any]) {
        if viewController.isKind(of: BMChatListViewController.self) {
            
            self.menuView?.item(at: 0).numberLabel.text = "0"
            self.menuView?.item(at: 0).numberLabel.isHidden = true
        }
        if viewController.isKind(of: BMPeopleViewController.self) {
            
            self.menuView?.item(at: 1).numberLabel.text = "0"
            self.menuView?.item(at: 1).numberLabel.isHidden = true
        }
        if viewController.isKind(of: BMPollsViewController.self) {
            PeopleMessage.pollCount = "0"
            self.menuView?.item(at: 2).numberLabel.text = "0"
            self.menuView?.item(at: 2).numberLabel.isHidden = true
        }
        if viewController.isKind(of: BMQAViewController.self) {
            
            self.menuView?.item(at: 3).numberLabel.text = "0"
            self.menuView?.item(at: 3).numberLabel.isHidden = true
        }
    }
    

    
    func chatBadgeCount(notification:NSNotification){
         DispatchQueue.main.sync {
            let message = notification.object as! Message
            if self.selectIndex != 0{
                if message.sid != self.bm.socketID{
                    let x = (self.menuView?.item(at: 0).frame.width)! - 2
                    let y = (self.menuView?.item(at: 0).frame.height)! / 2  - 1
                    self.setupNumberLabel(item: (self.menuView?.item(at: 0))!, frame: CGRect(x: x, y: y, width: 7, height: 7))
                }
            }
        }
    }
    
    func changePeopleMessageCount(notification:NSNotification){
        
        DispatchQueue.main.sync {
            if PeopleMessage.totalMessages.count == 0 {
                self.menuView?.item(at: 1).numberLabel.isHidden = true
            }else{
                let x = (self.menuView?.item(at: 1).frame.width)! - 10
                let y = (self.menuView?.item(at: 1).frame.height)! / 2 - 2
                self.setupNumberLabel(item: (self.menuView?.item(at: 1))!, frame: CGRect(x: x, y: y, width: 7, height: 7))
            }
        }
    }
    
    func changePollCount(){
         DispatchQueue.main.sync {
            let x = (self.menuView?.item(at: 2).frame.width)! - 5
            let y = (self.menuView?.item(at: 2).frame.height)! / 2
            self.setupNumberLabel(item: (self.menuView?.item(at: 2))!, frame: CGRect(x: x, y: y, width: 7, height: 7))
        }
    }
    
    func changeQA(){
        DispatchQueue.main.sync {
            let x = (self.menuView?.item(at: 3).frame.width)! - 5
            let y = (self.menuView?.item(at: 3).frame.height)! / 2
            self.setupNumberLabel(item: (self.menuView?.item(at: 3))!, frame: CGRect(x: x, y: y, width: 7, height: 7))
        }
    }
    
    func setupNumberLabel(item: WMMenuItem, frame: CGRect){
        item.numberLabel.frame = frame
        item.numberLabel.layer.cornerRadius = item.numberLabel.frame.width/2
        item.numberLabel.clipsToBounds = true
        item.numberLabel.isHidden = false
        item.numberLabel.text = ""
    }
    
    

}

//extension BMMessageController: UIScrollViewDelegate {
//    
//    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
//        let x: CGFloat = scrollView.contentOffset.x
//        let w: CGFloat = self.view.frame.width
//        let page = x/w
//        self.segmentView.segmentedControl.selectedSegmentIndex = Int(page)
//    }
//}
//
//extension BMMessageController: SwitchSegmentNotification{
//    func notifySwitchSegment(index: Int) {
//        self.scrollView.setContentOffset(CGPoint(x: CGFloat(index) * self.view.frame.width, y: self.scrollView.bounds.origin.y), animated: false)
//    }
//}

extension BMMessageController: BMNavViewDelegate{
    
    func quiteRoomNotification() {
        let vc = self.tabBarController?.viewControllers![0] as? BMVideoViewController
        vc!.quiteRoom()

    }
    
    func audioOnlyNotification(status: Bool) {
        let vc = self.tabBarController?.viewControllers![0] as? BMVideoViewController
        vc?.audioOnly = status
        vc?.reloadView()
    }
    
}


