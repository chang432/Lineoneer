# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Lineoneer' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Lineoneer
  pod 'GoogleMaps'
  pod 'Firebase/Analytics'
  pod 'Firebase/Firestore'
  pod 'FirebaseFirestoreSwift'

  target 'LineoneerTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'LineoneerUITests' do
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.build_configurations.each do |config|
    config.build_settings["EXCLUDED_ARCHS[sdk=iphonesimulator*]"] = "arm64"
  end
end
