##
## Simple implementation of the Solitaire algorithm
## designed by Bruce Schneier
## https://www.schneier.com/cryptography/solitaire/
##

# Initialize variables
deck = Array.new
lowCut = Array.new
highCut = Array.new
letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split(//)

# Default deck keying
(1..52).each { |n| deck << n }
deck.push("A", "B")


print "Keystream size> "
size = $stdin.gets.chomp.to_i

keystream = 0
while keystream < size

  # Move Jocker A 
  newPosition = (deck.index("A") + 1) % 54
  if (newPosition == 0) then newPosition = 1 end
  deck.delete("A")
  deck.insert(newPosition, "A")

  # Move Jocker B
  newPosition = (deck.index("B") + 2) % 54
  if (newPosition == 0) then newPosition = 1 end
  deck.delete("B")
  deck.insert(newPosition, "B")


  # Triple cut
  if (deck.index("A") < deck.index("B"))
    lowJocker = deck.index("A")
    highJocker = deck.index("B")
  else
    lowJocker = deck.index("B")
    highJocker = deck.index("A")
  end

  index = 0
  lowCut.clear
  while (index < lowJocker)
    lowCut << deck.shift
    index += 1
  end

  index = 53
  highCut.clear
  while (index > highJocker)
    highCut << deck.pop
    index -= 1
  end

  highCut.each { |card| deck.unshift(card) }
  lowCut.each { |card| deck << card }


  # Count cut
  count = deck.pop
  if (count != "A" && count != "B")
    index = 0
    lowCut.clear
    while index < count
      lowCut << deck.shift
      index += 1
    end
  
    lowCut.each { |card| deck << card }
  end

  deck << count


  # Get output card
  count = deck[0]
  if (count == "A" || count == "B") then count = 53 end

  output = deck[count]
  if (output == "A" || output == "B") then output = nil end

  if (output != nil)
    output = output % 26
    print letters[output]
    keystream += 1

    if (keystream % 25 == 0)
      print "\n"
    elsif (keystream % 5 == 0)
      print " "
    end
  end  

end

if (keystream % 20 != 0)
  print "\n"
end
