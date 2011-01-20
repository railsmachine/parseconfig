require File.dirname(__FILE__) + '/spec_helper.rb'

describe 'ParseConfig' do

  describe 'being initialized' do

    it "should not require a file variable" do
      lambda do
        @config = ParseConfig.new()
      end.should_not raise_error(Errno::EACCES)
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
      @config.params['key1'].should == 'val1'
      @config.params['key2'].should == 'val2'
    end

    it 'should handle values with spaces' do
      @config.params['key3'].should == 'this is a value with spaces, and it may work!'
    end

    it 'should handle quoted values' do
      @config.params['single_quotes'].should == '5555 North South 77th street'
      @config.params['double_quotes'].should == "I ain't no fool"
    end

    it 'should handle keys with spaces' do
      @config.params['key with spaces'].should == 'wahoo'
    end

  end

  describe 'parsing a config file with headers' do

    before(:each) do
      @config = ParseConfig.new(File.dirname(__FILE__) + '/conf/with_headers.conf')
    end

    it 'should handle top level keys just fine' do
      @config.params['key1'].should == 'val1'
      @config.params['key2'].should == 'val2'
    end

    it 'should create a nested hash for config file sections' do
      @config.params['section1'].should_not be_nil
      @config.params['section2'].should_not be_nil
    end

    it 'should set the values specified in those sections' do
      @config.params['section1']['sec1_key1'].should == 'sec1_val1'
      @config.params['section1']['sec1_key2'].should == 'sec1_val2'
    end

    it 'should handle duplicate keys' do
      @config.params['section2']['key1'].should == 'val1'
      @config.params['section2']['key2'].should == 'val2'
    end

  end

  describe 'parsing a config file with headers and inheritence' do
    before(:each) do
      @config = ParseConfig.new(File.dirname(__FILE__) + '/conf/with_headers_inheritence.conf')
    end

    it 'should create a nested hash for config file sections' do
      @config.params['section1'].should_not be_nil
      @config.params['section2'].should_not be_nil
    end

    it 'should set the values specified in those sections' do
      @config.params['section1']['sec1_key1'].should == 'sec1_val1'
      @config.params['section1']['sec1_key2'].should == 'sec1_val2'
    end

    it 'should handle duplicate keys' do
      @config.params['section2']['key1'].should == 'val1'
      @config.params['section2']['key2'].should == 'val2'
    end

    it 'should support inheritence' do
      @config.params['section2']['sec1_key1'].should == 'sec1_val1'
      @config.params['section2']['sec1_key2'].should == 'sec1_val2'
    end
  end

  describe 'creating a config file.' do
    before(:each) do
      @config = ParseConfig.new
    end

    it "should add a group if hash given" do
      @config.add('production', {})
      @config.groups.should include('production')
    end

    it "should allow inheritence" do
      @config.add('production', {})
      @config.add('development', {})
      @config.inherit 'development', 'production'

      @config.inheritence.should include 'development'
      @config.inheritence['development'].should == 'production'
    end
  end

end