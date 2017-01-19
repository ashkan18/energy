source "https://rubygems.org"

gem "xcpretty"
gem "second_curtain"

gem "sbconstants"
gem "danger"

gem "cocoapods"
gem "cocoapods-keys"

group :deployment do
  gem "fastlane"

  plugins_path = File.join(File.dirname(__FILE__), 'fastlane', 'Pluginfile')
  eval(File.read(plugins_path), binding) if File.exist?(plugins_path)
end
