
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

def currency_pod
  pod 'CurrencyText', :git => 'https://github.com/TiagoLinharess/CurrencyText.git'
end

## Cores Targets
target 'Provider' do
    sharpnez_core_pod
    project 'Provider/Provider.project'
end

## Main Target
target 'FinancialControl' do
    currency_pod
    sharpnez_pods
    project 'FinancialControl/FinancialControl.project'
end

## Modules Targets
target 'WeeklyBudgets' do
    currency_pod
    sharpnez_pods
    project 'WeeklyBudgets/WeeklyBudgets.project'
end

target 'MonthlyBills' do
    sharpnez_pods
    project 'MonthlyBills/MonthlyBills.project'
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
