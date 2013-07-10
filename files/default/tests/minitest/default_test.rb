require 'minitest/spec'

describe_recipe 'nginx::default' do

  describe 'services' do
    it 'makes sure nginx is running' do
      service('nginx').must_be_running
      service('nginx').must_be_enabled
    end
  end

end
