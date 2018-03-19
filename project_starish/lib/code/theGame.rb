
class MyGame < Gosu::Window 
	def initialize(width, height, fullscreen)   # Method in MyGame,					initialize the class
		@width = width 						    # new int,				 			width of the screen				
		@height = height 						# new int,					    	height of the screen
		super(@width, @height, fullscreen) 	 	# super method in Gosu::Window,     generate window bu height and width
		render 									# Method in MyGame, 		 		call for render method to render the map assets and objects
		setup 									# Method in MyGame, 		 		call for setup method to generetate logic, positions, bools etc for the objects, assets and map
	end
	
	def render 
		@assets = Assets.new 																	# creating a new Assets object (class found in assets.rb)
		@background = Background.new(@assets.st_background_model, @width, @height) 				# creating background (class found in background.rb)
		@node = Node.new(@background.image.width, @background.image.height, 35)									    # create node for debug options (class found in node.rb)
		@player = Entity.new(@assets.st_entity_model, @background, @width, @height) 			# creating an entity object for the player (class found in entity.rb)
		@text = Gosu::Font.new(400, options = {}) 												# text recives a Font from the Gosu class 
	end  

	def setup 
		@player.movement = true         # Method in Entity,		player can move
		@player.logic_background = true # Method in Entity, 	player can not move out of backgrounds edges
		@player.logic_screen = true     # Method in Entity,	    player can not move out of screen
		@player.set_position(100,100)   # Method in Entity,     recives a position, no vector
		@seconds_goal = 60 * 2 			# new int, 				the seconds goal
		@time = 0 						# new int, 				current time 
		@seconds = 0 					# new int,  			current seconds
		@amount_of_stars = 10 			# new int, 				how many stars that should be created at once 
		@collected = 0 					# new int,  			how many starts that has been collected
		@hp = 3							# new int				Health for the player
		@game_over = false 				# new bool, 			game loop
		@stars = Array.new 				# new Array,			stars generates a new Array
	end 

	def button_up(id)							# Method in MyGame,		     check for key release
		if id == Gosu::KbLeft 					# if,          				 key released Left arrow?
			@background.move_left = false		# bool in Background,	 	 cant move left
			@background.moving = false			# bool in Background, 		 cant move
		end 
		if id == Gosu::KbRight 					# if,						 key released Right arrow?
			@background.move_right = false		# bool in Background, 		 cant move right
			@background.moving = false			# bool in Background,		 cant move
		end 
		if id == Gosu::KbUp						# if,						 key released Up arrow?
			@background.move_up = false			# bool in Background,		 cant move up
			@background.moving = false 			# bool in Background,		 cant move
		end 
		if id == Gosu::KbDown 					# if, 						 key released Down arrow?
			@background.move_down = false		# bool in Background,		 cant move down
			@background.moving = false			# bool in Background, 		 cant move
		end 

		if id == Gosu::KbW 						# if,						 key released W
			@player.move_up = false 			# bool in Entity,			 cant move up		 
		end 
		if id == Gosu::KbS						# if, 						 key released S
			@player.move_down = false 			# bool in Entity, 			 cant move down
		end 
		if id == Gosu::KbD						# if,						 key released D
			@player.move_right = false 			# bool in Entity,			 cant move right
		end 
		if id == Gosu::KbA						# if,						 key released A
			@player.move_left = false 			# bool in Entity,			 cant move left
		end 
	end 

	def button_down(id)									# Method in MyGame, 	     check for key pressed
		if id == Gosu::KbEscape 						# if,						 key pressed Esc
			close										# Method in Gosu::Window 	 closes the window and exits the game
		end 
		if id == Gosu::KbLeft 							# if, 						 key pressed Left arrow
			@background.move_left = true				# bool in Background,	     can move left
			@background.moving = true 					# bool in Background,		 can move 
		end 
		if id == Gosu::KbRight 							# if,						 key pressed Right arrow
			@background.move_right = true 				# bool in Background,		 can move right
			@background.moving = true 					# bool in Background,		 can move
		end 
		if id == Gosu::KbUp								# if,						 key pressed Up arrow
			@background.move_up  = true 				# bool in Background,		 can move up
			@background.moving = true 					# bool in Background,		 can move
		end 
		if id == Gosu::KbDown 							# if,						 key pressed Down arrow
			@background.move_down = true 				# bool in Background,		 can move down
			@background.moving = true 					# bool in Background,		 can move
		end
		if id == Gosu::KbW 								# if,						 key pressed W
			@player.move_up = true						# bool in Entity,			 can move up
		end 
		if id == Gosu::KbS								# if,						 key pressed S
			@player.move_down = true					# bool in Entity,			 can move down
		end 
		if id == Gosu::KbD								# if,						 key pressed D
			@player.move_right = true					# bool in Entity,			 can move right
		end 
		if id == Gosu::KbA								# if, 						 key pressed A
			@player.move_left = true					# bool in Entity,		     can move left
		end  
	
		if id == Gosu::KbSpace && @game_over == true    # if and if,				 key pressed Space and game over is true
			setup 										# Method in MyGame,			 Restart
		end 
	end 

	def deadly_star(x,y)																     # Method in MyGame, 2 int arguments, 	create deadly stars
		x_pos = x 																			 # new int,  	    	 recive argument x
		y_pos = y																			 # new int, 			 recive argument y
		star = Material.new(@assets.st_material_model,@background, @player, @width, @height) # create a new star from Material class (class found in Material.rb)
		star.set_position(x_pos, y_pos)														 # Method in Material,	 set position for Material object
		star.bounce = true																     # bool in Material,	 can bounce on wall	
		star.moving = true																	 # bool in Material,	 can move	
		star.logic = true																	 # bool in Material, 	 has logic
		star.increase_velocity = true														 # bool in Material, 	 accelerate
		star.deadly = true																	 # bool in Material,	 is deadly
		@stars << star																		 # @stars Array,		 recives the Material obejct
	end 

	def update																	 			# Method in MyGame, 	 The game loop
		@background.update														    		# Method in Background,  updates the background
		@player.update																		# Method in Entity,		 updates the player
		i = 0																				# new int,			     index
		while i < @stars.length																# while, 				 loop through @stars
			if @stars[i].deleted_object == true 											# if,					 deleted_object in Material is true
				@stars.delete_at(i)															# Method in Array,		 delete element at index
			end 
			i += 1																			# index++
		end 

		if @time >= @seconds_goal && @game_over == false									# if,					 60 frames has passed
			x_pos = rand(@background.x..@background.image.width + @background.x)			# new int,				 random value between background.x and background.width + background.y
			y_pos = rand(@background.y..@background.image.height + @background.y) 			# new int, 				 random value between background.y and background.height + background.y
			@amount_of_stars.times do |_|													# each ,				 loop with amount of stars 	 
				deadly_star(x_pos,y_pos)													# Method in MyGame,		 create a new deadly star
			end 
			@seconds += 1																	# @seconds int,			 1 second has passed
			@time = 0																		# new int,				 reset frame counter
		end

		@stars.each do |star|																# each,					 star in stars
			star.update																		# Method in Material,	 updates the star
			if star.deadly_hit == true														# if,					 star hit Entity object
				@hp -= 1																	# health--,				 lose 1 health
				if @hp == 0																	# if,					 health is 0
					@game_over = true														# edit bool,			 game over is true
					@player.movement = false												# bool in Entity,		 cant move
					@stars.each do |star|													# each,					 star in stars
						star.moving = false 												# bool in Material,		 cant move
					end 
					@hp = 0																	# edit int,				 health cant --
				end 
			end 
		end 
		@time += 1																			# time++,				 1 frame has passed
	end 

	def draw																			# Method in MyGame,			 loop, drawing
		@background.draw 																# Method in Background,		 draw background
		@player.draw															# Method in	Entity,			 draw_rotaional player
		@node.draw																		# Method in Node,			 draw node (debug)
		@stars.each do |star|															# each,						 star in stars
			star.draw																# Method in Material,		 draw_rotaional
			if $debug 																	# if,					     debug mode
				draw_line(star.x,star.y, 0xff_00ffff,@player.x, @player.y, 0xff_00ffff) # Method in Gosu::Window, 	 draw a line from star to player object
			end 
		end 
		
		@text.draw(@hp,@width / 2 - 35,0,0, 0.1, 0.1)								    # method in Gosu::Font,		 draw health
		if @game_over 																	# if,						 game over is true
			@text.draw("Game Over", 0, 0, 0.4, 0.4)										# method in Gosu::Font,		 draw game over
		end 
	end 
	
end 