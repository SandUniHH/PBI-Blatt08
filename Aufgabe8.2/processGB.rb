#!/usr/bin/env ruby
#
# Bocher Diedrich Sandmeier

require './optparseGB.rb' # options parser
require './match.rb' # find list of positions of regex matches
require './splitGB.rb' # extract data from genbank entries
require './parseAnno.rb' # extract data from genbank entries
require './print_sequence.rb' # print a sequence to a certain point.

options = gb_option_parser(ARGV)

libraryfile = filename2fileobject(options.inputfilename)

begin
  while record = get_next_record(libraryfile)
    annotation, dna = get_annotation_and_dna(record)
    anno_parsed = parse_annotation(annotation)

    if options.echo
      options.selecttop.each {|key|
        if key == 'ORIGIN'
          anno_parsed['DEFINITION'].gsub!(/DEFINITION\s{2}/,'')
          puts ">#{anno_parsed['DEFINITION'].gsub(/\s+/,"\s")}"
          print_sequence(dna, 70)
        else
          puts anno_parsed[key]
        end
      }

    elsif options.search
      options.selecttop.each {|key|

        if key == 'ORIGIN'
            match_positions = match_positions_fwd(options.search, dna)
            if match_positions.length > 0
              mp_list = match_positions.join(", ")
              puts anno_parsed['LOCUS']
              puts "#{options.search} matches in ORIGIN at positions #{mp_list}"
            end

        else
            match_positions = match_positions_fwd(options.search, anno_parsed[key])
            if match_positions.length > 0
              puts anno_parsed['LOCUS']
              puts "#{options.search} matches in #{key}"
              puts # unnecessary really, but will be listed in diff otherwise
            end
        end
        }
    end
  end

rescue EOFError # close file again
  libraryfile.close

end