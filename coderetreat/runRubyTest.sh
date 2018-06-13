#/bin/bash

cat <<EOF > .meta
framework: ruby.rspec
source_files: .*\.rb
EOF

codersdojo start rspec
