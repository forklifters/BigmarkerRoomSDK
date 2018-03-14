//
//  BMTabBarController.swift
//  bigmarker
//
//  Created by hanqing on 2/15/15.
//  Copyright (c) 2015 hanqing. All rights reserved.
//

import UIKit
import AVFoundation
import BMroomSDK

//struct PeopleMessage {
//    static var chatCount = "0"
//    static var totalMessages: [Message]  = []
//    static var bigTotalMessages : [Message] = []
//    static var pollCount = "0"
//}


@objc protocol BigRoomVideoDelegate{
    //video
    @objc optional func bigRoomNotificationDelegateReceiveNewStream(didReceiveNewStream muxerID: String!, enableVideo video: String!, enableAudio audio: String!)
    @objc optional func bigRoomNotificationDelegateFailedConnectStream(muxerID: String)
    @objc optional func bigRoomNotificationDelegateConnectStream(muxerID: String!)
    @objc optional func bigRoomNotificationDelegateDisconnectedStream(muxerID: String!)
    @objc optional func bigRoomNotificationDelegateRemoveFromRoom()
    @objc optional func bigRoomNotificationDelegateMuteAudio(muxerID: String, status: Bool)
    @objc optional func bigRoomNotificationDelegateVideoAction(action: String, status: Int)
    @objc optional func bigRoomNotificationDelegateVideoFrameChanged(muxerID: String, size: CGSize)
    @objc optional func bigRoomNotificationDelegateAudioSizeChanged(muxerID: String!, level: Int32)
    
    @objc optional func bigRoomNotificationDelegateWhiteBoardCreated()
    @objc optional func bigRoomNotificationDelegateWhiteBoardRemoved()
    @objc optional func bigRoomNotificationDelegateWhiteBoardSwitch(page: Int)
    
    @objc optional func bigRoomNotificationDelegateCloseRoom()
    
    @objc optional func bigRoomNotificationDelegateServerTime(message: [NSObject : AnyObject])
    
    @objc optional func bigRoomNotificationDelegateYoutubeLoad(message: [NSObject : AnyObject])
    @objc optional func bigRoomNotificationDelegateYoutubeSeek(message: [NSObject : AnyObject])
    @objc optional func bigRoomNotificationDelegateYoutubePlay(message: [NSObject : AnyObject])
    @objc optional func bigRoomNotificationDelegateYoutubePause(message: [NSObject : AnyObject])
    @objc optional func bigRoomNotificationDelegateYoutubeEnd(message: [NSObject : AnyObject])
    @objc optional func bigRoomNotificationDelegateYoutubeMute(message: [NSObject : AnyObject])
    @objc optional func bigRoomNotificationDelegateYoutubeUnmute(message: [NSObject : AnyObject])
    @objc optional func bigRoomNotificationDelegateYoutubeVolumeChange(message: [NSObject : AnyObject])
    @objc optional func bigRoomNotificationDelegateYoutubeAction(message: [NSObject : AnyObject])
    @objc optional func bigRoomNotificationDelegateYoutubeClear()
    
    @objc optional func bigRoomNotificationDelegateMp4Load(message: [NSObject : AnyObject])
    @objc optional func bigRoomNotificationDelegateMp4End(message: [NSObject : AnyObject])
    @objc optional func bigRoomNotificationDelegateMp4Mute(message: [NSObject : AnyObject])
    @objc optional func bigRoomNotificationDelegateMp4Unmute(message: [NSObject : AnyObject])
    @objc optional func bigRoomNotificationDelegateMp4Pause(message: [NSObject : AnyObject])
    @objc optional func bigRoomNotificationDelegateMp4Play(message: [NSObject : AnyObject])
    @objc optional func bigRoomNotificationDelegateMp4VolumeChange(message: [NSObject : AnyObject])
    @objc optional func bigRoomNotificationDelegateMp4Action(message: [NSObject : AnyObject])
    @objc optional func bigRoomNotificationDelegateMp4Clear()
    
    @objc optional func bigRoomNotificationDelegateMsgAddTabbar(message: [NSObject : AnyObject])
    
}

@objc protocol BigRoomChatDelegate{
    @objc optional func bigRoomNotificationDelegateMsgAdd(message: [NSObject : AnyObject])
    @objc optional func bigRoomNotificationDelegateMsgDel(message: [NSObject : AnyObject])
    @objc optional func bigRoomNotificationDelegateMsgLoad(messages: [NSObject : AnyObject])
    @objc optional func bigRoomNotificationDelegateMsgLock(status: Int)
    @objc optional func bigRoomNotificationDelegateMsgChangeRole(status: Int)
    
}

