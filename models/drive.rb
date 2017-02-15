require 'active_record'
=begin
Drive:
ID gameID teamID startTime

Could also track overal stats for the drive
like starting position and ultimate outcome
=end

class Drive < ActiveRecord::Base
  belongs_to :game
  belongs_to :team
  has_many :play
  validates :game_id, presence: true
  validates :team_id, presence: true
  validates :starttime, presence: true
end
