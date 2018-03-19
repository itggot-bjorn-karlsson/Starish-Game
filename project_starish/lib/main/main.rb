require 'gosu'

Dir.chdir("..")
Dir.chdir("code")
cwd = Dir.pwd
Dir[cwd + "/*.rb"].each {|file| require file }

def main 
	$debug = false
	MyGame.new(1000,2000,false).show
end 

main


