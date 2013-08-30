actions :enable, :disable

attribute :docroot, :default => true

def initialize(*args)
  super
  @action = :enable
end
