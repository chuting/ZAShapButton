Pod::Spec.new do |s|
s.name             = 'ShapeButton'
s.version          = '1.0.1'

s.summary          = '  这个是个sdk实现了灯具的收发指令以及指令拼接等功能'
s.description      = ' 这个是个sdk实现了灯具的收发指令以及指令拼接等功能,  这个是个sdk实现了灯具的收发指令以及指令拼接等功能  这个是个sdk实现了灯具的收发指令以及指令拼接等功能  这个是个sdk实现了灯具的收发指令以及指令拼接等功能  这个是个sdk实现了灯具的收发指令以及指令拼接等功能'


s.homepage         = 'https://github.com/chuting/ZAShapButton'
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'chuting' => '502353919@qq.com' }
s.source           = { :git => 'https://github.com/chuting/ZAShapButton.git', :branch => 'master' }

s.requires_arc = true
# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

s.ios.deployment_target = '8.0'
s.source_files =  'ShapeButton/Classes/**/*'

s.public_header_files = 'ShapeButton/Classes/**/*.h'
s.resources =   ['ShapeButton/Assets/button.xcassets',]


s.frameworks = 'UIKit'



end
