Pod::Spec.new do |spec|
  spec.name         = "WYZThemeManager"
  spec.version      = "0.2.1"
  spec.summary      = "Most lightweight, powerful, convenient and easiest way to manage your app themes."
  spec.description  = <<-DESC
                        Most lightweight, powerful, convenient and easiest way to manage your app themes.
                   DESC

  spec.homepage     = "https://github.com/azone/ThemeManager"
  spec.source          = { :git => 'https://github.com/azone/ThemeManager.git', :tag => spec.version }
  
  spec.license      = { :type => "MIT", :file => "LICENSE" }

  spec.author             = { "Yozone Wang" => "wangyaozh@gmail.com" }

  spec.ios.deployment_target = "8.0"
  spec.tvos.deployment_target = "9.0"

  spec.source_files = "Sources/**/*.swift"
end
