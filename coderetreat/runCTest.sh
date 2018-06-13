#/bin/bash

cat <<EOF > .meta
framework: c.cunit
source_files: .*\.c
EOF

cat <<EOF > runTestOnce.sh
gcc -o cUnittest cPractice/test/testgameoflife.c cPractice/src/gameoflife.c -lcunit -I cPractice/src/; ./cUnittest

EOF
chmod a+x runTestOnce.sh
codersdojo start runTestOnce.sh
