# require_relative 'models/event'
#
# ActiveRecord::Base.establish_connection(
#   :adapter  => 'mysql2',
#   :database => 'test',
#   :username => 'root',
#   :password => 'root',
#   :host     => 'localhost',
#   :port     => '8889')
#
# event = Event.create(downdist: "blah blah", description: "argh this is terrible")

#require_relative 'models/event'
#event = Event.create(downdist: "blah blah", description: "argh this is terrible")

require_relative 'config/boot'
require_relative 'models/team'
require_relative 'models/game'
require_relative 'models/drive'
require_relative 'models/play'


# Look up by name of the school, create if it doesn't exist
home = Team.find_or_create_by(school: 'Knox')
road = Team.find_or_create_by(school: 'Monmouth')

#game = Game.find_or_create_by(home_id: home.id, road_id: road.id, home_score: 10, road_score: 12, date: '20161015', gamecode: 'wxyz')
game = Game.find_by(gamecode: 'wxyz')

drive = Drive.find_or_create_by(game: game, team: home, starttime: '15:00')

play = Play.find_or_create_by(drive: drive, playnum: 1, down: 1, distance: 10, quarter: 1, location: 29, description: "Spacco passed to Dooley for 17 yards (Bunde)")

play = Play.find_or_create_by(drive: drive, playnum: 1, down: 1, distance: 10, quarter: 1, location: 25, description: "Dooley passes to Spacco for 37 yards")
