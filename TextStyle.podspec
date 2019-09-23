Pod::Spec.new do |spec|

  spec.name         = "TextStyle"
  spec.version      = "0.0.1"
  spec.summary      = "Simple and type-safe attributed string creation"
  spec.description  = "Simple and type-safe attributed string creation."
  spec.homepage     = "https://github.com/noremac/TextStyle"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = "Cameron Pulsford"
  spec.platform     = :ios, "13.0"
  spec.source       = { :git => "https://github.com/noremac/TextStyle.git", :tag => "#{spec.version}" }
  spec.source_files  = "Classes", "Sources/TextStyle/**/*.swift"
  spec.swift_versions = ['5.0']
end
