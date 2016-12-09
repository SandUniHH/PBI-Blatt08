#!/usr/bin/env ruby
#
# Bocher Diedrich Sandmeier

require './fastaIterator.rb'

class SeqLengthCounter
  
  def initialize()
    @bins = Hash.new() #to save the amount of sequences, keys are the starting numbers; 1, 101, 201 etc.
  end

  # cut from fastaIterator.rb and modified
  def fileread()
    if $0 == __FILE__
      if ARGV.length == 0
	puts "Usage: #$0 <fastafile>"
	exit 1
      end
      
      0.upto(ARGV.length - 1) { |i|
	fi = FastaIterator.new(ARGV[i])
	fi.each do |header, sequence|
	  write_to_hash(sequence.length)
	end
      }
    end
  end

  def write_to_hash(sequence_length)
    hashkey = (sequence_length - 1) / 100 #for a sequence of length 201: hash key == 2
    if !@bins.has_key?(hashkey)
      @bins[hashkey] = 0
    end
    
    @bins[hashkey] += 1

  end
  
  def print_distribution
    output_array = @bins.sort    
    output_array.each do |i|
      key_value = i[0]
      key = "#{key_value * 100 + 1}-#{key_value * 100 + 100}"
      value = i[1]
      puts "#{key}:\t#{value}"
    end
  end
  
end
  
###########
  
seqcounter = SeqLengthCounter.new
seqcounter.fileread
seqcounter.print_distribution