
## Source
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '17.0'

use_frameworks!

workspace 'FinancialControlApp'

## Pods Def
def sharpnez_core_pod
  pod 'SharpnezCore', '1.1.0'
end

def  sharpnez_pods
  pod 'SharpnezDesignSystem', '1.1.1'
  sharpnez_core_pod
end

def pods_for_tests
  pod 'SnapshotTesting', '~> 1.9'
end

## Cores Targets
target 'Provider' do
    sharpnez_core_pod
    project 'Provider/Provider.project'
end

## Main Target
target 'FinancialControl' do
    sharpnez_pods
    project 'FinancialControl/FinancialControl.project'
end

## Modules Targets
target 'WeeklyBudgets' do
    sharpnez_pods
    project 'WeeklyBudgets/WeeklyBudgets.project'
end

## Tests Targets
target 'ProviderTests' do
    sharpnez_core_pod
    project 'Provider/Provider.project'
end

target 'WeeklyBudgetsTests' do
    pods_for_tests
    project 'WeeklyBudgets/WeeklyBudgets.project'
end
