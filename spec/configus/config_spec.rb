require 'spec_helper'

describe Configus::Config do
  before do
    @options = {
      :foo => 'bar',
      :sections => {
        :first => 'first_value',
        :second => 'second_value',
        :another_key => {
          :key => :value
        }
      },
      :pairs => { :pkay => "vkay" },
      :as_is => { :pkay => "vkay", :configus_leave_as_is => true }
    }
    @config = Configus::Config.new(@options)
  end

  it 'should be defined' do
    @config.foo == @options[:foo]
    @config.sections.first == @options[:sections][:first]
  end

  it 'should be raise' do
    lambda {@config.doesnt_exist}.should raise_error(RuntimeError)
  end

  it 'should be available as hash' do
    @config[:foo] == @options[:foo]
    @config[:sections].second == @options[:sections][:second]
  end

  it 'should be transformable to hash' do
    @config.to_hash.should == @options
  end

  it 'should pass each key-value pair' do
    @config.pairs.each_pair { |key, value| } == @options[:pairs].each_pair { |key, value| }
  end

  it 'should support configus_leave_as_is' do
    @config.as_is.class == 'Hash'
    @config.as_is.count == 1
  end

end

