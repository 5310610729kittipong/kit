class Room < ActiveRecord::Base
  # attr_accessible :title, :body
  attr_accessible :roomname, :volume,  :first, :second, :third, :fourth, :fifth, :sixth, :day, :seventh, :eighth
  belongs_to :detail_rooms
  
  def self.all_times
    ["8.00-9.30","9.30-11.00", "11.00-12.30","12.30-13.00","13.30-15.00","15.00-16.30","16.30-18.00","18.00-21.00"]
  end

  def self.time_to_section
    ["8.00-9.30"=>"first","9.30-11.00"=>"second", "11.00-12.30"=>"third","12.30-13.00"=>"fourth","13.30-15.00"=>"fifth","15.00-16.30"=>"sixth","16.30-18.00"=>"seventh","18.00-21.00"=>"eighth"]
  end

  def self.all_days
    ["monday","tuesday","wednesday","thursday","friday","saturday","sunday"]
  end
end
