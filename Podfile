
## Source
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '17.0'

use_frameworks!

workspace 'FinancialControlApp'

##############
## Pods Def ##
##############

def sharpnez_core_pod
  pod 'SharpnezCore', :git => 'https://github.com/TiagoLinharess/sdk-ios-sharpnez-core.git', :tag => '2.1.1'
end

def  sharpnez_pods
  pod 'SharpnezDesignSystem', '1.2.0'
  sharpnez_core_pod
end

def pods_for_tests
  pod 'SnapshotTesting', '~> 1.9'
end

def currency_pod
  pod 'CurrencyText', :git => 'https://github.com/TiagoLinharess/CurrencyText.git'
end

def snapkit_pod
  pod 'SnapKit', '~> 5.6'
end

###################
## Cores Targets ##
###################

target 'Provider' do
    sharpnez_core_pod
    project 'Provider/Provider.project'
end

#################
## Main Target ##
#################

target 'FinancialControl' do
    currency_pod
    sharpnez_pods
    snapkit_pod
    project 'FinancialControl/FinancialControl.project'
end

#####################
## Modules Targets ##
#####################

target 'WeeklyBudgets' do
    currency_pod
    sharpnez_pods
    project 'WeeklyBudgets/WeeklyBudgets.project'
end

target 'MonthlyBills' do
    currency_pod
    sharpnez_pods
    snapkit_pod
    project 'MonthlyBills/MonthlyBills.project'
end

target 'Login' do
    sharpnez_pods
    snapkit_pod
    project 'Login/Login.project'
end

###################
## Tests Targets ##
###################

target 'ProviderTests' do
    sharpnez_core_pod
    project 'Provider/Provider.project'
end

target 'WeeklyBudgetsTests' do
    pods_for_tests
    project 'WeeklyBudgets/WeeklyBudgets.project'
end

target 'MonthlyBillsTests' do
    sharpnez_core_pod
    pods_for_tests
    project 'MonthlyBills/MonthlyBills.project'
end
