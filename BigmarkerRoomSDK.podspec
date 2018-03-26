Pod::Spec.new do |s|
s.name             = 'BigmarkerRoomSDK'
s.version          = '1.0.8'
s.summary          = 'test test testBigmarkerRoomSDK'

s.description      = 'BigmarkerRoomSDK BigmarkerRoomSDK BigmarkerRoomSDK'

s.homepage         = 'https://github.com/hanqingqingmomo/BigmarkerRoomSDK'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'HanQing' => 'qing.han@bigmarker.com' }
s.source           = { :git => 'git@github.com:hanqingqingmomo/BigmarkerRoomSDK.git', :tag => '1.0.8'}
s.vendored_frameworks = ['BMroomSDK.framework', 'WebRTC.framework']
s.vendored_libraries  = 'MQTTKit/libMQTTKit.a'

s.public_header_files = "BigmarkerRoomSDK/PopoverView/*.h","BigmarkerRoomSDK/CWStatusBarNotification/*.h",
                        "BigmarkerRoomSDK/HMSegmentedControl/*.h","BigmarkerRoomSDK/Masonry/*.h",
                        "BigmarkerRoomSDK/MBProgressHUD/*.h", "BigmarkerRoomSDK/SDWebImage/*.h",
                        "BigmarkerRoomSDK/SVPullToRefresh/*.h", "BigmarkerRoomSDK/YTPlayerView/*.h"

#s.dependency 'MBProgressHUD', '~> 1.0.0'
#s.dependency 'HMSegmentedControl'
#s.dependency 'SVPullToRefresh'
#s.dependency 'SDWebImage', '~>3.6'
#s.dependency 'CWStatusBarNotification', '~> 2.3.1'
#s.dependency "youtube-ios-player-helper"
#s.dependency 'Popover.OC'
#s.dependency 'Masonry'

s.frameworks    = 'UIKit','AVFoundation','Foundation'
s.resources = "BMSDK.bundle"
s.ios.deployment_target = '9.3'
s.source_files = 'BigmarkerRoomSDK/class/*.*', "BigmarkerRoomSDK/PopoverView/*.*",
                 "BigmarkerRoomSDK/CWStatusBarNotification/*.*", "BigmarkerRoomSDK/HMSegmentedControl/*.*",
                 "BigmarkerRoomSDK/Masonry/*.*", "BigmarkerRoomSDK/MBProgressHUD/*.*",
                 "BigmarkerRoomSDK/SDWebImage/*.*","BigmarkerRoomSDK/SVPullToRefresh/*.*",
                 "BigmarkerRoomSDK/YTPlayerView/*.*"

end
