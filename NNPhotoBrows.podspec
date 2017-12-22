

Pod::Spec.new do |s|
  s.name         = "NNPhotoBrows"
  s.version      = "0.0.1"
  s.summary      = "photo browser for ios."
  s.homepage     = "https://github.com/fansiv/NNPhotoBrows"
  s.license      = "MIT"
  s.author             = { "NWT" => "727515439@qq.com" }
  s.platform     = :ios, "7.0"
  s.source       = { :git => "https://github.com/fansiv/NNPhotoBrows.git", :tag => "0.0.1" }
  s.source_files  = "NNPhotoBrows", "NNPhotoBrows/**/*.{h,m}"
  s.framework  = "UIKit"
  s.dependency "SDWebImage", "~> 4.0"

end
