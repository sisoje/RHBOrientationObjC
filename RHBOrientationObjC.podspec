#
# Be sure to run `pod lib lint RHBOrientationObjC.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'RHBOrientationObjC'
  s.version          = '0.2'
  s.summary          = 'Estimating device orientation based on accelerometer data with "orientation snapping". Great for camera and photo apps.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
RHBOrientation is an easy to use and customizable library for estimating device orientation based on accelerometer data. Written in Objective-C. Orientation detection uses PROPERLY designed "orientation snapping" algorithm with customizable z-axis and orientation snapping treshold value.
                       DESC

  s.homepage         = 'https://github.com/sisoje/RHBOrientationObjC'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Lazar Otasevic' => 'redhotbits@gmail.com' }
  s.source           = { :git => 'https://github.com/sisoje/RHBOrientationObjC.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/redhotbits'

  s.ios.deployment_target = '8.0'

  s.source_files = 'RHBOrientationObjC/Classes/**/*'
  
  # s.resource_bundles = {
  #   'RHBOrientationObjC' => ['RHBOrientationObjC/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'CoreMotion', 'AVFoundation'
  # s.dependency 'RHBSnippetsObjC'
end
