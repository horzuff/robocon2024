I assume You already have python installed and are using windows. The first step will be to install poetry and create a new project with it. We'll be using poetry, even though we won't be publishing anything, because it sometimes helps with avoiding corporate policies regarding repositories like npm etc.
```python
python -m venv .venv
python -m pip install --upgrade pip setuptools
python -m pip install poetry
```

Now let's initialize our project and go through setup as prompted

`poetry init`

Then when asked for main dependencies add robotframework and robotframework-browser in latest versions. We can also add pyyaml to be able to handle .yaml variable files

Now lets install all dependencies, we're not going to publish this 
`poetry install -no-root`

Now activate Your venv


'.venv/scripts/Activate.ps1'

Then initialize the Browser environment

`rfbrowser -init`

And now we should be ready to start our testing.