require 'rubygems'
require 'nokogiri'

require_relative 'config/boot'
require_relative 'models/team'
require_relative 'models/game'
require_relative 'models/drive'
require_relative 'models/play'
require_relative 'models/punt'
require_relative 'models/goforit'
require_relative 'models/field_goal'


def normalize(str)
  return str.gsub(/(\n\r)|\s+/, ' ').strip
end

def processPlayByPlay(filename)
  page = Nokogiri::HTML(open(filename))
  puts page.class
  # search for the table rows using a JQuery-like syntax
  page.css('tr.odd, tr.even').each do |e|
    # check if there is a "summary bold" class
    summary = e.css('td[class="summary bold"]')
    if summary.length == 1
      # This happens at the end of a drive!
      puts summary.text
    else
      # get first td, which is down/distance
      # then second td, which is event
      downdist=normalize(e.css('td')[0].text)
      event=normalize(e.css('td')[1].text)
      printf("%s => %s\n", downdist, event)
      # TODO: all of the work processing the down-and-distance
      # and the event and convert it into model classes to put into
      # the database.
      #
      # Example of regex matching to find the down and distance
      # 1st and 10 at KC25
      m = downdist.match(/(^.*) and (\d+) at ([A-Z]+\d+)/i)
      if m != nil
        down, dist, loc = m.captures
        p down, dist, loc
      end

      # OK, now process all of the events, such as:
      # N. Edlund rush for 3 yards to the KC28 (Dakotah Jones).
      # We are going to try to match them with a regexp, one at a time
      m = event.match(/.* rush for (\d+) yards to the ([A-Z]+\d+) .*/i)
      if m != nil
        yards, location = m.captures
        # TODO: put into the database
        p yards, location
        # next is like continue in Java
        next
      end
      # and now we need a bunch more regexps

    end
  end
end

def main
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

end

if __FILE__ == $0
  # test on only ony play-by-play record at a time
  # comment this out when you want to process records in bulk
  processPlayByPlay('play-by-play/2016/Knox/20161015_m72v.xml')

  # Use main to run through all data that we have
  #main
end
