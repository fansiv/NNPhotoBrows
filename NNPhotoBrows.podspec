

Pod::Spec.new do |s|
  s.name         = "NNPhotoBrows"
  s.version      = "0.0.2"
  s.summary      = "photo browser for ios."
  s.homepage     = "https://github.com/fansiv/NNPhotoBrows"
  s.license      = "MIT"
  s.author             = { "NWT" => "https://github.com/fansiv/NNPhotoBrows" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/fansiv/NNPhotoBrows.git", :tag => "0.0.2" }
  s.source_files  = "NNPhotoBrows/*.{h,m}"
  s.frameworks = "UIKit", "Foundation"
  s.requires_arc = true
  s.dependency "SDWebImage", "~> 4.0"

end
