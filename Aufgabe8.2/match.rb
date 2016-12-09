#lst{match}
def match_positions_fwd(regexp, sequence)
  poslist = Array.new()
  # match regexp against sequence, be case insensitive
  lastpos = 0
  loop do 
    p = sequence.index(/#{regexp}/i,lastpos)
    break if p.nil?
    poslist.push(p)
    lastpos = p+1
  end
  return poslist
end
#lstend#
