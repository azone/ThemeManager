Pod::Spec.new do |spec|
  spec.name         = "ThemeManager"
  spec.version      = "0.1.0"
  spec.summary      = "Most lightweight, powerful, convenient and easiest way to manage your app themes."
  spec.description  = <<-DESC
                        Most lightweight, powerful, convenient and easiest way to manage your app themes.
                   DESC

  spec.homepage     = "https://github.com/azone/ThemeManager"
  spec.source          = { :git => 'https://github.com/azone/ThemeManager.git', :tag => spec.version }
  # spec.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"
  
  spec.license      = { :type => "MIT", :file => "FILE_LICENSE" }

  spec.author             = { "Yozone Wang" => "wangyaozh@gmail.com" }

  spec.ios.deployment_target = "8.0"
  spec.watchos.deployment_target = "2.0"
  spec.tvos.deployment_target = "9.0"

  spec.source_files = "Sources/**/*.swift"
end
