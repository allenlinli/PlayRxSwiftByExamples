# Uncomment this line to define a global platform for your project
# platform :ios, '10.0'

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '3.0'
      config.build_settings['MACOSX_DEPLOYMENT_TARGET'] = '10.10'
    end
  end
end


target 'PlayRxSwift' do
  use_frameworks!

pod 'RxSwift',    '~> 3.0.0-beta.1'
pod 'RxCocoa',    '~> 3.0.0-beta.1'
pod 'RxDataSources', '~> 1.0.0-beta.2'


  target 'PlayRxSwiftTests' do
    inherit! :search_paths
    # Pods for testing
  end

end
