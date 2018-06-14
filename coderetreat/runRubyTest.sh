#/bin/bash

cat <<EOF > .meta
framework: ruby.rspec
source_files: .*\.rb
EOF

cat <<EOF > runTestOnce.sh
rspec rubyPractice/test/testGameOfLife.rb
EOF

chmod a+x runTestOnce.sh

codersdojo start runTestOnce.sh
