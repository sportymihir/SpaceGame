require 'gosu'
require './player'
require './star'
require './ZOrder'

class Tutorial < Gosu::Window

	def initialize
		super 640, 480
		self.caption = "Tutorial Game"
		@background_image = Gosu::Image.new("media/space.png", :tileable => true)
		
		@player = Player.new
		@player.warp(320, 240)

		@star_anim = Gosu::Image.load_tiles("media/star.png", 25, 25)
		@stars = Array.new
	end


	def update 
		if Gosu.button_down? Gosu::KB_LEFT or Gosu::button_down? Gosu::GP_LEFT
      		@player.turn_left
    	end
    	if Gosu.button_down? Gosu::KB_RIGHT or Gosu::button_down? Gosu::GP_RIGHT
      		@player.turn_right
    	end
    	if Gosu.button_down? Gosu::KB_UP or Gosu::button_down? Gosu::GP_BUTTON_0
     		@player.accelerate
		end
		@player.move
		@player.collect_stars(@stars)

    	if rand(100) < 4 and @stars.size < 25
     		@stars.push(Star.new(@star_anim))
    	end
  	end

	def draw
		@player.draw
		@background_image.draw(0, 0, 0)
		@stars.each { |star| star.draw}
	end

	def button_down(id)
		if id == Gosu::KB_ESCAPE
			close
		else
			super
		end
	end
end

Tutorial.new.show



