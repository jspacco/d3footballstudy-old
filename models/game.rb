require 'active_record'
=begin
Game:
ID hometeamID visitingteamID date score
=end

class Game < ActiveRecord::Base
  has_one :team, foreign_key: "home_id"
  has_one :team, foreign_key: "road_id"

  validates :home_id, presence: true
  validates :road_id, presence: true
  validates :home_score, presence: true
  validates :road_score, presence: true
  validates :date, presence: true
  validates :gamecode, presence: true
end
