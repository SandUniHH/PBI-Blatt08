#!/usr/bin/env ruby

# this assumes this file is installed in a folder next to the folders with
# example code from the lecture. If you do otherwise, please set RUBYLIB
# accordingly

require 'optparse'

def usage(opts,msg)
  STDERR.puts "#{$0}: #{msg}\n#{opts.to_s}"
  exit 1
end

# note that this option parser accepts an option --cdscheck in addition
# to the options desribed in the exercises. You do not need to care
# about cdscheck as this is part of another exercise.

GbOptions = Struct.new("GbOptions",:inputfilename,:selecttop,:echo,
                                                   :search,:cdscheck)

def gb_option_parser(argv)
  #prepare options struct
  options = GbOptions.new(nil,nil,false,false,false)

  #create optionparser
  opts = OptionParser.new
  #possible array entries
  possible_tops = %w[LOCUS DEFINITION ORIGIN FEATURES ACCESSION BASE\ COUNT]

  opts.banner = "Usage: #$0 [options] inputfile"

  #add options
  #--selecttop
  opts.on("--selecttop tli1[,tli2,...]",Array,
          "comma separated list of top level items (tli):",
          "(#{possible_tops.join(', ')})") do |toplist|
    if options.selecttop
      usage opts, "option --selecttop already set!"
    elsif options.cdscheck
      usage opts, "option --selecttop incompatible with option --cdscheck!"
    end
    toplist.each do |item|
      if not possible_tops.include?(item)
        usage opts, "--selecttop has to be a list of #{possible_tops.join(',')}"
      end
    end
    options.selecttop = toplist
  end

  #--echo
  opts.on("--echo","echo selected items") do |x|
    if options.echo
      usage opts,  "option --echo already used"
    elsif options.cdscheck or options.search
      usage opts, "option --echo incompatible with options --cdscheck and" +
                  " --search!"
    end
    options.echo = true
  end

  #--search
  opts.on("--search REGEXP",Regexp,"search REGEXP in selected items") do |x|
    if options.search
      usage opts, "option --search already used"
    elsif options.cdscheck or options.echo
      usage opts, "option --search incompatible with options --cdscheck and" +
                 " --echo"
    end
    options.search = Regexp.new(x)
  end

  #--cdscheck
  opts.on("--cdscheck",
          "check consistency of all CDS-entries") do |x|
    if options.cdscheck
      usage opts, "option --cdscheck already used"
    elsif options.echo or options.selecttop or options.search
      usage opts, "option --cdscheck is incompatible with the options " +
                 "--echo, --search, and --selecttop"
    end
    options.cdscheck = x
  end
  opts.on("--help","display possible options") do
    STDERR.puts "#{$0}: \n#{opts.to_s}"
    return nil
  end

  #checking for wrong arguments
  rest = opts.parse(argv)
  if rest.length == 0
    usage(opts,"no input file given!")
  end
  if rest.length == 1
    options.inputfilename = rest.pop
  else
    usage(opts,"unnecessary arguments: #{rest}")
  end
  unless options.cdscheck
    unless options.selecttop
      usage opts, "option --selecttop is mandatory if --cdscheck " +
                  "is not used"
    end
    unless options.echo or options.search
      usage opts, "one of the options --echo or " +
                  "--search is necessary"
    end
  end
  return options
end

if __FILE__ == $0
  options = gb_option_parser(ARGV)
  if not options.nil?
    puts options
  end
end
