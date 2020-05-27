#
#  Be sure to run `pod spec lint TBODeveloperOverlay.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "TBODeveloperOverlay"
  s.version      = "2.1"
  s.summary      = "iOS Developer Tools for Debugging."

  s.description  = <<-DESC
                    TBODeveloperOverlay - Some developer tools for debugging iOS Apps
                   DESC

  s.homepage     = "https://github.com/tbointeractive/TBODeveloperOverlay"

  s.license      = "MIT"

  s.author      = { "Cornelius Horstmann" => "horstmann@tbointeractive.com", "Matthias Gebhardt" => "gedhardt@tbo.de", "Thorsten Stark" => "stark@tbo.de"}

  s.platform     = :ios, "9.3"

  s.swift_version = '5.0'

  s.source       = { :git => "https://github.com/tbointeractive/TBODeveloperOverlay.git", :tag => '2.1' }

  s.source_files = "TBODeveloperOverlay/TBODeveloperOverlay/**/*.swift"

end
