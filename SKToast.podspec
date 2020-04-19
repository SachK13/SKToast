#
# Be sure to run `pod lib lint SKToast.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'SKToast'
  s.version          = '1.1.0'
  s.summary          = 'SKToast is a simple and light weight Android like toast view for your iOS app written in swift.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
SKToast is a simple Android like toast view really easy to integrate and easy to use with other customization options.
                       DESC

  s.homepage         = 'https://github.com/SachK13/SKToast'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'SachK13' => 'iosdev.sachin@gmail.com' }
  s.source           = { :git => 'https://github.com/SachK13/SKToast.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'
  s.swift_versions = ['5.0', '5.1', '5.2']

  s.source_files = 'SKToast/Classes/**/*'
  s.exclude_files = 'SKToast/Classes/**/*.plist'
  
  # s.resource_bundles = {
  #   'SKToast' => ['SKToast/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'Foundation'
  # s.dependency 'AFNetworking', '~> 2.3'
end
