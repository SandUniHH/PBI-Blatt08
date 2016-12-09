# given filename, set fileobject
#lst{splitGB}
def filename2fileobject(filename) 
  begin
    file = File.new(filename,"r")
  rescue => err
    STDERR.puts "Cannot open file #{filename}: #{err}"
    exit 1
  end
  return file
end

# get next record of genbank library file given fileobject
def get_next_record(file)
  return file.readline("//\n")
end

# get annotation and DNA for given GB record: same method as previously
def get_annotation_and_dna(record)
  mo = record.match(/^(LOCUS.*ORIGIN\s*\n)(.*)\/\/\n/m)
  if mo
    annotation = mo[1]
    dna = mo[2]
  else
    STDERR.puts "Cannot separate annotation from sequence info"
    exit 1
  end
  dna.gsub!(/[\s0-9]/,"")   # clean the sequence of any whitespace or digits
  return annotation, dna
end
#lstend#
