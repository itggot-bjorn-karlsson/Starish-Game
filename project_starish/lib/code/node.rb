class Node
	def initialize(width, height, space)
		@nodes = []
		@space = space
		@width = width
		@height = height 
		@width.times do |_|
			@nodes << Array.new(@height)
		end 
	end 

	def show 
		p @nodes
	end 

	def draw
		if $debug
			i = 0
			while i < @nodes.length 
				Gosu.draw_line(i * @space, 0, 0xff_00ffff, i * @space, @height, 0xff_00ffff)
				Gosu.draw_line(0, i * @space, 0xff_00ffff, @width, i * @space, 0xff_00ffff)
				i += 1
			end 
		end
	end 

end 
