require 'spec_helper'
describe 'windows_mysql' do
  context 'with default values for all parameters' do
    it { should contain_class('windows_mysql') }
  end
end
