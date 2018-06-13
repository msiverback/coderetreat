#/bin/bash

cat <<EOF > .meta
framework: python.pyunit
source_files: .*\.py
EOF

cat <<EOF > runTestOnce.sh
python3 -m unittest pythonPractice/test/test_gameOfLife.py
EOF
chmod a+x runTestOnce.sh
codersdojo start runTestOnce.sh
