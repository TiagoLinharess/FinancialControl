Pod::Spec.new do |spec|
  spec.name         = 'Core'
  spec.version      = '0.2.0'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/TiagoLinharess/FinancialControl.git'
  spec.authors      = { 'Tiago Linhares' => 'tiagolinharessouza@gmail.com' }
  spec.summary      = 'This is a software development kit'
  spec.source       = { :git => 'https://github.com/TiagoLinharess/FinancialControl.git', :tag => '0.2.0-core' }
  spec.platforms    = { :ios => "17.0" }
  spec.swift_version = '5.8.1'
  spec.vendored_frameworks = 'Core.xcframework'
  spec.framework    = 'SystemConfiguration'
end
