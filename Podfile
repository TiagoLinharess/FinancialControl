source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '17.0'

use_frameworks!

workspace 'FinancialControlApp'

def  sharpnez_pods
  pod 'SharpnezDesignSystem', '1.1.1'
  pod 'SharpnezCore', '1.1.0'
end

def pods_for_tests
  pod 'SnapshotTesting', '~> 1.9.0'
end

target 'FinancialControl' do
    sharpnez_pods
    project 'FinancialControl/FinancialControl.project'
end

target 'WeeklyBudgets' do
    sharpnez_pods
    project 'WeeklyBudgets/WeeklyBudgets.project'
end

target 'WeeklyBudgetsTests' do
    pods_for_tests
    project 'WeeklyBudgets/WeeklyBudgets.project'
end
