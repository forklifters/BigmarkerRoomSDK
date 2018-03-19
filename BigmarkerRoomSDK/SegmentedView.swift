//
//  ClubSegmentedView.swift
//  bigmarker
//
//  Created by hanqing on 8/24/16.
//  Copyright © 2016 hanqing. All rights reserved.
//

import UIKit

protocol SwitchSegmentNotification {
    func notifySwitchSegment(index: Int)
}

class SegmentedView: UIView {
    
    var selectedSegmentIndex = 0
    var segmentedControl: HMSegmentedControl!
    var switchSegmentDelegate: SwitchSegmentNotification?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = frame
        self.prepareSegmentControl()
        self.setupBottomLineToSegmentedControl()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func prepareSegmentControl(){
        segmentedControl = HMSegmentedControl(sectionTitles: ["Channel", "About",])
        segmentedControl.frame = CGRect(x: self.bounds.origin.x, y: self.bounds.origin.y, width: self.frame.width, height:  self.frame.height)
        segmentedControl.selectionStyle = HMSegmentedControlSelectionStyleFullWidthStripe;
        segmentedControl.selectionIndicatorHeight = 3.0
        
        segmentedControl.titleTextAttributes  = [NSForegroundColorAttributeName:UIColor.black, NSFontAttributeName: UIFont.systemFont(ofSize: 12)]
        
        segmentedControl.selectedTitleTextAttributes = [NSForegroundColorAttributeName:UIColor.black, NSFontAttributeName: UIFont.systemFont(ofSize: 12)]
        
        segmentedControl.selectionIndicatorColor = UIColor(red:0/255, green:192/255, blue:131/255, alpha:1)
        segmentedControl.selectionIndicatorLocation = HMSegmentedControlSelectionIndicatorLocationDown;
        segmentedControl.selectedSegmentIndex = 0
        self.selectedSegmentIndex = segmentedControl.selectedSegmentIndex
        segmentedControl.addTarget(self, action:  #selector(segmentedChangedValue), for: UIControlEvents.valueChanged)
        
        self.addSubview(segmentedControl)
    }
    
    func setupBottomLineToSegmentedControl(){
        let boder: CALayer = CALayer()
        boder.backgroundColor = UIColor(red: 241/255, green: 243/255, blue: 245/255, alpha: 1).cgColor
        boder.frame = CGRect(x: 0, y: self.frame.height - 1, width: self.frame.width, height: 1)
        self.layer.addSublayer(boder)
    }
    
    func segmentedChangedValue(segmentedControl: HMSegmentedControl) {
        self.switchSegmentDelegate?.notifySwitchSegment(index: segmentedControl.selectedSegmentIndex)
    }

}
