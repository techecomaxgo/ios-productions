# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

#
#use_frameworks!
#post_install do |installer|
#     installer.generated_projects.each do |project|
#           project.targets.each do |target|
#               target.build_configurations.each do |config|
#                   config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '16.0'
#                end
#           end
#    end
# end

target 'MaxPay' do
  
  # Comment the next line if you don't want to use dynamic frameworks
  
  use_frameworks!
  pod 'IQKeyboardManager'
#  pod 'Alamofire', '4.8.2'
  #pod 'Alamofire', '~> 4.9'
  pod 'Kingfisher', '~> 7.0'
  pod 'SwiftyJSON', '~> 4.0'
  pod 'ProgressHUD'
  pod 'DatePicker'
  pod 'DropDown'
  pod 'SSSwiftUILoader'
  pod 'SwiftLoader'
  pod 'ObjectMapper', '~> 3.5'
  pod 'lottie-ios'
  pod 'PieCharts'
  pod 'OpalImagePicker'
  pod 'Toast-Swift', '~> 5.1.1'
  pod 'FirebaseAnalytics'
  pod 'FirebaseMessaging'
  pod 'KeychainAccess'
  pod 'SDWebImage'
  pod 'FSPopoverView'
  pod 'Smartech-iOS-SDK', '~> 3.5.3'
#  pod 'Cosmos', '~> 25.0'

end

post_install do |installer|
    installer.pods_project.build_configurations.each do |config|
        config.build_settings.delete('CODE_SIGNING_ALLOWED')
        config.build_settings.delete('CODE_SIGNING_REQUIRED')
#        config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
        config.build_settings['SWIFT_VERSION'] = '5.7'
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '17.0'


    end
end



