Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '11.0'
s.name = "Smooth Canvas"
s.summary = "Smooth Canvas lets users write with beautiful lines."
s.requires_arc = true

s.version = "0.1.0"

# 3
s.license = { :type => "MIT", :file => "LICENSE" }

# 4 - Replace with your name and e-mail address
s.author = { "Benedek Varga" => "vargabenedek92@gmail.com" }

# 5 - Replace this URL with your own GitHub page's URL (from the address bar)
s.homepage = "https://github.com/benedekvarga/SmoothCanvas"

# 6 - Replace this URL with your own Git URL from "Quick Setup"
s.source = { :git => "https://github.com/benedekvarga/SmoothCanvas.git", 
             :tag => "#{s.version}" }

s.framework = "UIKit"
s.source_files = "SmoothCanvas/SmoothCanvasView.swift"
s.resources = "SmoothCanvas/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"

s.swift_version = "4.2"

end