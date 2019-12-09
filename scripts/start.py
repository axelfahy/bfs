"""
Script run at the start of JupyterLab.

This will automatically import all those packages for each notebooks.

Some configuration for Jupyter are done at the end of the script.

This script must be put in the startup directory of IPython.
You can run `get_ipython().profile_dir.startup_dir` to find it.
The default location is usually at: `~/.ipython/profile_default/startup`.
Files in the folder will be run in lexicographical order.
"""
import numpy as np
import pandas as pd
from pathlib import Path

# Register converters
from pandas.plotting import register_matplotlib_converters

register_matplotlib_converters()

# Pandas options
pd.options.display.max_columns = 0
pd.options.display.max_rows = 60

from IPython import get_ipython

ipython = get_ipython()

# If in ipython, load autoreload extension
if "ipython" in globals():
    print("\nWelcome to IPython!")
    ipython.magic("load_ext autoreload")
    ipython.magic("autoreload 2")

    # Load functions from notebook
    from ipynb.fs.full._functions import *

print("All packages have been loaded.")
