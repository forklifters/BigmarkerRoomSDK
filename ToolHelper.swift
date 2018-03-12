//
//  ToolHelper.swift
//  bigmarker
//
//  Created by hanqing on 12/28/14.
//  Copyright (c) 2014 hanqing. All rights reserved.
//
import EventKit

class ToolHelper {
    
   class func convertEmoji(inout msg: String) -> Dictionary<Int, String>{
        
        var values: Dictionary<Int, String> = [:]
        var images: Array<String> = []
        if Regex("(<img.*?>)").test(msg) {
            let matches = matchesForRegexInText("(<img.*?>)", text: msg)
            
            for match in matches {
                var emojiName = ""
                
                // 得到emoji名称
                var s = matchesForRegexInText("/(.*png)", text: match)
                if !s.isEmpty{
                    let s1 = s[0] as String
                    let news = s1.characters.split {$0 == "/"}.map { String($0) }
                    emojiName = news.last!
                    images.append(emojiName)
                }
                
                //计算emoji位置
                while (msg.rangeOfString(match) != nil) {
                    let index = msg.rangeOfString(match)?.startIndex
                    msg = msg.stringByReplacingCharactersInRange(msg.rangeOfString(match)!, withString: "")
                    values[Int("\(index!)")!] = emojiName
                }
            }
        }
        
        return values
    }
    
    
    class func getCurrentTimeStamp()->Int{
        let now = NSDate()
        let timeInterval:NSTimeInterval = now.timeIntervalSince1970
        let timeStamp = Int(timeInterval)
        return timeStamp
    }
    
    class func matchesForRegexInText(regex: String!, text: String!) -> [String] {
        
        let regex = try! NSRegularExpression(pattern: regex,
                                             options: [])
        let nsString = text as NSString
        let results = regex.matchesInString(text,
                                            options: [], range: NSMakeRange(0, nsString.length))
        
        return results.map { nsString.substringWithRange($0.range)}
    }
    
   class func uniq<S : SequenceType, T : Hashable where S.Generator.Element == T>(source: S) -> [T] {
        var buffer = [T]()
        var added = Set<T>()
        for elem in source {
            if !added.contains(elem) {
                buffer.append(elem)
                added.insert(elem)
            }
        }
        return buffer
    }
    
    class func checkNetworkAvailable() {
        
        AFNetworkReachabilityManager.sharedManager().startMonitoring()
        
        AFNetworkReachabilityManager.sharedManager().setReachabilityStatusChangeBlock { (status: AFNetworkReachabilityStatus) -> Void in
            switch status.hashValue{
            case AFNetworkReachabilityStatus.NotReachable.hashValue:
                NSNotificationCenter.defaultCenter().postNotificationName("NetworkIsReachable", object: nil)
                break
            case AFNetworkReachabilityStatus.ReachableViaWiFi.hashValue, AFNetworkReachabilityStatus.ReachableViaWWAN.hashValue:
                break
            default:
                NSNotificationCenter.defaultCenter().postNotificationName("NetworkIsUnReachable", object: nil)
                break
            }
        }

    }
    
    class func showAlertViewAboutNetwork(view: UIView, msg: String = "Internet connection not available") {
        if  !AFNetworkReachabilityManager.sharedManager().reachable {
            let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
            //hud.mode = MBProgressHUDModeText
            hud.margin = 20
            hud.labelText = msg
            hud.labelFont = UIFont.systemFontOfSize(15)
            hud.hide(true, afterDelay: 3)
        }
    }
    
    class func showAlertView(view: UIView, msg: String = "") {
        let hud = MBProgressHUD.showHUDAddedTo(view, animated: true)
        //hud.mode = MBProgressHUDModeText
        hud.margin = 20
        hud.labelText = msg
        hud.labelFont = UIFont.systemFontOfSize(15)
        hud.hide(true, afterDelay: 3)
    }
    
