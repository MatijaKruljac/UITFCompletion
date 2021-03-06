#
# Be sure to run `pod lib lint UITFCompletion.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'UITFCompletion'
  s.version          = '0.1.1'
  s.summary          = 'UITFCompletion makes it easy to complete words or make tags of participants of group conversation in UITextField.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
UITFCompletion makes it easy to complete words or make tags of participants of group conversation in UITextField like Facebook Messenger. In
future versions possibility of adding an image for tag (sugestions) in completion text holder will be implemented. It is very easy to use, providing
a full customization of text colors and tag character.
                       DESC

  s.homepage         = 'https://github.com/MatijaKruljac/UITFCompletion'
  # s.screenshots     = 'https://github.com/MatijaKruljac/UITFCompletion/blob/master/uitf_example_video.gif'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Matija Kruljac' => 'kruljac.matija@gmail.com' }
  s.source           = { :git => 'https://github.com/MatijaKruljac/UITFCompletion.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'UITFCompletion/Classes/**/*'
  
  # s.resource_bundles = {
  #   'UITFCompletion' => ['UITFCompletion/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
