# Author::      BJ Dierkes <wdierkes@5dollarwhitebox.org>
# Author::      Jesse Newland <jesse@railsmachine.com>
# Copyright::   Copyright (c) 2006,2007 5dollarwhitebox.org
# Copyright::   Copyright (c) 2008 RailsMachine
# License::     GPL
# URL::         http://www.5dollarwhitebox.org
# URL::         http://www.railsmachine.com
#

# This class was written to simplify the parsing of configuration
# files in the format of "param = value".


class ParseConfig

  Version = '0.4.2'

  # Initialize the class with the path to the 'config_file'
  # The config file is parsed into a hash.
  def initialize(config_file)
    @config_file = config_file
    raise Errno::EACCES, "#{@config_file} is not readable" unless File.readable?(@config_file)
    @hash = {}
    section = nil
    open(@config_file).each { |line|
      line.chomp
      unless (/^\#/.match(line))
        if line =~ /\s*\[(.*)\]\s*/
          section = $1
          @hash[section] = {}
        end
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
          if section.nil?
            @hash[var_name] = new_value
          else
            @hash[section][var_name] = new_value
          end
        end
      end
    }
  end

  def [](key)
    @hash[key]
  end


end