@objc protocol BigRoomUserDelegate{
    @objc optional func bigRoomNotificationDelegateUserLeave(sid: String)
    @objc optional func bigRoomNotificationDelegateUserEnter(user: [NSObject : AnyObject])
    @objc optional func bigRoomNotificationDelegateUserLoad()
    @objc optional func bigRoomNotificationDelegateUserLock(status: Int)
    @objc optional func bigRoomNotificationDelegateUserChangeRole(role: String, sid: String)
}

@objc protocol BigRoomQADelegate{
    @objc optional func bigRoomNotificationDelegateQANew(message: [NSObject : AnyObject])
    @objc optional func bigRoomNotificationDelegateQAVote(message: [NSObject : AnyObject])
    @objc optional func bigRoomNotificationDelegateQAAnswered(message: [NSObject : AnyObject])
    @objc optional func bigRoomNotificationDelegateQADelete(message: [NSObject : AnyObject])
    @objc optional func bigRoomNotificationDelegateQALock(message:[NSObject : AnyObject])
}

@objc protocol BigRoomPollDelegate{
    @objc optional func bigRoomNotificationDelegatePollReload(message: [NSObject : AnyObject])
    @objc optional func bigRoomNotificationDelegatePollDelete(message:[NSObject : AnyObject])
}


class BMTabBarController: UITabBarController {

    
    var bmroomVideoDelegate: BigRoomVideoDelegate?
    var bmroomUserDelegate: BigRoomUserDelegate?
    var bmroomChatDelegate: BigRoomChatDelegate?
    var bmroomQADelegate: BigRoomQADelegate?
    var bmroomPollDelegate: BigRoomPollDelegate?
    
    
    var conference: Conference!
    var avSession: AVAudioSession!
    var bm: BMRoom!
    // 标示临时管理员 -->在会议室手动设置
    //var tmpAdminStatus = false
    

    override func viewDidLoad() {
        super.viewDidLoad()
//        bm.delegate = self
//        avSession = AVAudioSession.sharedInstance()
//        UIApplication.shared.isIdleTimerDisabled = true
        
        
        UITabBar.appearance().barTintColor = UIColor.white
        
        let item = UITabBarItem.appearance()
        item.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.init(red: 193/255.0, green: 201/255.0, blue: 214/255.0, alpha: 1.0),NSFontAttributeName:UIFont.systemFont(ofSize: 12)], for:.normal)
        item.setTitleTextAttributes([NSForegroundColorAttributeName:UIColor.init(red: 43/255.0, green: 55/255.0, blue: 77/255.0, alpha: 1.0),NSFontAttributeName:UIFont.systemFont(ofSize: 12)], for:.selected)
        
        addChildVc()
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
    }
    
//    override func viewDidAppear(animated: Bool) {
//        super.viewDidAppear(true)
//        
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.handleRouteChange(_:)), name: AVAudioSessionRouteChangeNotification, object: nil)
//        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.audioSessionWasInterrupted(_:)), name: AVAudioSessionInterruptionNotification, object: avSession)
//    }
//    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.navigationBar.isHidden = true
        self.tabBar.barTintColor = UIColor(red: 43/255, green: 55/255, blue: 76/255, alpha: 1)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
//        NotificationCenter.defaultCenter().removeObserver(self, name: AVAudioSessionRouteChangeNotification, object: nil)
//        NotificationCenter.defaultCenter().removeObserver(self, name: AVAudioSessionInterruptionNotification, object: avSession)
    }
    
    func addChildVc(){
        let videoController = BMVideoViewController(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 520))
        let msgController  = BMMessageViewController(frame: CGRect.init(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 520))
        addChildViewController(videoController)
        addChildViewController(msgController)
    }
    
}


