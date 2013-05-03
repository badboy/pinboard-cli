Gem::Specification.new do |s|
  s.name = 'pinboard-cli'
  s.version         = "0.0.1"
  s.date            = Date.today.to_s
  s.summary         = "Pinboard on your commandline"
  s.homepage        = 'http://github.com/badboy/pinboard-cli'
  s.email           = "badboy@archlinux.us"
  s.authors         = [ "Jan-Erik Rediger"  ]
  s.has_rdoc        = false

  s.files           = []
  s.files          += Dir.glob("bin/**/*")

  s.executables     = %w( pinboard )
  s.description     = <<-desc
  Search through your pinboard bookmarks on the command-line."
  desc

  s.add_runtime_dependency 'pinboard', '~> 0.1.1'
end
