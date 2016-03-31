Pod::Spec.new do |s|
  s.name         = "Typeset"
  s.version      = "3.0"
  s.summary      = "An convenient and fast approach to create AttributedString"
  s.description  = <<-DESC
                   I create this repo, beacuse deal with NSAttributedString in ObjectiveC is so painful. And this project is inspired by ruby gem colorize. Use this to deal with string more easily.
                   DESC

  s.homepage     = "https://github.com/Draveness/Typeset"
  s.license      = "MIT" 
  s.author             = { "Draveness" => "stark.draven@gmail.com" }
  s.platform     = :ios, "6.0"

  s.source       = { :git => "https://github.com/Draveness/Typeset.git", :tag => s.version }

  s.source_files  = "Classes/*.{h,m}"
#  s.public_header_files = "Classes/Typeset.h"
end
