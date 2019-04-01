Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '11.0'
s.name = "SmoothCanvas"
s.summary = "Smooth Canvas lets users write with beautiful lines."
s.requires_arc = true
s.version = "0.1.0"
s.license = { :type => "MIT", :file => "LICENSE" }
s.author = { "Benedek Varga" => "vargabenedek92@gmail.com" }
s.homepage = "https://github.com/benedekvarga/SmoothCanvas"
s.source = { :git => "https://github.com/benedekvarga/SmoothCanvas.git", 
             :tag => "#{s.version}" }
s.framework = "UIKit"
s.source_files = "SmoothCanvas/SmoothCanvasView.swift"
s.resources = "SmoothCanvas/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"
s.swift_version = '4.2'

end