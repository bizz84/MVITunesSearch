Pod::Spec.new do |s|
  s.name         = "MVITunesSearch"
  s.version      = "1.0.0"
  s.summary      = "Simple wrapper library for the iTunes Search API to search for apps by developer ID"

  s.homepage     = "https://github.com/bizz84/MVITunesSearch"

  s.license      = { :type => 'MIT', :file => 'LICENSE.md' }

  s.author       = { "Andrea Bizzotto" => "bizz84@gmail.com" }

  s.platform     = :ios, '7.0'

  s.source       = { :git => "https://github.com/bizz84/MVITunesSearch.git", :tag => '1.0.0' }

  s.source_files = 'MVITunesSearch/*.{h,m}'

  s.screenshots  = ["https://github.com/bizz84/MVITunesSearch/raw/master/preview.png"]

  s.frameworks = 'UIKit', 'Foundation', 'CoreGraphics'

  s.requires_arc = true

end
