source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '17.0'

use_frameworks!

workspace 'FinancialControlApp'

def  sharpnez_pods
  pod 'SharpnezDesignSystem', '1.1.1'
  pod 'SharpnezCore', '1.1.0'
end

target 'FinancialControl' do
    project 'FinancialControl/FinancialControl.project'
    sharpnez_pods
end

target 'WeeklyBudgets' do
    project 'WeeklyBudgets/WeeklyBudgets.project'
    sharpnez_pods
end
