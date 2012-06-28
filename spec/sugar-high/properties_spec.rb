require 'spec_helper'
require 'sugar-high/properties'

class CruiseShip
  extend Properties

  property :direction
  property :speed, is(0..300)
end

describe 'Properties pack' do
  let (:ship) { CruiseShip.new }

  before do
    ship.add_direction_listener(lambda {|x| puts "Oy... someone changed the direction to #{x}"})
  end

  it 'should listen and react when changing direction' do
    ship.direction = "north"
  end

  it 'should listen and react when changing speed' do
    ship.add_speed_listener(lambda {|x| puts "Oy... someone changed the speed to #{x}"})
    ship.add_speed_listener(lambda {|x| puts "Yo, dude... someone changed the speed to #{x}"})
  end

  it 'should reflect on speed settings if in range or not' do
    ship.speed = 200
    ship.speed = 300
    ship.speed = 301
    ship.speed = -1
    ship.speed = 2000

    puts ship.direction
    puts ship.speed
  end

  it 'should remove listener' do
    ship.remove_speed_listener(1)
    ship.speed = 200
    ship.speed = 350

    puts ship.direction
    puts ship.speed
  end
end


