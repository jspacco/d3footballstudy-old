require 'active_record'
class Event < ActiveRecord::Base
  # THIS IS A TEST CLASS
  # you will have to change this
  # I guarantee that if you try to use this class, your code will never work properly
  validates :downdist, presence: true
  validates :description, presence: true, length: { minimum: 5 }
end
