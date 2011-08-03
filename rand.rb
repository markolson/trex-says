require 'rubygems'
require 'bundler'
Bundler.setup
require 'twitter'

require 'config.rb'
require 'db.rb'

exit unless rand(75) == 1

oauth = Twitter::OAuth.new(CONSUMER_KEY, CONSUMER_SECRET)
oauth.authorize_from_access(ACCESS_KEY, ACCESS_SECRET)
client = Twitter::Base.new(oauth)

sql = 'select * from lines where length(line) < 140 and  dude="T-Rex" and (like("Hey, %", line) or like("Man, %", line) or like("Guys%", line) or like("Dude%", line) or like("I am%", line)) order by random() limit 1'
line = repository(:default).adapter.select(sql).first
p line.line
p client.update("#{line.line}")
