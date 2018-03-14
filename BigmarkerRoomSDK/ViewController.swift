//
//  ViewController.swift
//  BigmarkerRoomSDK
//
//  Created by Han Qing on 12/3/2018.
//  Copyright © 2018 bigmarker. All rights reserved.
//

import UIKit
import BMroomSDK

class ViewController: UIViewController {
    
//    var bigRoom: BigRoomBase!
//    var conference: Conference!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        
//        requestConferenceData(id: "d49f89b9a39f") { (conference) in
//            
//            self.bigRoom = BigRoomBase(conference: self.conference)
//            self.bigRoom.delegate = self
//            
//            DispatchQueue.main.sync{
//                self.bigRoom.connectServer()
//            }
//        }
        
    }




//func requestConferenceData(id: String, finishedCallback : @escaping (_ conference: Conference?) -> ()){
//    let urlString = SERVICE_API_DOMAIN + "/mobile/api/v1/conferences/\(id)?mobile_token=f75f6f7ddb80ed15100f26fed2afc37c5db24a75078e781895b4c04a2d440856"
//    
//    NetworkTools.requestData(type: .GET, URLString: urlString) { (result) in
//        
//        guard let dict = result as? NSDictionary else {
//            finishedCallback(nil)
//            return
//        }
//        
//        guard let conference = dict.value(forKey: "conference") as? NSDictionary else {
//            finishedCallback(nil)
//            return
//        }
//
//        self.conference = Conference(dictionary: conference)
//    
//        finishedCallback(self.conference )
//    }
//}
//
//
//
}



//extension ViewController: BigRoomConnectionProtocol {
//    
//    func bmRoomDidConnect(bm: BMRoom!) {
//        DispatchQueue.main.sync{
//            
//            //(UIApplication.sharedApplication().delegate as! AppDelegate).bm = bm
//            let vc = BMTabBarController()
//            vc.conference = self.conference
//            vc.bm = bm
//            self.view.window?.rootViewController = UINavigationController(rootViewController: vc)
//            //self.navigationController?.pushViewController(vc, animated: true)
//            //vc.hidesBottomBarWhenPushed = true
//          
//        }
//    }
//    
//    func bmRoomFailedConnect(bm: BMRoom!) {
//        DispatchQueue.main.sync{
//            let alertView = UIAlertController(title: "Error!", message: "Connection Failed!", preferredStyle: .alert)
//            alertView.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
//        }
//    }
//    
//}

