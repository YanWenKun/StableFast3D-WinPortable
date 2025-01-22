@REM 把 hf_your_token 替换为你的 HuggingFace Access Token。
@REM https://huggingface.co/settings/tokens/new?tokenType=read
set HF_TOKEN=hf_your_token

@REM 使用国内的 HuggingFace 镜像。
set HF_ENDPOINT=https://hf-mirror.com

@REM 使用国内的 PIP 镜像（应该用不上，仅防万一）。
set PIP_INDEX_URL=https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple

@REM 让 HuggingFace-Hub 下载模型到本目录，而不是"用户/.cache"目录。
set HF_HUB_CACHE=%~dp0\HuggingFaceHub

@REM 该行命令会使 .pyc 缓存文件集中保存在一处。
set PYTHONPYCACHEPREFIX=%~dp0\pycache

@REM 如果不想要 ComfyUI 启动后自动打开浏览器，添加" --disable-auto-launch"（不含引号）到下行末尾。
.\python_embeded\python.exe -s ComfyUI\main.py --windows-standalone-build

pause
