class Entity
	attr_reader :x, :y, :image, :deleted_object
	attr_accessor :movement,  :logic_screen,
				  :logic_background, :rotation,:move_right,
				  :move_left, :move_up, :move_down
	def initialize(image_path, background, screen_width, screen_height)
		@screen_height = screen_height
		@screen_width = screen_width
		@background = background
		@image = Gosu::Image.new(image_path)
		@vel_x = 5
		@vel_y = 5
		setup
	end 

	def setup
		@collision = false
		@logic_screen = false 
		@logic_background = false
		@movement = false 
		@rotation = false 
		@move_right = false 
		@move_left = false 
		@move_up = false 
		@move_down = false 
		@deleted_object = false 
		@angle = 0
		@rotation_speed = 5
		@x = 10
		@y = 10
	end 

	def set_position(x,y)
		@x = x
		@y = y 
	end 

	def set_position_to_center
		@x = @screen_width / 2
		@y = @screen_height / 2
	end 

	def check_logic_with_background
		if @x <= @background.x + @image.width
			@x = @background.x + @image.width
		end
		if @x + @image.width >= @background.x + @background.image.width
			@x = @background.x + @background.image.width - @image.width
		end 

		if @y + @image.height >= @background.y + @background.image.height
			@y = @background.image.height + @background.y - @image.height
		end 
		if @y < @background.y + @image.height
			@y = @background.y + @image.height
		end 
	end 

	def check_logic_with_screen 
		if @x <= 0 + (@image.width / 2)
			@x = 0 + (@image.width / 2)
		end 
		if @x >= @screen_width - (@image.width / 2)
			@x = @screen_width - (@image.width / 2)
		end 

		if @y <= 0 + (@image.height / 2)
			@y = 0 + (@image.height / 2)
		end 
		if @y >= @screen_height - (@image.height / 2)
			@y = @screen_height - (@image.height / 2)
		end 
	end 

	def check_movement
			if @move_right
				@x += @vel_x
			end 
			if @move_left 
				@x -= @vel_x
			end 
			if @move_down 
				@y += @vel_y 
			end 
			if @move_up 
				@y -= @vel_y
			end 
	end 

	def join_background

		if @background.move_right 
			if @background.x >= @background.right_edge
				@x -= @background.vel_x 
			end
		end 
		if @background.move_left 
			if @background.x <= @background.left_edge 
				@x += @background.vel_x
			end 
		end 
		if @background.move_up 
			if @background.y <= @background.top_edge 
				@y += @background.vel_y
			end
		end
		if @background.move_down
			if @background.y >= @background.lower_edge 
				@y -= @background.vel_y
			end
		end   
	end 
	
	def update
		join_background
		if @movement
			check_movement
		end 
			
		if @logic_background
			check_logic_with_background
		end 

		if @logic_screen
			check_logic_with_screen
		end 

		if @deleted_object 
			return 
		end 		
	end 

	def draw
		@image.draw_rot(@x,@y,0, @angle)
		if @deleted_object 
			return 
		end 

		draw_debug
	end 

	def draw_debug
		if $debug 
		    Gosu.draw_line(@x - @image.width, @y - @image.height, 0xff_00ffff, @x - @image.width, @y + @image.height, 0xff_00ffff)
			Gosu.draw_line(@x - @image.width, @y - @image.height, 0xff_00ffff, @x + @image.width, @y - @image.height, 0xff_00ffff)
			Gosu.draw_line(@x - @image.width, @y + @image.height, 0xff_00ffff, @x + @image.width, @y + @image.height, 0xff_00ffff)
			Gosu.draw_line(@x + @image.width, @y - @image.height, 0xff_00ffff, @x + @image.width, @y + @image.height, 0xff_00ffff)		
		end 
	end 
end 