set -e

[ -d venv ] || pyvenv-3.5 ./venv
. venv/bin/activate
pip install -r requirements.txt
