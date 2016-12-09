#lst{parseAnno}
def parse_annotation(annotation)
  results = Hash.new()
  
  # mark beginnings with special character and split there
  sep = "\001"   # \\1 is back reference to first group
  tops = annotation.gsub(/\n([A-Z])/, "\n#{sep}\\1").split(sep)
  
  # process annotation fields into keyword-indexed hash
  tops.each do |value|
    # get key from line, mo is match object
    # the BASE COUNT has a space in it, treat separately
    mo = value.match(/^(BASE COUNT|[A-Z]+)/)
    if mo
      key = mo[1]
    else
      STDERR.puts "Cannot find key in line \"#{value}\""
      exit 1
    end
    results[key] = value   # store the value in the hash
  end
  return results
end
#lstend#
