require 'active_record'

class Team < ActiveRecord::Base
  validates :school, presence: true
end
