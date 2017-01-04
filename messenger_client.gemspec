# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'messenger_client/version'

Gem::Specification.new do |spec|
  spec.name          = "messenger_client"
  spec.version       = MessengerClient::VERSION
  spec.authors       = ["Aaron Cruz"]
  spec.email         = ["aaron@aaroncruz.com"]

  spec.summary       = %q{A client for the Facebook Messenger platform}
  spec.description   = %q{If you are building a bot on the Messenger platform or just trying to connect with your users or friends there, here's a wonderful HTTP client for you!}
  spec.homepage      = "https://computercomputer.computer"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  #if spec.respond_to?(:metadata)
    #spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  #else
    #raise "RubyGems 2.0 or newer is required to protect against " \
      #"public gem pushes."
  #end

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.13"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"

  spec.add_dependency "typhoeus", "~> 1.1.0"
end
