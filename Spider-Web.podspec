Pod::Spec.new do |s|

    s.name                   = 'Spider-Web'
    s.module_name            = 'Spider'
    s.version                = '2.2.0'
    s.summary                = 'Creepy networking library for Swift.'

    s.description = <<-DESC
    Spider is an easy-to-use networking library built for
    speed & readability. Spider's modern syntax & response handling
    makes working with web services so simple - it's almost spooky.
    DESC

    s.homepage               = 'https://github.com/mitchtreece/Spider'
    s.license                = { :type => 'MIT', :file => 'LICENSE' }
    s.author                 = { 'Mitch Treece' => 'mitchtreece@me.com' }
    s.source                 = { :git => 'https://github.com/mitchtreece/Spider.git', :tag => s.version.to_s }
    s.social_media_url       = 'https://twitter.com/MitchTreece'

    s.platform               = :ios, "13.0"
    s.swift_version          = '5'

    # Subspecs

    s.default_subspec        = 'Core'

    s.subspec 'Core' do |ss|

        ss.source_files =    'Sources/Spider/Core/**/*'

        ss.dependency        'Espresso/Core',     '~> 3.0'
        ss.dependency        'ReachabilitySwift', '~> 5.0'

    end

    s.subspec 'PromiseKit' do |ss|

      ss.source_files =      'Sources/Spider/PromiseKit/**/*'

      ss.dependency          'Spider-Web/Core'
      ss.dependency          'PromiseKit/CorePromise', '~> 6.0'

    end

    s.subspec 'UIKit' do |ss|

      ss.source_files =      'Sources/Spider/UI/UIKit/**/*'

      ss.dependency          'Spider-Web/Core'
      ss.dependency          'Espresso/UIKit',    '~> 3.0'
      ss.dependency          'Kingfisher',        '~> 7.0'

    end

    s.subspec 'UIKit-PromiseKit' do |ss|

      ss.source_files =      'Sources/Spider/UI/UIKit-PromiseKit/**/*'

      ss.dependency          'Spider-Web/UIKit'
      ss.dependency          'Spider-Web/PromiseKit'

    end

    s.subspec 'All' do |ss|

      ss.dependency          'Spider-Web/Core'
      ss.dependency          'Spider-Web/UIKit'
      ss.dependency          'Spider-Web/UIKit-PromiseKit'
      ss.dependency          'Spider-Web/PromiseKit'

    end

end
