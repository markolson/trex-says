require 'data_mapper'
require  'dm-migrations'
DataMapper.setup(:default, 'sqlite:///home/syntaxin/qwantz-corpus/data/qwantz.db')

class Comic
  include DataMapper::Resource

  property :id,         Serial    # An auto-increment integer key
  property :title,      String    # A varchar type string, for short strings
end

class Line
  include DataMapper::Resource
  belongs_to :comic
  property :id,         Serial    # An auto-increment integer key
  property :dude,       String, :index => true 
  property :line,       String, :length => 500 
end
DataMapper.finalize
#DataMapper.auto_migrate!
DataMapper.auto_upgrade!
