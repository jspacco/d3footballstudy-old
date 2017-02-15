require 'active_record'
=begin

DATA MODEL

Team:
ID name

Game:
ID homeID roadID date score

Drive:
ID gameID teamID startTime

Play:
ID driveID down distance quarter location description playnum
=end

class Play < ActiveRecord::Base
  belongs_to :drive
  validates :playnum, presence: true
  #add_index :driveplay, [:drive_id, :playnum], unique: true
  validates :down, presence: true
  validates :distance, presence: true
  validates :quarter, presence: true
  validates :location, presence: true
  validates :description, presence: true
end
