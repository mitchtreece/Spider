
Pod::Spec.new do |s|

  s.name                = 'Spider-Web'
  s.module_name         = 'Spider'
  s.version             = '1.5.1'
  s.summary             = 'Creepy web framework for Swift.'

  s.description         = <<-DESC
    Spider is an easy-to-use web framework built for
    speed & readability. Spider's modern syntax & response handling
    makes working with web services fun again.
    DESC

  s.homepage            = 'https://github.com/mitchtreece/Spider'
  s.license             = { :type => 'MIT', :file => 'LICENSE' }
  s.author              = { 'Mitch Treece' => 'mitchtreece@me.com' }
  s.source              = { :git => 'https://github.com/mitchtreece/Spider.git', :tag => s.version.to_s }
  s.social_media_url    = 'https://twitter.com/MitchTreece'

  s.swift_version       = '5'
  s.platform            = :ios, '11.0'
  s.source_files        = 'Spider/Classes/**/*'

  s.dependency 'SDWebImage', '~> 5.0'
  s.dependency 'PromiseKit/CorePromise', '~> 6.8'

end