extension BMTabBarController {
    
//    func handleRouteChange(notification: NSNotification){
//        let interuptionDict: NSDictionary = notification.userInfo!
//        let routeChangeReason: NSInteger = interuptionDict.valueForKey(AVAudioSessionRouteChangeReasonKey)!.integerValue
//        switch (routeChangeReason) {
//            
//        case Int(AVAudioSessionRouteChangeReason.NewDeviceAvailable.rawValue):
//            printLog("Headphone/Line plugged in")
//            bm.toggleAudioOutput("handset")
//            break;
//        case Int(AVAudioSessionRouteChangeReason.OldDeviceUnavailable.rawValue):
//            printLog("Headphone/Line was pulled. Stopping player....")
//            bm.toggleAudioOutput("speaker")
//            break;
//        default:
//            break;
//        }
//    }
//    
//    func isHeadsetPluggedIn() -> Bool {
//        let route: AVAudioSessionRouteDescription = AVAudioSession.sharedInstance().currentRoute
//        for desc in route.outputs {
//            if (desc ).portType == AVAudioSessionPortHeadphones {
//                return true
//            }
//        }
//        return false
//    }
    
//    func audioSessionWasInterrupted(notification: NSNotification) {
//        if notification.name != AVAudioSessionInterruptionNotification || notification.userInfo == nil{
//            return
//        }
//        
//        var info = notification.userInfo!
//        var intValue: UInt = 0
//        (info[AVAudioSessionInterruptionTypeKey] as! NSValue).getValue(&intValue)
//        if let type = AVAudioSessionInterruptionType(rawValue: intValue) {
//            switch type {
//            case .Began:
//                self.removePersonFromRoom()
//                printLog("start")
//            case .Ended:
//                // interruption ended
//                printLog("ended")
//            }
//        }
//    }
    
    func removePersonFromRoom(){
//        self.navigationController?.popViewControllerAnimated(false)
//        dispatch_async(dispatch_get_global_queue(0, 0)){
//            for muxerInfo in self.bm.muxersInfo {
//                self.bm.disconnectStream(muxerInfo.key as! String)
//            }
//            self.bm.disconnectFromServer()
//            self.bm = nil
//        }
        
    }
    
    
    func changeRole(message: [NSObject : AnyObject]){
        
        let messageDict =  message as NSDictionary
        
        guard let action    = messageDict["action"] as? String        else { return }
        guard let data      = messageDict["data"]   as? NSDictionary  else { return }
        guard let userInfo  = data["user"]      as? NSDictionary  else { return }
        guard let sid       = userInfo["sid"]   as? String        else { return }
        guard let role      = userInfo["role"]  as? String        else { return }
        
        if role == "Temp-Organizer" || role == "Presenter" {
            self.conference.tmpRole = "Admin"
        } else if role == "Member" {
            self.conference.tmpRole = "Member"
        }
        
        // 判断是不是更改自己的role
        if  sid == bm.socketID { // 非realAdmin  是指在会议室里非手动修改的role
            if !self.conference.isAdmin(){
                    // "Temp-Origanizer  代表在会议室里手动设置的role"
                if role == "Organizer" || role == "Temp-Organizer" || role == "Presenter" {
//                    self.tmpAdminStatus = true
                    self.bmroomUserDelegate?.bigRoomNotificationDelegateUserLock!(status: 1)
                    self.bmroomChatDelegate?.bigRoomNotificationDelegateMsgLock!(status: 1)
                    self.bmroomVideoDelegate?.bigRoomNotificationDelegateVideoAction!(action: action, status: 1)
                }  else if role == "Member" {
//                    self.tmpAdminStatus = false
                    self.bmroomUserDelegate?.bigRoomNotificationDelegateUserLock!(status: 0)
                    self.bmroomChatDelegate?.bigRoomNotificationDelegateMsgLock!(status: 0)
                    self.bmroomVideoDelegate?.bigRoomNotificationDelegateVideoAction!(action: action, status: 0)
                    
                    
                }
            }
        }
        
//        //发送会员变成管理员的通知,让whiteboard可以画
//        NSNotificationCenter.defaultCenter().postNotificationName("changeMemberOrAdmin", object: data["status"], userInfo: nil)
//        self.bmroomUserDelegate?.bigRoomNotificationDelegateUserChangeRole!(role, sid: sid)
    }
 
}


extension BMTabBarController: BMRoomDelegate {
    
    
    func connectServer(){ }
    func bmRoomDidConnect(_ bm: BMRoom!) { }
    func bmRoomFailedConnect(_ bm: BMRoom!) { }
    
    func bmRoom(_ bm: BMRoom!, userConnected user: [NSObject : AnyObject]!) {
        print("-----------------------")
        self.bmroomUserDelegate?.bigRoomNotificationDelegateUserEnter!(user: user)
    }
    
