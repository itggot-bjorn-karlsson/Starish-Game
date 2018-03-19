class Background
	attr_reader :image, :x, :y, :vel_x, :vel_y,
				:right_edge, :left_edge, :top_edge, 
				:lower_edge
	attr_accessor :move_down, :move_up, :move_left, :move_right,
				  :moving, :current_direction
	def initialize(image_path, screen_width, screen_height)
		@screen_width = screen_width
		@screen_height = screen_height
		@image = Gosu::Image.new(image_path)
		@x = 0 
		@y = 0
		setup
	end 

	def setup 
		@vel_x = 7
		@vel_y = 7
		
		@current_direction = false
		@moving = false
		@move_right = false 
		@move_left = false 
		@move_up = false 
		@move_down = false 

		@right_edge = -@image.width + @screen_width
		@lower_edge = -@image.height + @screen_height
		@left_edge = 0
		@top_edge = 0
	end

	def check_screen
		if @x >= 0
			@x = 0
		end
		if @y >= 0 
			@y = 0 
		end 
		if @x <= -@image.width + @screen_width
			@x = -@image.width + @screen_width
		end 
		if @y <= -@image.height + @screen_height
			@y = -@image.height + @screen_height
		end 
	end 

	def move_screen
		if @move_right 
			@x -= @vel_x
		end 
		if @move_left 
			@x += @vel_x
		end 
		if @move_up 
			@y += @vel_y
		end 
		if @move_down 
			@y -= @vel_y
		end 
	end 

	def update
		check_screen
		move_screen
	end 

	def draw 
		@image.draw(@x,@y,0)
	end 
end 