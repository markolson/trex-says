require 'rubygems'
require 'bundler'
Bundler.setup
require 'nokogiri'


"<transcriptions>
        <transcription>
                <url>qwantz.com/index.php?comic=1</url>
                <title>today is a beautiful day</title>
                <body>
                        <panel>
                                <line>T-Rex: Today is a beautiful day to be stomping on things! As a dinosaur, stomping on things is the best part of my day, indeed!</line>
                                <line>T-Rex: *gasp*</line>
                                <line>T-Rex: What&apos;s that, little house? You wish you were back in your own time? THAT IS TOO BAD FOR YOU</line>
                                <line>T-Rex: Perhaps you too will get a stomping, little girl!</line>
                                <line>Utahraptor: WAIT!</line>
                                <line>Utahraptor: Is stomping really the answer to your problem(s)?</line>
                                <line>T-Rex: Problem(s)?</line>
                                <line>T-Rex: My only problem(s) have to do with you interrupting my stomping!</line>
                                <line>T-Rex: (in small text) crazy utahraptor!</line>
                        </panel>
                </body>
        </transcription>
        <transcription>
"

require 'db'

doc = Nokogiri::HTML(open('data/everywordindinosaurcomicsOHGOD.xml'))

i = 0
doc.css('transcription').each do |c|
  title = c.css('title').first.content if c.css('title').first
  c.css('url').first.content =~ /comic\=(\d+)/
  id = $1
  p title
  unless comic = Comic.get(id)
    comic = Comic.new(:title => title, :id => id)
    comic.save
  end
  lines = c.css('line').each{|line|
    line.content =~ /^([\w-]+): (.+)$/
    p $1
    p $2
    line = Line.new(:comic_id => id, :dude => $1, :line => $2)
    line.save
  }
  i += 1
end