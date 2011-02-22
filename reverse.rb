#!/usr/bin/ruby

fileName = ARGV[0]

counter = 1
file = File.new(fileName)
outFile = File.open("output.txt", "w")

while(line = file.gets)
	
	## Split the line on period(.), exclamation(!) and question(?) marks
	i = 0 #line iterator
	lastDelimLoc = 0 #Location of the last delimiter

	#Iterates through the line by char and seperates delims and sentences
	line.each_char do |ch|
		
		#Increment iterator
		i = i+1

		if(ch == "." || ch == "!" || ch == "?")

			#Cuts out the sentence
			s = line.slice(lastDelimLoc..i)
			s.strip! #removes trailing/leading white space
			s.chop! #removes the .!?

			# Creates a new sentence with reversed words
			words = s.split(' ')
			words[0] = words[0].downcase #lowercase first word
			#captializes last word (which will become first word)
			words[words.size-1] = words[words.size-1].capitalize
			revSentence = words.reverse.join(' ')

			# Adds the delimiter back and a space
			revSentence << ch << " "
			
			# Print out sentence to output file
			outFile.print(revSentence)
			
			# saves the location of this punctuation mark to 
			# slice the next sentence from here
			lastDelimLoc = i
		end
	end

	# Moves to the next line to create paragraphs
	outFile.print("\n")
end

# Close the all opened files
file.close
outFile.close
