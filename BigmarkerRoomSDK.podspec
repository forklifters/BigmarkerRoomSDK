Pod::Spec.new do |s|
s.name             = 'BigmarkerRoomSDK'
s.version          = '0.1.3'
s.summary          = 'test test testBigmarkerRoomSDK'

s.description      = 'BigmarkerRoomSDK BigmarkerRoomSDK BigmarkerRoomSDK'

s.homepage         = 'https://github.com/hanqingqingmomo/BigmarkerRoomSDK'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'HanQing' => 'qing.han@bigmarker.com' }
s.source           = { :http => 'http://github.com/hanqingqingmomo/BigmarkerRoomSDK/archive/0.1.3.zip'}

s.frameworks    = 'UIKit','AVFoundation','Foundation'



s.ios.deployment_target = '9.0'
s.source_files = 'BigmarkerRoomSDK/*.swift'

end
