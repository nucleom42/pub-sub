Gem::Specification.new do |s|
  s.author = ["Oleg Saltykov"]
  s.homepage = "https://github.com/nucleom42/pub-sub"
  s.name = %q{pub-sub}
  s.version = "1.0.0"
  s.licenses    = ['MIT']
  s.date = %q{2021-11-19}
  s.summary = %q{Pub-Sub - simple way to have pure Ruby pub sub event system }
  s.files = %w[lib/pub_sub/configuration.rb lib/pub_sub/container.rb lib/pub_sub/hash.rb lib/pub_sub/publisher.rb lib/pub_sub/subscriber.rb]
  s.require_paths = %w(lib)
end
