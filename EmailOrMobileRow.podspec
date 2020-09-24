#
# Be sure to run `pod lib lint EmailOrMobileRow.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'EmailOrMobileRow'
  s.version          = '0.1.0'
  s.summary          = 'Accept an Email or Mobile number'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
A Eureka form row that accepts and validates typed entry as either an Email address or a Mobile number.


                       DESC

  s.homepage         = 'https://github.com/apcro/EmailOrMobileRow'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'u' => 'cro@alienpants.com' }
  s.source           = { :git => 'https://github.com/apcro/EmailOrMobileRow.git', :tag => s.version.to_s }

  s.ios.deployment_target = '13.0'

  s.swift_version = '5.0'

  s.source_files = 'EmailOrMobileRow/Classes/**/*'
  
  # s.resource_bundles = {
  #   'EmailOrMobileRow' => ['EmailOrMobileRow/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  s.dependency 'Eureka'
end
