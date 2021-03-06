Pod::Spec.new do |s|
s.name             = 'BigmarkerRoomSDK'
s.version          = '1.1.9'
s.summary          = 'BigmarkerRoomSDK'

s.description      = 'Bigmarker Conference Room SDK'

s.homepage         = 'https://github.com/hanqingqingmomo/BigmarkerRoomSDK'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'HanQing' => 'qing.han@bigmarker.com' }
s.source           = { :git => 'git@github.com:hanqingqingmomo/BigmarkerRoomSDK.git', :tag => '1.1.9'}
s.vendored_frameworks = ['BMroomSDK.framework', 'WebRTC.framework']
s.vendored_libraries  = 'MQTTKit/libMQTTKit.a'

s.public_header_files = "Pods/PopoverView/*.h","CWStatusBarNotification/*.h", "BMroomSDK.framework/Headers/BMRoom.h",
                        "HMSegmentedControl/*.h","Masonry/*.h",
                        "MBProgressHUD/*.h", "SDWebImage/*.h",
                        "SVPullToRefresh/*.h", "YTPlayerView/*.h"

s.dependency 'MBProgressHUD', '~> 1.0.0'
s.dependency 'HMSegmentedControl'
s.dependency 'SVPullToRefresh'
s.dependency 'SDWebImage', '~>3.6'
s.dependency 'CWStatusBarNotification', '~> 2.3.1'
s.dependency "youtube-ios-player-helper"
s.dependency 'Popover.OC'
s.dependency 'Masonry'
s.dependency "AFNetworking", "~> 2.0"

s.frameworks    = 'UIKit','AVFoundation','Foundation'
s.resources = "BMSDK.bundle"
s.ios.deployment_target = '9.0'


s.subspec 'class' do |ss|
  ss.subspec 'controller' do |c|
    c.source_files = 'BigmarkerRoomSDK/class/controller/*.*'
  end
  ss.subspec 'model' do |m|
    m.source_files = 'BigmarkerRoomSDK/class/model/*.*'
  end
  ss.subspec 'view' do |v|
    v.source_files = 'BigmarkerRoomSDK/class/view/*.*'
  end
  ss.subspec 'cell' do |c|
    c.source_files = 'BigmarkerRoomSDK/class/cell/*.*'
  end
end

end
