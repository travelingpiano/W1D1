class Maze

  def initialize
  end

end

maze = File.readlines('maze1.txt')
maze.map!{|word| word.gsub("\n","")}
newmaze = []
maze.each do |ele|
  newmaze << ele.split('')
end
p newmaze
