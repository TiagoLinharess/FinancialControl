# Uncomment the next line to define a global platform for your project
platform :ios, '17.0'

def pods_for_tests
  pod 'SnapshotTesting', '1.9.0'
end

def  sharpnez_pods
  pod 'SharpnezDesignSystem', '1.1.1'
  pod 'SharpnezCore', '1.1.0'
end

target 'FinancialControl' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  sharpnez_pods

  target 'FinancialControlTests' do
    inherit! :search_paths
    pods_for_tests
  end

end
