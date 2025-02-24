@REM Replace hf_your_token with your HuggingFace Access Token.
@REM https://huggingface.co/settings/tokens/new?tokenType=read
set HF_TOKEN=hf_your_token

@REM This command redirects HuggingFace-Hub to download model files in this folder.
set HF_HUB_CACHE=%~dp0\HuggingFaceHub

@REM This command let the .pyc cache files to be saved together in this folder.
set PYTHONPYCACHEPREFIX=%~dp0\pycache

@REM If you don't want the browser to open automatically, add " --disable-auto-launch" (without quotation marks) to the end of the line below.
.\python_standalone\python.exe -s ComfyUI\main.py --windows-standalone-build

pause
