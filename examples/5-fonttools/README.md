### Subset script

To get fonts subsets we use [fonttools](https://github.com/fonttools/fonttools/blob/master/Lib/fontTools/subset/__init__.py).
To run fonts subsetting script you need Python 3.7+ installed.
Then you need to install bash dependencies
```bash
brew install md5sha1sum
```
and python dependencies
```bash
python3 -m venv .venv
source .venv/bin/activate
pip install -r requirements.txt
```
and after that run a script `./generateSubsets/run.sh`
