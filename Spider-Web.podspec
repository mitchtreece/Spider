Pod::Spec.new do |s|

    s.name              = 'Spider-Web'
    s.module_name       = 'Spider'
    s.version           = '2.0.1'
    s.summary           = 'Creepy networking library for Swift.'

    s.description = <<-DESC
    Spider is an easy-to-use networking library built for
    speed & readability. Spider's modern syntax & response handling
    makes working with web services so simple - it's almost spooky.
    DESC

    s.homepage          = 'https://github.com/mitchtreece/Spider'
    s.license           = { :type => 'MIT', :file => 'LICENSE' }
    s.author            = { 'Mitch Treece' => 'mitchtreece@me.com' }
    s.source            = { :git => 'https://github.com/mitchtreece/Spider.git', :tag => s.version.to_s }
    s.social_media_url  = 'https://twitter.com/MitchTreece'

    s.platform          = :ios, "13.0"
    s.swift_version     = '5'

    # Subspecs

    s.default_subspec = 'Core'

    s.subspec 'Core' do |core|

        core.source_files = 'Spider/Classes/Core/**/*'
        core.dependency     'ReachabilitySwift', '~> 5.0.0'
        core.dependency     'Kingfisher',        '~> 5.8.0'

    end

    s.subspec 'Combine' do |combine|

      combine.source_files = 'Spider/Classes/Combine/**/*'
      combine.dependency     'Spider-Web/Core'

    end

    s.subspec 'PromiseKit' do |promisekit|

      promisekit.source_files = 'Spider/Classes/PromiseKit/**/*'
      promisekit.dependency     'Spider-Web/Core'
      promisekit.dependency     'PromiseKit/CorePromise', '~> 6.0'

    end

    s.subspec 'All' do |all|

      all.dependency 'Spider-Web/Core'
      all.dependency 'Spider-Web/Combine'
      all.dependency 'Spider-Web/PromiseKit'

    end

end
