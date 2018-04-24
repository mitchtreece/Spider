
Pod::Spec.new do |s|

  s.name             = 'Spider-Web'
  s.module_name      = 'Spider'
  s.version          = '1.4.0'
  s.summary          = 'Creepy web framework for Swift.'
  s.description      = <<-DESC
    Spider is an easy-to-use web framework built for
    speed & readability. Spider's modern syntax & response handling
    makes working with web services fun again.
    DESC
  s.homepage         = 'https://github.com/mitchtreece/Spider'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Mitch Treece' => 'mitchtreece@me.com' }
  s.source           = { :git => 'https://github.com/mitchtreece/Spider.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/MitchTreece'

  s.platform     = :ios, "10.0"
  s.swift_version = '4.1'
  s.source_files = 'Spider/Classes/**/*'

  s.dependency 'SDWebImage', '~> 4.0'
  s.dependency 'PromiseKit/CorePromise', '~> 6.0'

end
