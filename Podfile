target 'OMDB-API-Firebase' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!
  platform :ios, '13.0'
 
 # Network
 pod 'Alamofire', '~> 5.4'
 
   # Helper
   
   pod 'Firebase/Core' , '~> 8.10.0'
   pod 'Firebase/Messaging', '~> 8.10.0'
   pod 'Firebase/Analytics', '~> 8.10.0'
   pod 'Firebase/Crashlytics', '~> 8.10.0'
   pod 'Firebase/RemoteConfig', '~> 8.10.0'

   
   pod "TinyConstraints", '~> 4.0'
   pod 'SwiftLint', '~> 0.44'
   pod 'MobilliumBuilders', '~> 1.4'
   pod 'Kingfisher', :git => 'https://github.com/onevcat/Kingfisher.git', :branch => 'version6-xcode13'
   pod 'SwiftEntryKit', '~> 1.2'
   pod 'SwiftGen', '~> 6.0'
   pod 'ReachabilitySwift', '~> 5.0.0'

  target 'OMDB-API-FirebaseTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'OMDB-API-FirebaseUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
      config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
    end
  end
end
