
Pod::Spec.new do |s|

  s.name             = 'Spider'
  s.version          = '1.0.0'
  s.summary          = 'A short description of Spider.'
  s.description      = <<-DESC
    TODO: Add long description of the pod here.
    DESC
  s.homepage         = 'https://github.com/mitchtreece/Spider'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Mitch Treece' => 'mitchtreece@me.com' }
  s.source           = { :git => 'https://github.com/mitchtreece/Spider.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/MitchTreece'

  s.platform     = :ios, "9.0"
  s.source_files = 'Spider/Classes/**/*'

  s.dependency 'Alamofire',     '~> 4.0'
  s.dependency 'AFNetworking',  '~> 3.0'
  # s.dependency 'PromiseKit',    '~> 4.0'

end
