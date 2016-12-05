# Gems required
require 'console_splash'
require 'colorize'

#Splash page (requires enter to continue)
def splash_page(width, height)
  splash = ConsoleSplash.new(25,40)
  splash.write_header("Flood-it", "Tomas Goldsack", "0.1")
  splash.write_center(-4, "<Press enter to continue>")
  splash.write_horizontal_pattern("*")
  splash.write_vertical_pattern("*")
  splash.splash
  enter = gets
  if enter == "\n"
    home_page(width, height)
  else 
    splash_page(width, height)
  end
end 

def home_page(width, height)
  puts "MAIN MENU:"
  puts "s = Start game"
  puts "c = Change size"
  puts "q = Quit"
  print "Please enter your choice: "
  choice = gets.chomp.downcase
    if choice == "s"
       get_board(width, height)
    elsif choice == "c"
       change_size(width, height)
    elsif choice == "q"
       exit
    else 
       home_page(width, height)
    end
end

def get_board(width, height)
  board = Array.new(height){ Array.new(width)}
  #define all symbols in an array of colors
  String.disable_colorization = false # enable colorization
  red = "  ".colorize( :background => :red)
  blue = "  ".colorize( :background => :blue)
  green = "  ".colorize( :background => :green)
  yellow = "  ".colorize( :background => :yellow)
  cyan = "  ".colorize( :background => :cyan)
  magenta = "  ".colorize( :background => :magenta)
  colors = [red, blue, green, yellow, cyan, magenta]
  #Give each element in the array a random color from colors array
  # and print the board.
  board.each do |sub_array|
    sub_array.each do |item|
        item = colors.sample
        print item
    end
    print "\n"
  end
  turns = 0
  play_game
end
  
def play_game
  #beneath board messages
  percentage = (width*height)
  puts "Turns: #{turns}"
  puts "Current completion: #{percentage}%"
  print "Choose a color: "
  choice = gets.chomp.downcase
    if choice == "q" 
      home_page
    elsif choice == "r"
      newColor = red
      turns +=1
    elsif choice == "b"
      newColor = blue
      turns +=1
    elsif choice == "g"
      newColor = green
      turns +=1
    elsif choice == "y"
      newColor = yellow
      turns +=1
    elsif choice == "c"
      newColor = yellow
      turns +=1
    elsif choice == "m"
      newColor = magenta
      turns +=1
    else 
      play_game
    end
  
end
  
def change_size(width, height)
  print "Width(currently: #{width} )? "
  width = gets.to_i
  print "Height(currently: #{height}  )? "
  height = gets.to_i
  get_board(width, height)
end

splash_page(14, 9)



