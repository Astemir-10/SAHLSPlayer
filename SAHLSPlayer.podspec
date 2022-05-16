Pod::Spec.new do |spec|

  spec.name         = "SAHLSPlayer"
  spec.version      = "1.2.0"
  spec.summary      = "A CocoaPods library written in Swift"

  spec.description  = <<-DESC
This CocoaPods library helps you perform calculation.
                   DESC

  spec.homepage     = "https://github.com/Astemir-10/SAHLSPlayer"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "Astemir Shibzuhov" => "shibzuhov2000@mail.ru" }

  spec.ios.deployment_target = "10.1"
  spec.swift_version = "5.5"

  spec.source        = { :git => "https://github.com/Astemir-10/SAHLSPlayer.git", :tag => "#{spec.version}" }
  spec.source_files  = "SAHLSPlayer/**/*.{h,m,swift}"

end
