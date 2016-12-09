#lst{printSequence}
def print_sequence(seq, linelength)
  pos = 0
  while pos < seq.length do
    puts seq[pos..pos+linelength-1]
    pos += linelength
  end
end
#lstend#