    func bmRoom(_ bm: BMRoom!, userDisconnected sid: String!) {
        self.bmroomUserDelegate?.bigRoomNotificationDelegateUserLeave!(sid: sid)
    }
    
    
    func bmRoom(_ bm: BMRoom!, didSyncChatMessages messages: [NSObject : AnyObject]!) {
       self.bmroomChatDelegate?.bigRoomNotificationDelegateMsgLoad!(messages: messages)
    }
    
    
    func bmRoom(_ bm: BMRoom!, didReceiveChatMessage message: [NSObject : AnyObject]!) {
        self.bmroomChatDelegate?.bigRoomNotificationDelegateMsgAdd!(message: message)
        self.bmroomVideoDelegate?.bigRoomNotificationDelegateMsgAddTabbar!(message: message)
        
//        let msg = Message.init(dictionary: message)
//        if msg.toId == "" {
//            //chat的消息条数改变的通知
//            NotificationCenter.defaultCenter().postNotificationName("chatBadgeCount", object: msg, userInfo: nil)
//        }else{
//            PeopleMessage.totalMessages.append(msg)
//            PeopleMessage.bigTotalMessages.append(msg)
//            NSNotificationCenter.defaultCenter().postNotificationName("PeopleMsgAddNotification", object: message, userInfo: nil)
//        }
        
        

    }
    
    
    //分页获取chats
    func bmRoom(_ bm: BMRoom!, didReceiveSyncMessages messages: [NSObject : AnyObject]!) {
        //self.bmroomChatDelegate?.bigRoomNotificationDelegateMsgLoad!(messages)
    }
    
    
    func bmRoom(_ bm: BMRoom!, didReceiveNewStream muxerID: String!, enableVideo video: String!, enableAudio audio: String!) {
        self.bmroomVideoDelegate?.bigRoomNotificationDelegateReceiveNewStream!(didReceiveNewStream: muxerID, enableVideo: video, enableAudio: audio)
    }
    
    
    func bmRoom(_ bm: BMRoom!, didConnectStream muxerID: String!) {
//        if isHeadsetPluggedIn() {
//            bm.toggleAudioOutput("handset")
//        } else {
//            bm.toggleAudioOutput("speaker")
//        }
        self.bmroomVideoDelegate?.bigRoomNotificationDelegateConnectStream!(muxerID: muxerID)
    }
    
    
    func bmRoom(_ bm: BMRoom!, disconnectedStream muxerID: String!) {
        self.bmroomVideoDelegate?.bigRoomNotificationDelegateDisconnectedStream!(muxerID: muxerID)
    }
    
    
    func bmRoom(_ bm: BMRoom!, didReceiveMessage message: [NSObject : AnyObject]!) {
        
        let messageDict = message as NSDictionary
        guard let action = messageDict["action"] as? String else { return }
        
        
    
            if action == "videoShare:get_time_now"  {
                self.bmroomVideoDelegate?.bigRoomNotificationDelegateServerTime!(message: message)
                return
            }
        
            // change role admin/presenter/attendee
            if action == "admin"  {
                //print("=====\(message)")
                self.changeRole(message: message)
                return
            }
        
            // close user video or audio
            if (action == "mute-user-video" || action == "mute-user-audio")  {
            
                let data     = messageDict["data"] as! NSDictionary
                let status   = data["status"] as! String
                let sid      = data["sid"] as! String
                let twitter_name = data["twitter_name"] as? String
                
                //表示是对当前用户的操作
                if  (sid == bm.socketID && twitter_name == nil) {
                    self.bmroomVideoDelegate?.bigRoomNotificationDelegateVideoAction!(action: action, status: status == "enable" ? 1 : 0)
                }
                return
            }
        
            // kick user out room
            if (action == "leave-room") {
                self.bmroomVideoDelegate?.bigRoomNotificationDelegateRemoveFromRoom!()
                return
            }
        
            // open/close attendee's cam & mic
            if (action == "mute-all-mic" || action == "mute-all-cam") {
                //print(self.conference.tmpRole)
                if !self.conference.adminRole(){
                    guard let data   = messageDict["data"] as? NSDictionary else { return }
                    guard let status = data["status"] as? String else { return }
                    self.bmroomVideoDelegate?.bigRoomNotificationDelegateVideoAction!(action: action, status: status == "enable" ? 1 : 0)
                }
                return
            }
        
            if action == "stream:mute" {
                guard let data    = messageDict["data"] as? NSDictionary else { return }
                guard let muxerId = data["mid"] as? String else { return }
                self.bmroomVideoDelegate?.bigRoomNotificationDelegateMuteAudio!(muxerID: muxerId, status: false)
                //self.videoDelegate?.notifyMuteAudio(muxerId, status: false)
                return
            }
        
            if action == "stream:unmute" {
                guard let data    = messageDict["data"] as? NSDictionary else { return }
                guard let muxerId = data["mid"] as? String else { return }
                self.bmroomVideoDelegate?.bigRoomNotificationDelegateMuteAudio!(muxerID: muxerId, status: true)
                //self.videoDelegate?.notifyMuteAudio(muxerId, status: true)
                return
            }
        
            if (action == "whiteboard:create") {
//                let arr = message["data"] as! NSArray
//                //NSUserDefaults.standardUserDefaults().setObject(arr[1] as! String, forKey: "whiteboardHashId")
                self.bmroomVideoDelegate?.bigRoomNotificationDelegateWhiteBoardCreated!()
                return
            }
        
            if action == "whiteboard:close" {
                self.bmroomVideoDelegate?.bigRoomNotificationDelegateWhiteBoardRemoved!()
                return
            }
        
            if action == "whiteboard:switch" {
                let page = messageDict["data"] as? Int ?? 0
                self.bmroomVideoDelegate?.bigRoomNotificationDelegateWhiteBoardSwitch!(page: page)
                return
            }
        
            // enable or disenable public chat
            if action == "chat-lock" {
                if !self.conference.adminRole() {
                    guard let status = messageDict["data"] as? String else { return }
                    self.bmroomChatDelegate?.bigRoomNotificationDelegateMsgLock!(status: status == "enable" ? 1 : 0)
                }
                return
            }
        
           // enable or disenable attendee list
            if action == "seeall-lock" {
                if !self.conference.adminRole(){
                    guard let status = messageDict["data"] as? String else { return }
                    self.bmroomUserDelegate?.bigRoomNotificationDelegateUserLock!(status: status == "enable" ? 1 : 0)
                }
                return
            }
        
            //delete a chat
            if action == "message:delete" {
                self.bmroomChatDelegate?.bigRoomNotificationDelegateMsgDel!(message: message)
                return
            }
        if action == "question-answer-lock" || action == "question-answer-view-lock"{
            self.bmroomQADelegate?.bigRoomNotificationDelegateQALock!(message: message)
        }
        
        if action == "questionAnswer:new" {
            self.bmroomQADelegate?.bigRoomNotificationDelegateQANew!(message: message)
            self.bmroomVideoDelegate?.bigRoomNotificationDelegateMsgAddTabbar!(message: message)
            //NotificationCenter.defaultCenter.postNotificationName("changeQA", object: nil, userInfo: nil)
            return
        }
        
        if action == "questionAnswer:voted" {
            self.bmroomQADelegate?.bigRoomNotificationDelegateQAVote!(message: message)
            return
        }
        
        if action == "questionAnswer:answered" {
            self.bmroomQADelegate?.bigRoomNotificationDelegateQAAnswered!(message: message)
            return
        }
        
        if action == "questionAnswer:delete" {
            self.bmroomQADelegate?.bigRoomNotificationDelegateQADelete!(message: message)
            return
        }

        if  action == "update_result" ||   action == "end_poll"  {
            
            self.bmroomPollDelegate?.bigRoomNotificationDelegatePollReload!(message: message)
            return
        }
        if (action == "new_poll" ) {
            
            let data   = messageDict["data"] as! NSDictionary
            if data["in_queue"] == nil || data["in_queue"] as! Bool == false {
                self.bmroomVideoDelegate?.bigRoomNotificationDelegateMsgAddTabbar!(message: message)
                self.bmroomPollDelegate?.bigRoomNotificationDelegatePollReload!(message: message)
                //记录新的投票数
                //PeopleMessage.pollCount = String(Int(PeopleMessage.pollCount)! + 1)
                //如果有新的投票,发送通知,修改投票数
                //NotificationCenter.defaultCenter.postNotificationName("changePollCount", object: nil, userInfo: nil)
                //有新的投票
                recieveNewPoll(message: message)

            }
        }
        
        if action == "delete_poll" {
            self.bmroomPollDelegate?.bigRoomNotificationDelegatePollDelete!(message: message)
            return
        }
        
        
        //接收web页的坐标
        if action == "whiteboard:draw" {
            //let coordinateModel = CoordinateModel.init(dictionary: message["data"] as! NSDictionary)
//            if self.bm.socketID == coordinateModel.drawer{
//                
//            }else{
//                //print("接收web页的坐标\(message["data"])")
//                NotificationCenter.defaultCenter().postNotificationName("addCoorinate", object: nil, userInfo: ["model":coordinateModel])
//            }
        }
        
        //接收web页的颜色和字体大小
        if action == "whiteboard:sync_position" {
//            
//            let drawPositionModel = DrawPositionModel.init(dictionary: message["data"] as! NSDictionary)
//            //print("接收web页的颜色和字体大小:\(message["data"])")
//            NSNotificationCenter.defaultCenter().postNotificationName("drawColorAndSize", object: nil, userInfo: ["model":drawPositionModel])
        }
        //提前接收web页传过来的颜色或者字体大小
        if action == "whiteboard:sync_draw_action" {
//            print("提前接收web页传过来的颜色或者字体大小:\(message["data"])")
//            let actionDic = message["data"] as! NSDictionary
//            
//            if actionDic["actionName"] as! String == "changeSize" {
//                let drawSizeModel = DrawSizeModel.init(dictionary: actionDic)
//                NSNotificationCenter.defaultCenter().postNotificationName("changeSize", object: nil, userInfo: ["model":drawSizeModel])
//            }
//            if actionDic["actionName"] as! String == "setColor" {
//                let drawColorModel = DrawColorModel.init(dictionary: actionDic)
//                
//                NSNotificationCenter.defaultCenter().postNotificationName("changeColor", object: nil, userInfo: ["model":drawColorModel])
//            }
            
        }
        //接收web页的清除所有坐标命令
        if action == "whiteboard:clear_draw" {
            //print("接收web页的清除所有坐标命令:\(message["data"])")
            
            //NotificationCenter.defaultCenter.postNotificationName("clearLine", object: nil, userInfo: nil)
            
        }
        
        //新用户进来接收之前的画画的图片
        if action == "whiteboard:sync_history" {
            //print("新用户进来接收之前的画画的图片:\(message["data"])")
//            if let whiteboardArr = message["data"] as? NSArray{
//                let whiteboardDrawModel = WhiteboardDrawModel.init(dictionary: whiteboardArr[0] as! NSDictionary)
//                NSNotificationCenter.defaultCenter().postNotificationName("whiteboardDrawModel", object: nil, userInfo: ["model":whiteboardDrawModel])
//                
//            }
        }


    }
    
