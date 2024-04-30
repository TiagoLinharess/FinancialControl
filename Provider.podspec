Pod::Spec.new do |spec|
  spec.name         = 'Provider'
  spec.version      = '0.1.6'
  spec.license      = { :type => 'MIT' }
  spec.homepage     = 'https://github.com/TiagoLinharess/FinancialControl.git'
  spec.authors      = { 'Tiago Linhares' => 'tiagolinharessouza@gmail.com' }
  spec.summary      = 'This is a software development kit'
  spec.source       = { :git => 'https://github.com/TiagoLinharess/FinancialControl.git', :tag => '0.1.6-provider' }
  spec.platforms    = { :ios => "17.0" }
  spec.swift_version = '5.8.1'
  spec.vendored_frameworks = 'Provider/Provider.xcframework'
  spec.framework    = 'SystemConfiguration'
end
