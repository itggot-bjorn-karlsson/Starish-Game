class Assets < Gosu::Window
	attr_reader :st_material_model, :st_background_model, :st_player_model, :st_entity_model,
				:player_models, :entity_models, :background_models, :ui_models
				
	def initialize
		# @player_paths = Dir["C:/Users/bjorn.karlsson3/Desktop/ruby/gosu_projects/bjornsEngine/assets/player_models/*.bmp"].each {|file| file }
		# @entity_paths = Dir["C:/Users/bjorn.karlsson3/Desktop/ruby/gosu_projects/bjornsEngine/assets/entity_models/*.bmp"].each {|file| file }
		# @background_paths = Dir["C:/Users/bjorn.karlsson3/Desktop/ruby/gosu_projects/bjornsEngine/assets/background_models/*.bmp"].each {|file| file }
		# @ui_paths = Dir["C:/Users/bjorn.karlsson3/Desktop/ruby/gosu_projects/bjornsEngine/assets/ui_models/*.bmp"].each {|file| file }
		# st: Standard
		@player_models = []
		@entity_models = []
		@background_models = []
		# @ui_models = []
		Dir.chdir("../../assets")
		define_st_models
		# define_models
	end 

	def define_st_models
		@st_material_model = "st_material_model.bmp"
		# @st_player_model = Gosu::Image.new('C:/Users/bjorn.karlsson3/Desktop/ruby/gosu_projects/bjornsEngine/assets/st_player_model.bmp')
		@st_entity_model = "st_entity_model.bmp" 
		@st_background_model = "st_background_model.bmp"
	end 
end 