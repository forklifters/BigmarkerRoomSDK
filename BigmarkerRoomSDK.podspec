Pod::Spec.new do |s|
s.name             = 'BigmarkerRoomSDK'
s.version          = '0.1.6'
s.summary          = 'test test testBigmarkerRoomSDK'

s.description      = 'BigmarkerRoomSDK BigmarkerRoomSDK BigmarkerRoomSDK'

s.homepage         = 'https://github.com/hanqingqingmomo/BigmarkerRoomSDK'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'HanQing' => 'qing.han@bigmarker.com' }
s.source           = { :git => 'git@github.com:hanqingqingmomo/BigmarkerRoomSDK.git', :tag => '0.1.6'}
s.vendored_frameworks = ['BMroomSDK.framework', 'WebRTC.framework']
s.vendored_libraries  = 'MQTTKit/libMQTTKit.a'

s.frameworks    = 'UIKit','AVFoundation','Foundation'

s.ios.deployment_target = '9.3'
s.source_files = 'BigmarkerRoomSDK/ViewController.swift'

end
