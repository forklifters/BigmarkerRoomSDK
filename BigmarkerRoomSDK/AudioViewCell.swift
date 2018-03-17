//
//  AudioViewCell.swift
//  bigmarker
//
//  Created by Han Qing on 30/1/2018.
//  Copyright © 2018 hanqing. All rights reserved.
//



class AudioViewCell: UICollectionViewCell {
    
    var avatar: UIImageView!
    var name:   UILabel!
    
    
    var userInfo : VideoUserInfo? {
        didSet {
           
            avatar = UIImageView()
           
            let url = NSURL(string: userInfo!.avatarUrl)
//            avatar.sd_setImageWithURL(url, placeholderImage: UIImage(named: "default_profile_picture"))
            avatar.translatesAutoresizingMaskIntoConstraints = false
            avatar.contentMode = UIViewContentMode.scaleAspectFill
            avatar.clipsToBounds = true
            avatar.layer.cornerRadius = 25
            
            name = UILabel()
            name.text = userInfo?.userName
            name.font = UIFont.systemFont(ofSize: 12)
            name.textAlignment = .center
            name.textColor = UIColor.white
            name.clipsToBounds = true
            
            self.addSubview(avatar)
            self.addSubview(name)
            
            setLayout()
        }
    }
    
    func setLayout(){
        self.avatar.mas_makeConstraints { (make) in
            make?.centerX.mas_equalTo()(self)
            make?.top.mas_equalTo()(self.mas_top)?.setOffset(10)
            make?.width.mas_equalTo()(50)
            make?.height.mas_equalTo()(50)
          
        }
        
        self.name.mas_makeConstraints { (make) in
            make?.top.mas_equalTo()(self.avatar.mas_bottom)?.setOffset(10)
            make?.right.mas_equalTo()(self.mas_right)?.setOffset(0)
            make?.left.mas_equalTo()(self.mas_left)?.setOffset(0)
            make?.height.mas_equalTo()(30)
        }
    }
    
    

}
