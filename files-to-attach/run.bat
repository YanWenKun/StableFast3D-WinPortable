@REM Replace hf_your_token with your HuggingFace Access Token.
@REM https://huggingface.co/settings/tokens/new?tokenType=read
set HF_TOKEN=hf_your_token

@REM This command enables experimental library for high-speed file transfers.
@REM Remove it if you got errors/freezing whilie downloading.
@REM https://huggingface.co/docs/huggingface_hub/guides/download#faster-downloads
set HF_HUB_ENABLE_HF_TRANSFER=1

@REM This command redirects HuggingFace-Hub to download model files in this folder.
set HF_HUB_CACHE=%~dp0\HuggingFaceHub

@REM This command let the .pyc cache files to be saved together in this folder.
set PYTHONPYCACHEPREFIX=%~dp0\pycache

@REM If you don't want the browser to open automatically, add " --disable-auto-launch" (without quotation marks) to the end of the line below.
.\python_embeded\python.exe -s ComfyUI\main.py --windows-standalone-build

pause
