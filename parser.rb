require 'rubygems'
require 'nokogiri'

require_relative 'models/event'
require_relative 'config/boot'

def normalize(str)
  return str.gsub(/(\n\r)|\s+/, ' ').strip
end

def processPlayByPlay(filename)
  page = Nokogiri::HTML(open(filename))
  puts page.class
  page.css('tr.odd, tr.even').each do |e|
    # check if there is a "summary bold" class
    summary = e.css('td[class="summary bold"]')
    if summary.length == 1
      puts summary.text
    else
      # get first td, which is down/distance
      # then second td, which is event
      downdist=normalize(e.css('td')[0].text)
      event=normalize(e.css('td')[1].text)
      printf("%s => %s\n", downdist, event)
      # TODO: all of the work processing the down-and-distance
      # and the event and convert it into classes to put into
      # the database.
    end
  end
end

if __FILE__ == $0
  root='play-by-play'
  Dir[root+'/2016/*'].each do |team|
    puts team
  end
  ['2016', '2015', '2014', '2013', '2012', '2011'].each do |year|
    puts year
    Dir[root+'/'+year].each do |team|
      puts team
      Dir[root+'/'+year+'/'+team].each do |file|
        puts file
        processPlayByPlay(root+'/'+year+'/'+team+'/'+file)
      end
    end
  end

  #processPlayByPlay('play-by-play/2016/Knox/20161015_m72v.xml')
end
