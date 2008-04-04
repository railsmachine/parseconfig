require File.dirname(__FILE__) + '/spec_helper.rb'

describe 'ParseConfig' do

  describe 'being initialized' do

    it 'should require config file variable' do
      lambda do
        @config = ParseConfig.new()
      end.should raise_error(ArgumentError)
    end

    it 'should require a readable config file' do
      lambda do
        @config = ParseConfig.new('foo')
      end.should raise_error(Errno::EACCES)
    end

  end

  describe 'parsing a simple config file' do

    before(:each) do
      @config = ParseConfig.new(File.dirname(__FILE__) + '/conf/simple.conf')
    end

    it 'should map the config keys to a hash' do
      @config['key1'].should == 'val1'
      @config['key2'].should == 'val2'
    end

    it 'should handle values with spaces' do
      @config['key3'].should == 'this is a value with spaces, and it may work!'

    end

    it 'should handle quoted values' do
      @config['single_quotes'].should == '5555 North South 77th street'
      @config['double_quotes'].should == "I ain't no fool"
    end

    it 'should handle keys with spaces' do
      @config['key with spaces'].should == 'wahoo'
    end

  end

end