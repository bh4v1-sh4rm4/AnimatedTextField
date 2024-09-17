Pod::Spec.new do |s|
  s.name         = 'AnimatedTextField'
  s.version      = '1.0.0'
  s.summary      = 'A custom textfield with animated placeholder support.'
  s.description  = 'AnimatedTextField is a reusable custom text field with a placeholder animation implemented in Swift and backed by a XIB file.'
  s.homepage     = 'https://github.com/bh4v1-sh4rm4/AnimatedTextField'
  s.license      = { :type => 'MIT', :file => 'LICENSE.txt' }
  s.author       = { 'Bhavishya Sharma' => 'bhavishya.0709@gmail.com' }
  s.source       = { :git => 'https://github.com/bh4v1-sh4rm4/AnimatedTextField.git', :tag => s.version.to_s }
  s.platform     = :ios, '13.0'
  s.source_files  = 'AnimatedTextField/**/*.{swift}'
  s.resource_bundles = {
    'AnimatedTextField' => ['AnimatedTextField/**/*.{xib}']
  }
  s.swift_version = '5.0'
end
