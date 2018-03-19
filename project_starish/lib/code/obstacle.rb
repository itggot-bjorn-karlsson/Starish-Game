class Obstacle 
    def initialize(image_path, screen_width, screen_height, background)
        @image = Gosu::Image.new(image_path)
        @screen_width = screen_width
        @screen_height = screen_height
        setup
    end 

    def setup 
        @x = nil
        @y = nil
        @x_vel = nil 
        @y_vel = nil
    end

    def warp(x,y)
        @x, @y = x, y 
    end 

    def warp_velocity(x_speed, y_speed)
        @x_vel = x_speed 
        @y_vel = y_speed
    end 
    def update 
        
    end 

    def draw 
        @image.draw(@x,@y,0)
    end 
end 
