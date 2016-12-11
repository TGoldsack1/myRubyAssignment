# Gems required
require 'console_splash'
require 'colorize'

#Splash page (requires enter to continue)
def splash_page(width, height)
  splash = ConsoleSplash.new(20,40)
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
  if $highScore == 0 
    puts "No games played yet."
  else
    puts "Best game: #{$highScore} turns"
  end
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
  #define all symbols in an array of colors
  String.disable_colorization = false # enable colorization
  colors = [:red, :blue, :green, :yellow, :cyan, :magenta] 
  board = Array.new(height){ Array.new(width)}
  #Give each element in the array a random color from colors array
  #and print the board.
  $board = []
  board.each do |y|
   $row = [] 
    y.each do |x|
      x = "  ".colorize( :background => (colors.sample))
      $row.push(x)
      print x
    end
    $board.push($row)
    print"\n"
  end
  $turns = 0
  $selected = Array.new(height){Array.new(width, 0)}
  $selected[0][0] = 1
  $selectedCount = 1
  play_game(width, height)
end
  
def play_game(width, height)
  #beneath board messages
  cellNum = width*height
  $board[0][0] = "  ".colorize( :background => $oldColor)
  percentage = (($selectedCount/(cellNum))*100) 
  puts "Turns: #{$turns}"
  puts "Current completion: #{percentage}%"
  if $selectedCount == cellNum
    puts "You have won after #{$turns} turns!"
    $highScore = $turns
    home_page(width, height)
  end
  print "Choose a color: "
  choice = gets.chomp.downcase
    if choice == "q" 
      home_page
    elsif choice == "r"
      $newColor = :red
      $turns +=1
    elsif choice == "b"
      $newColor = :blue
      $turns +=1
    elsif choice == "g"
      $newColor = :green
      $turns +=1
    elsif choice == "y"
      $newColor = :yellow
      $turns +=1
    elsif choice == "c"
      $newColor = :cyan
      $turns +=1
    elsif choice == "m"
      $newColor = :magenta
      $turns +=1
    else 
      play_game(width, height)
    end
  numMarked = 1
  a = 0
  b = 0
  while numMarked > 0 do
    $selected.each do |y|
      y.each do |x|
        numMarked = 0
        if $selected[b][a] == 1
          if a < width 
            if $board[b][a+1] == "  ".colorize( :background => $newColor)
              $selected[b][a+1] = 1 
              numMarked += 1
            end
          end
          if b < (height-1)  
            if $board[b+1][a] == "  ".colorize( :background => $newColor)
              $selected[b+1][a] = 1
              numMarked += 1
            end
          end
          if a > 0  
            if $board[b][a-1] == "  ".colorize( :background => $newColor)
              $selected[b][a-1] = 1
              numMarked += 1
            end
          end
          if b > 0 
            if $board[b-1][a] == "  ".colorize( :background => $newColor)
              $selected[b-1][a] = 1
              numMarked += 1
            end
          end
        end
        a += 1
      end
      b += 1
      a = 0
    end
  end
  a = 0
  b = 0 
  $selectedCount = 0
  $selected.each do |y|
    y.each do |x|
      if $selected[b][a] == 1
        $board[b][a] = "  ".colorize( :background => $newColor)
        $selectedCount += 1
      end
      a += 1
    end
    b += 1
    a = 0
  end
  $board.each do |y|
    y.each do |x| 
      print x
    end
    print "\n"
  end
   
  play_game(width, height)
end
  
def change_size(width, height)
  print "Width(currently: #{width} )? "
  width = gets.to_i
  print "Height(currently: #{height}  )? "
  height = gets.to_i
  home_page(width, height)
end

$highScore = 0
splash_page(14, 9)



