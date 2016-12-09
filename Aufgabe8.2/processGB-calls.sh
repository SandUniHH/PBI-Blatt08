#!/bin/sh

./processGB.rb --selecttop ACCESSION --echo Library.gb
./processGB.rb --selecttop "BASE COUNT" --echo Library.gb
./processGB.rb --selecttop DEFINITION --echo Library.gb
./processGB.rb --selecttop LOCUS --echo Library.gb
./processGB.rb --selecttop ORIGIN --echo Library.gb
./processGB.rb --selecttop LOCUS,DEFINITION --echo Library.gb
./processGB.rb --selecttop ACCESSION --search NM_021964 Library.gb
./processGB.rb --selecttop "BASE COUNT" --search 986 Library.gb
./processGB.rb --selecttop DEFINITION --search MMP10 Library.gb
./processGB.rb --selecttop FEATURES --search Zinc-dependent Library.gb
./processGB.rb --selecttop LOCUS --search XM_006269 Library.gb
./processGB.rb --selecttop ORIGIN --search ctgatgttggtcacttc Library.gb
