# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Efficient-Weather' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  pod 'Alamofire'
  pod 'RxSwift', '6.5.0'
  pod 'RxCocoa', '6.5.0'
  pod 'Kingfisher', '~> 7.0'
  pod 'Wormholy'
  pod 'RealmSwift', '~>10'
  pod "RxRealm"
  pod 'GoogleMaps'

  post_install do |pi|
    pi.pods_project.targets.each do |t|
        t.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
        end
    end
  end
end
