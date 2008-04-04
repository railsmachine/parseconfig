# Author::      BJ Dierkes <wdierkes@5dollarwhitebox.org> 
# Copyright::   Copyright (c) 2006,2007 5dollarwhitebox.org 
# License::     GPL
# URL::         http://www.5dollarwhitebox.org
# 

# This class was written to simplify the parsing of configuration
# files in the format of "param = value".  Please review the 
# demo files included with this package.
#
# For further information please refer to the './doc' directory
# as well as the ChangeLog and README files included.
#

class ParseConfig
  
  Version = '0.4.2'

  # Initialize the class with the path to the 'config_file'
  # The config file is parsed into a hash.
  def initialize(config_file)
    @config_file = config_file
    raise Errno::EACCES, "#{@config_file} is not readable" unless File.readable?(@config_file)
    @hash = {}
    open(@config_file).each { |line| 
      line.chomp
      unless (/^\#/.match(line))
        if(/\s*=\s*/.match(line))
          param, value = line.split(/\s*=\s*/, 2)  
          var_name = "#{param}".chomp.strip
          value = value.chomp.strip
          new_value = ''
          if (value)
            if value =~ /^['"](.*)['"]$/
              new_value = $1
            else
              new_value = value
            end
          else
            new_value = ''
          end
          @hash[var_name] = new_value
        end
      end
    }
  end

  def [](key)
    @hash[key]
  end

  
end
