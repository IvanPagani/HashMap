# frozen_string_literal: true

require_relative 'lib/hashmap'

test = HashMap.new

test.set('apple', 'red')
test.set('banana', 'yellow')
test.set('carrot', 'orange')
test.set('dog', 'brown')
test.set('elephant', 'gray')
test.set('frog', 'green')
test.set('grape', 'purple')
test.set('hat', 'black')
test.set('ice cream', 'white')
test.set('jacket', 'blue')
test.set('kite', 'pink')
test.set('lion', 'golden')

puts "\nCurrent length: #{test.length}"
puts "Current capacity: #{test.capacity}"
puts "\nHash map structure:\n#{test.buckets}"

puts "\n-Overwriting existing keys"
test.set('apple', 'green')
test.set('banana', 'brown')
puts "  Overwrote 'apple' with 'green'"
puts "  Overwrote 'banana' with 'brown'"
puts "  Length after overwrite: #{test.length}"
puts "  Capacity after overwrite: #{test.capacity}"

puts "\n-Inserting one more key to trigger resize"
test.set('moon', 'silver')
puts "  Inserted 'moon' => 'silver'"
puts "  Length after insert: #{test.length}"
puts "  Capacity after resize: #{test.capacity}"
puts "\nHash map structure:\n#{test.buckets}"

puts "\n-Checking values after resize"
puts "  apple: #{test.get('apple')}"
puts "  banana: #{test.get('banana')}"
puts "  moon: #{test.get('moon')}"
puts "  has?('zebra'): #{test.has?('zebra')}"
puts "  has?('frog'): #{test.has?('frog')}"

puts "\n-Removing a key"
removed = test.remove('kite')
puts "  Removed 'kite', got: #{removed}"
puts "  Length after remove: #{test.length}"
puts "  Capacity after remove: #{test.capacity}"

puts "\n-Listing keys, values, entries"
puts "  Keys: #{test.keys.inspect}"
puts "  Values: #{test.values.inspect}"
puts "  Entries: #{test.entries.inspect}"

puts "\n-Removing keys to trigger resize"
test.remove('apple')
test.remove('banana')
test.remove('carrot')
test.remove('dog')
test.remove('elephant')
test.remove('frog')
test.remove('grape')
test.remove('lion')
puts "  Length after removals: #{test.length}"
puts "  Capacity after resize: #{test.capacity}"
puts "\nHash map structure:\n#{test.buckets}"

puts "\n-Removing one more key to trigger resize"
removed = test.remove('jacket')
puts "  Removed 'jacket', got: #{removed}"
puts "  Length after removals: #{test.length}"
puts "  Capacity after resize: #{test.capacity}"
puts "\nHash map structure:\n#{test.buckets}"

puts "\n-Clearing the hash map"
test.clear
puts "  Length after clear: #{test.length}"
puts "  Keys after clear: #{test.keys.inspect}"
puts "  Values after clear: #{test.values.inspect}"
puts "  Entries after clear: #{test.entries.inspect}"
puts "  Capacity after clear: #{test.capacity}"
