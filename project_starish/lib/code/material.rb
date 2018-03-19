class Material
	attr_reader   :deleted_object, :vel_x, :vel_y, :deadly_hit,
				  :picked_up, :image_height, :image_width, :image
	attr_accessor :moving, :rotation, :useable, :deadly, :logic, :bounce,
				  :increase_velocity, :x, :y
	def initialize(image_path, background, player, screen_width, screen_height)
		@image = Gosu::Image.new(image_path)
		@player = player
		@background = background
		@screen_width = screen_width
		@screen_height = screen_height
		setup
	end 

	def setup 
		@x = 50
		@y = 50
		@vel_y = set_random_velocity
		@vel_x = set_random_velocity
		@angle = 0
		@top_speed = 10
		@acceleration = rand(1.0001..1.01)
		@time = 0
		@ttl = rand(15..30)
		@draw = true
		@update = true 
		@deleted_object = false
		@rotation = true
		@useable = false
		@deadly = false 
		@deadly_hit = false 
		@picked_up = false
		@moving = false
		@logic = true
		@bounce = false
		@increase_velocity = false
		@collision = false
	end		

	def set_random_velocity
		vel = rand(-4.0..4.0)
		if vel >= -0.1 && vel <= 0.1
			vel = set_random_velocity
		else 
			return vel 
		end 
	end

	def set_position(x,y)
		@x = x
		@y = y
	end 

	def generate_random_position_y
		return rand(@background.y..@background.image.height + @background.y)
	end 

	def generate_random_position_x 
		return rand(@background.x..@background.image.height + @background.x)
	end

	def set_random_position_screen 
		@x = rand(0..@screen_width)
		@y = rand(0..@screen_height)
	end 

	def set_position_to_random
		@x = generate_random_position_x 
		@y = generate_random_position_y 
	end 

	def set_position_to_center_screen
		@x = @screen_width / 2
		@y = @screen_height / 2
	end 
	
	def set_position_to_center_background
		@x = @background.image.width / 2 + @background.x
		@y = @background.image.height / 2 + @background.y
	end


	def collision_with_background
		if @x <= @background.x + @image.width
			if @bounce 
				@vel_x *= -1
			end 
			@x = @background.x + @image.width
		end
		if @x + @image.width >= @background.x + @background.image.width
			if @bounce 
				@vel_x *= -1
			end 
			@x = @background.x + @background.image.width - @image.width
		end 

		if @y + @image.height >= @background.y + @background.image.height
			if @bounce 
				@vel_y *= -1
			end 
			@y = @background.image.height + @background.y - @image.height
		end 
		if @y < @background.y + @image.height
			if @bounce 
				@vel_y *= -1
			end 
			@y = @background.y + @image.height
		end 
	end 
	def logic
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

	def check_if_collision
		if @x <= @player.x + @player.image.width &&
		   @x + @image.width >= @player.x && 
		   @player.y + @player.image.height >= @y &&
		   @player.y <= @y + @image.height

			if @useable 
				@picked_up = true 
			end 
			if  @deadly 
				@deadly_hit = true 
			end 
			@draw = false
			@update = false
			@deleted_object = true 
		end 
	end 

	def time 
		@time += 1
		if @time >= 60 
			@time = 0
			@ttl -= 1
		end 

		if @ttl <= 0 
			@deleted_object = true 
		end 
	end

	def update 
		if @rotation 
			@angle += 4
		end 
		if @logic
			 collision_with_background
		end 
		logic
		if @useable || @deadly
			check_if_collision
		end 
		if @moving && @collision == false
			@x += @vel_x 
			@y += @vel_y
		end

		if @increase_velocity 
			if @vel_x <= @top_speed &&
			   @vel_y <= @top_speed && 
			   @vel_y >= -@top_speed &&
			   @vel_x >= -@top_speed
				@vel_x *= @acceleration
				@vel_y *= @acceleration
			end
		end 
		
		if @update == false 
			return
		end  
		
		time 
	end 

	def inside_of_site
		if @x >= 0 && 
		   @y >= 0 && 
		   @x <= @screen_width && 
		   @y <= @screen_height
			return true
		else 
			return false 
		end  
	end 

	def draw
		if inside_of_site 
			@image.draw_rot(@x,@y,0,@angle)
		end 

		if @draw == false 
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