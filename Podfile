platform :ios, '9.0'

target 'DigitalPaymentsSample' do

  use_frameworks!

  pod 'DigitalPaymentsSDK', :git => 'https://github.com/oneincgithub/DigitalPayments.SDK-for-iOS.git', :tag => '1.0.5'
  
end

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
    end
end