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
    
    var bigRoom: BigRoomBase!
    var conference: Conference!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Conference.requestConferenceData(id: "0a3c44fd59e1", token: "81456a4cb4b26b5989f825582ae9166c981fd0ee340bcfd4906ea6cb7625c34d") { (conference) in
            if conference != nil {
                let result = ["api_token": "81456a4cb4b26b5989f825582ae9166c981fd0ee340bcfd4906ea6cb7625c34d"]
                BMCurrentUser.saveInfo(responseObject: result as AnyObject!)
       
                self.conference = conference
                self.bigRoom = BigRoomBase(conference: self.conference)
                self.bigRoom.delegate = self
                self.bigRoom.connectServer()
            } else {
                print("error=====================")
            }
         
        }
    }
    
    
}



extension ViewController: BigRoomConnectionProtocol {

    func bmRoomDidConnect(bm: BMRoom!) {
        DispatchQueue.main.sync{

            //(UIApplication.sharedApplication().delegate as! AppDelegate).bm = bm
            let vc = BMTabBarController(bm: bm, conference: self.conference)
            bm.delegate = vc
            self.view.window?.rootViewController = UINavigationController(rootViewController: vc)
            //self.navigationController?.pushViewController(vc, animated: true)
            //vc.hidesBottomBarWhenPushed = true

        }
    }

    func bmRoomFailedConnect(bm: BMRoom!) {
        DispatchQueue.main.sync{
            let alertView = UIAlertController(title: "Error!", message: "Connection Failed!", preferredStyle: .alert)
            alertView.addAction(UIAlertAction(title: "ok", style: .default, handler: nil))
        }
    }
    
}