    func recieveNewPoll(message: [NSObject : AnyObject]){
//        dispatch_async(dispatch_get_main_queue()){
//            if self.backgroundView != nil {
//                self.backgroundView.removeFromSuperview()
//            }
//            let action = message["action"] as! String
//            let data = message["data"] as! NSDictionary
//            if action == "new_poll" {
//                let newPoll = NewPoll.init(dictionary: data)
//                
//                self.backgroundView = NewPollView.init(frame: CGRectMake(0, 0, ScreenW, ScreenH),newPoll: newPoll)
//                self.backgroundView.submitNewPollDelegate = self
//                self.tabBarController?.view.addSubview(self.backgroundView)
//            }
//        }
    }
    
//    func didRecieveSelectBtnWithId(model:NewPoll,chooseArray:NSArray){
//        
//        var dict = [NSString:AnyObject]()
//        dict["poll_id"]       =  model.pollId
//        dict["timestamp"]     =  ToolHelper.getCurrentTimeStamp()
//        dict["photo"]         =  conference.currentUserInfo?.photo
//        dict["choose"]        =  NSArray.init(array: chooseArray)
//        dict["submit_sid"]    =  bm.socketID
//        dict["poll_question"] =  model.pollQuestion
//        dict["choice"]        =  model.choiceIdDic
//        
//        self.bm.PollSubmit(dict)
//        self.backgroundView.removeFromSuperview()
//    }

    
    func bmRoom(bm: BMRoom!, didChangeVideoDimension muxerID: String!, withSize size: CGSize) {
        self.bmroomVideoDelegate?.bigRoomNotificationDelegateVideoFrameChanged!(muxerID: muxerID, size: size)
        return
    }
    
