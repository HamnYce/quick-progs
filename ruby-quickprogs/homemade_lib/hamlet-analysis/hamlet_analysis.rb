# Frozen_String_Literal: true

# TODO: make a program to see the amount of times each word category is used.
#   By using a text file copy of hamlet
#   e.g. nouns vs adjectives vs verbs vs adverb vs pronoun


# TODO: open files ( IN READ MODE, Don't perma delete like last time! )

adjectives = Hash.new(false)
nouns = Hash.new(false)
verbs = Hash.new(false)
ham = File.open('hamlet.txt')
total = { adj: 0, nouns: 0, verbs: 0, total: 0 }

File.open('Pass-phrase/adjectives.txt') do |file|
  adjectives[file.readline.chomp] = true until file.eof?
end

File.open('Pass-phrase/nouns.txt') do |file|
  nouns[file.readline.chomp] = true until file.eof?
end

File.open('Pass-phrase/verbs.txt') do |file|
  verbs[file.readline.chomp] = true until file.eof?
end

until ham.eof?
  ham.readline.split.each do |word|
    next if word.chomp.empty?

    total[:adj] += 1 if adjectives[word]
    total[:nouns] += 1 if nouns[word]
    total[:verbs] += 1 if verbs[word]
    total[:total] += 1
  end
end

puts total
puts "percent of adjectives: #{total[:adj] * 100.0 / total[:total]}"
puts "percent of nouns: #{total[:nouns] * 100.0 / total[:total]}"
puts "percent of verbs: #{total[:verbs] * 100.0 / total[:total]}"
