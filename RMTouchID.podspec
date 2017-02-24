Pod::Spec.new do |s|
  s.name         = "RMTouchID"
  s.version      = "0.0.1"
  s.summary      = "A small wrapper around TouchId."
  s.description  = <<-DESC
  This pod was created to use in our RubyMotion project.
We where not able to load some TouchId Constants inside RubyMotion,
so we created this helper pod in Objective-c.
                   DESC
  s.homepage     = "https://github.com/organizze/rm-touch-id"
  s.license      = "MIT"
  s.author       = { "Felipe" => "solanoluz@gmail.com" }
  s.platform     = :ios
  s.source       = { :git => "git@github.com:organizze/rm-touch-id.git" }
  s.source_files  = 'Classes/*.{h,m}'
  s.frameworks = 'Security', 'LocalAuthentication'
  s.requires_arc = true
end
