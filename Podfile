# Uncomment the next line to define a global platform for your project
platform :ios, '18.1'

target 'InstagramClone' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for InstagramClone

pod 'Appirater'

# Firebase
pod 'Firebase/Core'
pod 'Firebase/Auth'
pod 'Firebase/Database'
pod 'Firebase/Analytics'
pod 'Firebase/Crashlytics'
pod 'Firebase/Storage'

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings["IPHONEOS_DEPLOYMENT_TARGET"] = "18.1"
    end
  end
end
