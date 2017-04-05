require 'spec_helper'
describe 'srechallenge' do

  context 'with defaults for all parameters' do
    it { should contain_class('srechallenge') }
  end
end
