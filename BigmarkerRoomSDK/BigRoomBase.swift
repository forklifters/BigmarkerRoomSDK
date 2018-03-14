//
//  BigRoomBase.swift
//  bigmarker
//
//  Created by hanqing on 2/15/15.
//  Copyright (c) 2015 hanqing. All rights reserved.
//

import UIKit
import BMroomSDK

@objc protocol BigRoomConnectionProtocol {
    @objc optional func  bmRoomDidConnect(bm: BMRoom!)
    @objc optional func  bmRoomFailedConnect(bm: BMRoom!)
}

class BigRoomBase: NSObject,  BMRoomDelegate {
    
    var delegate:BigRoomConnectionProtocol?
    
    var host   = "" //"192.168.0.12"
    var mcuID  = ""                          //"37558ee4cbbc"
    var userID = ""                          //"40fbdba8084d"
    var data   = ""
    var conference: Conference!
    
    init(conference: Conference) {
        self.conference = conference
        self.host =  "wrtc32.bigmarker.com"//conference.conferenceServer!
    }
    
    
    func connectServer(){
        let options: NSMutableDictionary = NSMutableDictionary()
        options["host"]     = self.host
        options["authData"] = conference.dataKey!
        options["mcuID"]    = conference.mcuID!
        options["userID"]   = conference.userID!
        options["twilioPassword"]   = conference.twilioPassword
        options["twilioUsername"]   = conference.twilioUsername
        
        BMRoom(delegate: self, options: options as [NSObject : AnyObject])!.connectToServer()
    }
    
    func disConnectServer(){
        let options: NSMutableDictionary = NSMutableDictionary()
        options["host"]     = self.host
        options["authData"] = conference.dataKey!
        options["mcuID"]    = conference.mcuID!
        options["userID"]   = conference.userID!
        options["twilioPassword"]   = conference.twilioPassword
        options["twilioUsername"]   = conference.twilioUsername
        
        BMRoom(delegate: self, options: options as [NSObject : AnyObject])!.disconnectFromServer()
    }

    
    func bmRoomDidConnect(_ bm: BMRoom!) {
        self.delegate?.bmRoomDidConnect!(bm: bm)
    }
    
    func bmRoomFailedConnect(_ bm: BMRoom!) {
        self.delegate?.bmRoomFailedConnect!(bm: bm)
    }
    
    func bmRoom(_ bm: BMRoom!, didReceiveSyncMessages messages: [NSObject : AnyObject]!) {}
    func bmRoom(_ bm: BMRoom!, didSyncChatMessages messages: [NSObject : AnyObject]!) {}
    func bmRoom(_ bm: BMRoom!, didReceiveChatMessage message: [NSObject : AnyObject]!) {}
    func bmRoom(_ bm: BMRoom!, didConnectStream muxerID: String!) {}
    func bmRoom(_ bm: BMRoom!, disconnectedStream muxerID: String!) {}
    func bmRoom(_ bm: BMRoom!, didReceiveMessage message: [NSObject : AnyObject]!) {}
     func bmRoom(_ bm: BMRoom!, didReceiveNewStream muxerID: String!, enableVideo video: String!, enableAudio audio: String!) {}
    func bmRoom(_ bm: BMRoom!, failedConnectStream muxerID: String!) {}
    func bmRoom(_ bm: BMRoom!, userConnected user: [NSObject : AnyObject]!) {
        print("================")
    }
    func bmRoom(_ bm: BMRoom!, userDisconnected sid: String!) {}
    func bmRoomDidClose(_ bm: BMRoom!) {}
    func bmRoom(_ bm: BMRoom!, didChangeVideoDimension muxerID: String!, with size: CGSize) {}
    func bmRoom(_ bm: BMRoom!, muxerAudioLevel muxerID: String!, changedTo level: Int32) {}
    
    
    func bmRoom(_ bm: BMRoom!, loadYoutubeMsg message: [NSObject : AnyObject]!) {}
    func bmRoom(_ bm: BMRoom!, playYoutubeMsg message: [NSObject : AnyObject]!) {}
    func bmRoom(_ bm: BMRoom!, pauseYoutubeMsg message: [NSObject : AnyObject]!) {}
    func bmRoom(_ bm: BMRoom!, endYoutubeMsg message: [NSObject : AnyObject]!) {}
    func bmRoom(_ bm: BMRoom!, actionYoutubeMsg message: [NSObject : AnyObject]!) {}
    func bmRoom(_ bm: BMRoom!, muteYoutubeMsg message: [NSObject : AnyObject]!) {}
    func bmRoom(_ bm: BMRoom!, unmuteYoutubeMsg message: [NSObject : AnyObject]!) {}
    func bmRoom(_ bm: BMRoom!, seekYoutubeMsg message: [NSObject : AnyObject]!) {}
    func bmRoom(_ bm: BMRoom!, volumeChangeYoutubeMsg message: [NSObject : AnyObject]!) {}
    
    
    func bmRoom(_ bm: BMRoom!, actionMP4Msg message: [NSObject : AnyObject]!) {}
    func bmRoom(_ bm: BMRoom!, endMP4Msg message: [NSObject : AnyObject]!) {}
    func bmRoom(_ bm: BMRoom!, loadMP4Msg message: [NSObject : AnyObject]!) {}
    func bmRoom(_ bm: BMRoom!, muteMP4Msg message: [NSObject : AnyObject]!) {}
    func bmRoom(_ bm: BMRoom!, pauseMP4Msg message: [NSObject : AnyObject]!) {}
    func bmRoom(_ bm: BMRoom!, playMP4Msg message: [NSObject : AnyObject]!) {}
    func bmRoom(_ bm: BMRoom!, unmuteMP4Msg message: [NSObject : AnyObject]!) {}
    func bmRoom(_ bm: BMRoom!, volumeChangeMP4Msg message: [NSObject : AnyObject]!) {}
    
    
    
}
