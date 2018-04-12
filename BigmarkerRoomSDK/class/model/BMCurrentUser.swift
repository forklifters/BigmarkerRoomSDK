//
//  CurrentUser.swift
//  bigmarker
//
//  Created by hanqing on 8/17/16.
//  Copyright © 2016 hanqing. All rights reserved.
//

import Foundation

class BMCurrentUser: NSObject {
    

    class func name() -> String {
        let prefs:UserDefaults = UserDefaults.standard
        if let username = prefs.object(forKey: "USERNAME") as? String {
            return username
        } else {
            return ""
        }
    }
    
    class func email() -> String {
        let prefs:UserDefaults = UserDefaults.standard
        if let email = prefs.object(forKey: "EMAIL") as? String {
            return email
        } else {
            return ""
        }
    }
    
    class func token() -> String {
        let prefs:UserDefaults = UserDefaults.standard
        if let token = prefs.object(forKey: "TOKEN") {
            return token as! String
        } else {
            return ""
        }
    }
    class func id() -> Int {
        let prefs:UserDefaults = UserDefaults.standard
        if let id = prefs.object(forKey: "USERID") {
            return id as! Int
        } else {
            return 0
        }
       
    }
    class func obfuscatedId() -> String {
         let prefs:UserDefaults = UserDefaults.standard
        if let obfuscatedId = prefs.object(forKey: "obfuscatedId") {
            return obfuscatedId as! String
        } else {
            return ""
        }
        
    }

    class func timeZone() -> String{
        let systemZone = NSTimeZone.system.identifier
        if UserDefaults.standard.value(forKey: "CurrentTimeZone") == nil {
            UserDefaults.standard.set(systemZone, forKey: "CurrentTimeZone")
        }
        return UserDefaults.standard.value(forKey: "CurrentTimeZone") as! String
    }
    
    class func avatar() -> String {
        //let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        return ToolHelper.currentUserAvatarUrl()
//        let image = UIImage(named: "default_profile_picture")
//        return image!
    }
    
    class func clearInfo(){
        let prefs:UserDefaults = UserDefaults.standard
        prefs.removeObject(forKey: "USERNAME")
        //prefs.removeObjectForKey("EMAIL")
        prefs.removeObject(forKey: "TOKEN")
        prefs.removeObject(forKey: "AVATARURL")
        prefs.removeObject(forKey: "ISLOGGEDIN")
        prefs.removeObject(forKey: "USERID")
        prefs.removeObject(forKey: "obfuscatedId")
        prefs.synchronize()
    }
    
    class func saveInfo(responseObject: AnyObject!){
         let prefs:UserDefaults = UserDefaults.standard
        prefs.set(responseObject["email"] ?? "", forKey: "EMAIL")
        prefs.set(responseObject["username"] ?? "", forKey: "USERNAME")
        prefs.set(responseObject["api_token"] ?? "", forKey: "TOKEN")
        prefs.set(responseObject["photo"] ?? "", forKey: "AVATARURL")
        prefs.set(1, forKey: "ISLOGGEDIN")
        prefs.set(responseObject["id"] ?? "", forKey: "USERID")
        prefs.set(responseObject["obfuscated_id"] ?? "", forKey: "obfuscatedId")
        
        prefs.synchronize()
    }

    
}
