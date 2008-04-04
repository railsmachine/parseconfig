#!/usr/bin/env ruby

require('rubygems')
require('parseconfig')
#require('./lib/parseconfig.rb')

begin
	myConfig = ParseConfig.new('demo.conf')
rescue Errno::ENOENT 
	puts "The config file you specified was not found"
	exit
rescue Errno::EACCES 
	puts "The config file you specified is not readable"
	exit
end

puts "Hello, my name is #{myConfig.get_value('name')}."
puts "I am #{myConfig.get_value('age')} years old, but will be #{myConfig.override_value('age', '22')} soon."
puts "I currently live at #{myConfig.get_value('address')}, and my slogan is \"#{myConfig.get_value('slogan')}\"."

