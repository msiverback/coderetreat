#/bin/bash
cd haskellPractice
cat <<EOF > .meta
framework: stack.stack
source_files: .*\.hs
EOF

cat <<EOF > runTestOnce.sh
stack build
stack test
EOF
chmod a+x runTestOnce.sh
codersdojo start runTestOnce.sh
