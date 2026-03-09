#
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html.
# Run `pod lib lint cardscan.podspec` to validate before publishing.
#
Pod::Spec.new do |s|
  s.name             = 'cardscan'
  s.version          = '0.0.1'
  s.summary          = 'Flutter wrapper for native card scanning.'
  s.description      = <<-DESC
A Flutter plugin that launches a native card scanner and returns scanned card details.
                       DESC
  s.homepage         = 'https://github.com/SunnatilloShavkatov/cardscan'
  s.license          = { :file => '../LICENSE' }
  s.author           = { 'sunnatillo' => 'noreply@example.com' }
  s.source           = { :path => '.' }
  s.source_files = [
    'Classes/**/*',
    'Vendor/CardScan/CardScan/CardScan/CardScan.h',
    'Vendor/CardScan/CardScan/CardScan/Classes/**/*.{swift,h,m}',
  ]
  s.public_header_files = [
    'Vendor/CardScan/CardScan/CardScan/CardScan.h',
    'Vendor/CardScan/CardScan/CardScan/Classes/SSDOcr.h',
  ]
  s.resources = [
    'Vendor/CardScan/CardScan/CardScan/Resources/**/*',
    'Vendor/CardScan/CardScan/CardScan/Classes/SSDOcr.mlmodel',
    'Resources/PrivacyInfo.xcprivacy',
  ]
  s.dependency 'Flutter'
  s.platform = :ios, '13.0'
  s.weak_frameworks = 'AVKit', 'CoreML', 'VideoToolbox', 'Vision', 'UIKit', 'AVFoundation'

  # Flutter.framework does not contain a i386 slice.
  s.pod_target_xcconfig = { 'DEFINES_MODULE' => 'YES', 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'i386' }
  s.swift_version = '5.0'
end
