
Pod::Spec.new do |s|

  s.name             = 'Spider'
  s.version          = '1.0.0'
  s.summary          = 'Creepy web framework for Swift.'
  s.description      = <<-DESC
    Spider is an easy-to-use web framework built on-top the wonderful
    AFNetworking library. Spider's easy syntax & modern response handling
    makes requesting/retrieving data incredibly simple.
    DESC
  s.homepage         = 'https://github.com/mitchtreece/Spider'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Mitch Treece' => 'mitchtreece@me.com' }
  s.source           = { :git => 'https://github.com/mitchtreece/Spider.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/MitchTreece'

  s.platform     = :ios, "9.0"
  s.source_files = 'Spider/Classes/**/*'

  s.dependency 'AFNetworking',  '~> 3.0'
  s.dependency 'PromiseKit',    '~> 4.0'

end
