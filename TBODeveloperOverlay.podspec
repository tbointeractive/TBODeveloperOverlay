#
#  Be sure to run `pod spec lint TBODeveloperOverlay.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "TBODeveloperOverlay"
  s.version      = "1.3.0"
  s.summary      = "iOS Developer Tools for Debugging."

  s.description  = <<-DESC
                    TBODeveloperOverlay - Some developer tools for debugging iOS Apps
                   DESC

  s.homepage     = "https://github.com/tbointeractive/TBODeveloperOverlay"

  s.license      = "MIT"

  s.author      = { "Cornelius Horstmann" => "horstmann@tbointeractive.com", "Thorsten Stark" => "stark@tbointeractive.com", "Bernhard Eiling" => "eiling@tbointeractive.com"  }

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/tbointeractive/TBODeveloperOverlay.git", :tag => '1.3.0' }

 # s.source       = { :git => "http://git.tbointeractive.com/root/TBODeveloperOverlay", :tag => s.version.to_s }

  s.subspec 'Core' do |sp|
    sp.source_files = "TBODeveloperOverlay/TBODeveloperOverlay/*.{h,m}"
  end

  s.subspec 'KVDebugger' do |sp|
    sp.source_files = "Classes/TBODeveloperOverlayKVDebugger/*.{h,m}"
    sp.resources = ['Classes/TBODeveloperOverlayKVDebugger/*.xib']
    sp.resource_bundles = {
        'KVDebugger' => ['Classes/TBODeveloperOverlayKVDebugger/*.xib']
    }
  end

  s.subspec 'LoggerOverlay' do |sp|
    sp.source_files = "Classes/TBODeveloperOverlayLogger/*.{h,m}"
    sp.resources = ['Classes/TBODeveloperOverlayLogger/*.xib']
    sp.resource_bundles = {
        'LoggerOverlay' => ['Classes/TBODeveloperOverlayLogger/*.xib']
    }
    sp.dependency 'CocoaLumberjack', '~> 2.3'
  end

  s.subspec 'FileInspector' do |sp|
    sp.source_files = "Classes/TBODeveloperOverlayFileInspector/*.{h,m}"
  end

  s.subspec 'All' do |sp|
    sp.source_files = "Classes/TBODeveloperOverlay.h"
    sp.dependency 'TBODeveloperOverlay/Core'
    sp.dependency 'TBODeveloperOverlay/KVDebugger'
    sp.dependency 'TBODeveloperOverlay/LoggerOverlay'
    sp.dependency 'TBODeveloperOverlay/FileInspector'
  end

  s.default_subspecs =  'All'

end
