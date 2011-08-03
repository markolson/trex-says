require 'rubygems'
require 'bundler'
Bundler.setup
require 'twitter'

require 'config.rb'
require 'db.rb'

oauth = Twitter::OAuth.new(CONSUMER_KEY, CONSUMER_SECRET)
oauth.authorize_from_access(ACCESS_KEY, ACCESS_SECRET)
client = Twitter::Base.new(oauth)

time = File.mtime('lastupdate')
f = File.open('lastupdate', 'a'){|f| f.puts ' '}


client.mentions.each { |m|
  at = DateTime.parse(m.created_at)
  #line = Comic.first(:order => "RANDOM()")

  if(at > DateTime.parse(time.to_s)) #this mention is newer than our last run
    #in_reply_to_status_id
    len = m.user.screen_name.length + 2
    line = repository(:default).adapter.select('SELECT * FROM lines where dude="T-Rex" and length(line) < ? ORDER BY RANDOM() LIMIT 1', [140 - len]).first

    next if m.user.screen_name == 'trexsez'
    next if m.user.screen_name == 'qwantz_dev'
    p "@#{m.user.screen_name} #{line.line}"
    p client.update("@#{m.user.screen_name} #{line.line}", :in_reply_to_status_id => m.id)
  end
}
