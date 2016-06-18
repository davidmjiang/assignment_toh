class TowerOfHanoi
attr_reader :towers, :num_towers

def initialize(height)
  @num_towers=height
  @towers=Array.new(3) {Array.new}
  (1..height).each {|i| @towers[0].unshift(i)}
end

def play
  puts "Welcome to Tower of Hanoi!"
  puts "Instructions:\nThe goal is to move all the disks from 1 rod to another.\nNo disk may be placed on top of a smaller disk\nEnter 'q' to quit."
  render
    until won?
      puts "Which rod would you like to move a disc from?"
      input=gets.chomp
      break if input=="q"
      from_pile=input.to_i
      puts "Which rod would you like to move the disk to?"
      input_2=gets.chomp
      break if input_2=="q"
      to_pile=input_2.to_i
      if valid_move?(from_pile,to_pile)
        move(from_pile,to_pile)
        puts "Disk has been moved"
        render
      end
    end
    puts "You won!" if won?
    puts "Thanks for playing!"
end

def won?
  @towers[0].empty? && @towers[1..2].any?(&:empty?)
end

def valid_move?(from_tower,to_tower)
  if ![from_tower,to_tower].all?{|i| i.between?(1,3)}
    puts "Valid tower numbers are 1, 2, or 3. Try again."
    false
  elsif from_tower==to_tower
    puts "The 2 piles must be different"
    false
  elsif @towers[from_tower-1].empty?
    puts "Tower #{from_tower} is empty! Try again"
    false
  elsif !@towers[to_tower-1].empty? && @towers[from_tower-1].last>@towers[to_tower-1].last
    puts "No disk may be placed on top of a smaller disk. Try again."
    false
  else
    true
  end
end

def move(from_tower,to_tower)
  @towers[to_tower-1]<<@towers[from_tower-1].pop
end

def render
  puts "Current board:"
  i=@num_towers
  while i>0
    row=""
  @towers.each do |tower|
    if !tower[i-1].nil?
      tower[i-1].times{row<<"o"}
      (@num_towers-tower[i-1]+1).times{row<<" "}
    else
      (@num_towers+1).times{row<<" "}
    end
  end
  puts row
  i-=1
  end
  labels=""
  (1..3).each do |t|
    labels << t.to_s
    (@num_towers-1).times{labels<<" "}
  end
  puts labels
end

end