    func bmRoom(bm: BMRoom!, muxerAudioLevel muxerID: String!, changedTo level: Int32) {
        self.bmroomVideoDelegate?.bigRoomNotificationDelegateAudioSizeChanged!(muxerID: muxerID, level: level)
        return
    }
    
    func bmRoom(bm: BMRoom!, failedConnectStream muxerID: String!) {
       self.bmroomVideoDelegate?.bigRoomNotificationDelegateFailedConnectStream!(muxerID: muxerID)
       return
    }
    
    func bmRoomDidClose(bm: BMRoom!) {
        self.bmroomVideoDelegate?.bigRoomNotificationDelegateCloseRoom!()
//        NotificationCenter.defaultCenter.postNotificationName("closeRoom", object: nil, userInfo: nil)
        return
    }
    
    func bmRoom(bm: BMRoom!, loadYoutubeMsg message: [NSObject : AnyObject]!) {
        self.bmroomVideoDelegate?.bigRoomNotificationDelegateYoutubeLoad!(message: message)
        return
    }
    
    func bmRoom(bm: BMRoom!, seekYoutubeMsg message: [NSObject : AnyObject]!) {
        self.bmroomVideoDelegate?.bigRoomNotificationDelegateYoutubeSeek!(message: message)
        return
    }
    
