#!/usr/bin/env ruby
# this script illustrates the use of blocks in iterators

class FastaIterator
  def initialize(filename)
    @file = get_file(filename)
  end

  def each
    seq_list = Array.new()
    header = nil
    @file.each_line do |line|
      if not line.match(/^(>|\s*$|\s*#)/)
        seq_list.push(line.chomp)
      elsif m = line.match(/^>(.*)/)
        if not header.nil?
          yield header, seq_list2sequence(seq_list)
          seq_list.clear
        end
        header = m[1].chomp
      end
    end
    if not header.nil?
      yield header, seq_list2sequence(seq_list)
    end
    @file.rewind # so we can reuse the iterator again
  end

  private

  def seq_list2sequence(seq_list)
    return seq_list.join("").gsub(/\s/,"")
  end

  def get_file(filename)
    file = nil
    if File.exist?(filename)
      begin
        file = File.new(filename,"r")
      rescue => err
        STDERR.puts "Could not open file #{filename}: #{err}"
        exit 1
      end
    else
      STDERR.puts "File #{filename} does not exist!"
      exit 1
    end
    return file
  end
end

def print_sequence(seq, linelength)
  pos = 0
  while pos < seq.length
    puts seq[pos..pos+linelength-1]
    pos += linelength
  end
end
