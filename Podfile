platform :ios, '9.0'

post_install do |installer| 
  installer.pods_project.build_configurations.each do |config| 
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64" 
  end 
end 
 
target 'DigitalPayments.PaymentForm.Sample' do

  use_frameworks!

  pod 'DigitalPayments.PaymentForm.SDK', :git => 'https://github.com/oneincgithub/DigitalPayments.SDK-for-iOS.git', :tag => '2.0.6'

end