    func bmRoom(bm: BMRoom!, playYoutubeMsg message: [NSObject : AnyObject]!) {
        self.bmroomVideoDelegate?.bigRoomNotificationDelegateYoutubePlay!(message: message)
        return
    }
    
    func bmRoom(bm: BMRoom!, pauseYoutubeMsg message: [NSObject : AnyObject]!) {
        self.bmroomVideoDelegate?.bigRoomNotificationDelegateYoutubePause!(message: message)
        return
    }
    
    func bmRoom(bm: BMRoom!, endYoutubeMsg message: [NSObject : AnyObject]!) {
        self.bmroomVideoDelegate?.bigRoomNotificationDelegateYoutubeEnd!(message: message)
        return
    }
    
    func bmRoom(bm: BMRoom!, muteYoutubeMsg message: [NSObject : AnyObject]!) {
        self.bmroomVideoDelegate?.bigRoomNotificationDelegateYoutubeMute!(message: message)
        return
    }
    
    func bmRoom(bm: BMRoom!, unmuteYoutubeMsg message: [NSObject : AnyObject]!) {
        self.bmroomVideoDelegate?.bigRoomNotificationDelegateYoutubeUnmute!(message: message)
        return
    }
    
    func bmRoom(bm: BMRoom!, volumeChangeYoutubeMsg message: [NSObject : AnyObject]!) {
        self.bmroomVideoDelegate?.bigRoomNotificationDelegateYoutubeVolumeChange!(message: message)
        return
    }
    
    func bmRoom(bm: BMRoom!, actionYoutubeMsg message: [NSObject : AnyObject]!) {
        self.bmroomVideoDelegate?.bigRoomNotificationDelegateYoutubeAction!(message: message)
        return
    }
    
    func bmRoom(bm: BMRoom!, loadMP4Msg message: [NSObject : AnyObject]!) {
        self.bmroomVideoDelegate?.bigRoomNotificationDelegateMp4Load!(message: message)
        return
    }
    
    func bmRoom(bm: BMRoom!, endMP4Msg message: [NSObject : AnyObject]!) {
        self.bmroomVideoDelegate?.bigRoomNotificationDelegateMp4End!(message: message)
        return
    }
    
    func bmRoom(bm: BMRoom!, muteMP4Msg message: [NSObject : AnyObject]!) {}
    
    func bmRoom(bm: BMRoom!, pauseMP4Msg message: [NSObject : AnyObject]!) {
        self.bmroomVideoDelegate?.bigRoomNotificationDelegateMp4Pause!(message: message)
        return
    }
    
    func bmRoom(bm: BMRoom!, playMP4Msg message: [NSObject : AnyObject]!) {
        self.bmroomVideoDelegate?.bigRoomNotificationDelegateMp4Play!(message: message)
        return
    }
    
    func bmRoom(bm: BMRoom!, unmuteMP4Msg message: [NSObject : AnyObject]!) {}
    
    func bmRoom(bm: BMRoom!, volumeChangeMP4Msg message: [NSObject : AnyObject]!) {}
    
    func bmRoom(bm: BMRoom!, actionMP4Msg message: [NSObject : AnyObject]!) {}
    
}