    func getIFAddresses() -> [String] {
        var addresses = [String]()
        
        // Get list of all interfaces on the local machine:
        var ifaddr : UnsafeMutablePointer<ifaddrs> = nil
        if getifaddrs(&ifaddr) == 0 {
            
            // For each interface ...
            for (var ptr = ifaddr; ptr != nil; ptr = ptr.memory.ifa_next) {
                let flags = Int32(ptr.memory.ifa_flags)
                var addr = ptr.memory.ifa_addr.memory
                
                // Check for running IPv4, IPv6 interfaces. Skip the loopback interface.
                if (flags & (IFF_UP|IFF_RUNNING|IFF_LOOPBACK)) == (IFF_UP|IFF_RUNNING) {
                    if addr.sa_family == UInt8(AF_INET) || addr.sa_family == UInt8(AF_INET6) {
                        
                        // Convert interface address to a human readable string:
                        var hostname = [CChar](count: Int(NI_MAXHOST), repeatedValue: 0)
                        if (getnameinfo(&addr, socklen_t(addr.sa_len), &hostname, socklen_t(hostname.count),
                            nil, socklen_t(0), NI_NUMERICHOST) == 0) {
                                if let address = String.fromCString(hostname) {
                                    addresses.append(address)
                                }
                        }
                    }
                }
            }
            freeifaddrs(ifaddr)
        }
        
        return addresses
    }
 
//    class func getApiToken() -> String? {
//        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
//        let token = prefs.valueForKey("TOKEN") as? String
//        return token
//    }
    
    class func createUIActivityIndicatorView() -> UIActivityIndicatorView {
        let loadIndicator = UIActivityIndicatorView()
        loadIndicator.activityIndicatorViewStyle = .Gray
        loadIndicator.center = CGPointMake(150, 85);
        return loadIndicator
    }
    
    class func currentUsername() -> String {
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        return prefs.objectForKey("USERNAME") as! String
    }
    
    
    class func currentUserAvatar() -> UIImage{
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        //return currentUserDefaultAvatar()

        let url = NSURL(string:  prefs.objectForKey("AVATARURL")as! String )
        let data = NSData(contentsOfURL: url!)
        if data == nil {
            return currentUserDefaultAvatar()
        }
        let image = UIImage(data: data!)
        if image != nil {
            return  image!
        } else {
            return currentUserDefaultAvatar()
        }
    }
    
    class func currentUserAvatarUrl() ->String {
        let prefs:NSUserDefaults = NSUserDefaults.standardUserDefaults()
        
        if let avatar = prefs.objectForKey("AVATARURL") as? String{
            return avatar
        } else {
            return ""
        }
    }
    
    class func currentUserDefaultAvatar() -> UIImage{
        return UIImage(named: "default_profile_picture")!
    }
    
    // asyn fetch
    class func fetchRemoteImage(url: String) -> UIImage{
        let url   = NSURL(string:  url)
        let data  = NSData(contentsOfURL: url!)
 
        if data == nil {
            return currentUserDefaultAvatar()
        }
        
        let image = UIImage(data: data!)
        if image != nil {
            return  image!
        } else {
            return currentUserDefaultAvatar()
        }
    }
    
    class func clearHtml(str: String) -> String{
        let regex:NSRegularExpression  = try! NSRegularExpression(
            pattern: "<.*?>",
            options: NSRegularExpressionOptions.CaseInsensitive)
        
        let range = NSMakeRange(0, str.characters.count)
        let htmlLessString :String = regex.stringByReplacingMatchesInString(str,
            options: NSMatchingOptions(),
            range:range ,
            withTemplate: "")
        return htmlLessString
    }
    
    class func decodeHtml(encodedString: String) -> String {
        let encodedData = encodedString.dataUsingEncoding(NSUTF8StringEncoding)!
        let attributedOptions : [String: AnyObject] = [
            NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType,
            NSCharacterEncodingDocumentAttribute: NSUTF8StringEncoding
        ]
        let attributedString = try! NSAttributedString(data: encodedData, options: attributedOptions, documentAttributes: nil)
        let decodedString = attributedString.string
        return decodedString
    }
    
    
    class func clearFackbookToken(){
        FBSDKAccessToken.setCurrentAccessToken(nil)
    }
    
    class func clearLinkedinToken(){
        LISDKSessionManager.clearSession()
    }
    
    class func heightForView(text:String, font:UIFont, width:CGFloat) -> CGFloat{
        let label:UILabel = UILabel(frame: CGRectMake(0, 0, width, CGFloat.max))
        label.numberOfLines = 0
        label.lineBreakMode = NSLineBreakMode.ByWordWrapping
        label.font = font
        label.text = text
        
        label.sizeToFit()
        return label.frame.height
    }
    
    
    class func convertDateFormater(dateString: String) -> NSDate? {
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"//this your string date format
        dateFormatter.timeZone = NSTimeZone(name: "UTC")
        return dateFormatter.dateFromString(dateString)
    }
    
}
