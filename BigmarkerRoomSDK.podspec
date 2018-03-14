Pod::Spec.new do |s|
s.name             = 'BigmarkerRoomSDK'
s.version          = '0.1.3'
s.summary          = 'test test testBigmarkerRoomSDK'

s.description      = 'BigmarkerRoomSDK BigmarkerRoomSDK BigmarkerRoomSDK'

s.homepage         = 'https://github.com/hanqingqingmomo/BigmarkerRoomSDK'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'HanQing' => 'qing.han@bigmarker.com' }
s.source           = { :git => 'git@github.com:hanqingqingmomo/BigmarkerRoomSDK.git', :tag => s.version.to_s}

s.frameworks    = 'UIKit','AVFoundation','Foundation', 'webRTC', 'MQTTKit', 'BMroomSDK'
s.resources     = ['BigmarkerRoomSDK/Assets/*.png']


s.ios.deployment_target = '9.0'
s.source_files = 'BigmarkerRoomSDK/*.swift'

end
