#!/bin/bash
set -eux

git config --global core.autocrlf true
gcs='git clone --depth=1 --no-tags --recurse-submodules --shallow-submodules'
workdir=$(pwd)
pip_exe="${workdir}/python_standalone/python.exe -s -m pip"
export PYTHONPYCACHEPREFIX="$workdir"/pycache
export PATH="$PATH:$workdir/python_standalone/Scripts"
export PIP_NO_WARN_SCRIPT_LOCATION=0

# Replace URL if you need to use PIP mirror site
# 使用国内源下载，替换为 https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple
export PIP_INDEX_URL="https://pypi.org/simple"

ls -lahF

# Download Python Standalone
cd "$workdir"
curl -sSL \
https://github.com/astral-sh/python-build-standalone/releases/download/20250212/cpython-3.12.9+20250212-x86_64-pc-windows-msvc-shared-install_only.tar.gz \
    -o python.tar.gz
tar -zxf python.tar.gz
mv python python_standalone

# PIP installs
$pip_exe install \
    --upgrade pip wheel setuptools

$pip_exe install \
    xformers==0.0.29.post3 torch==2.6.0 torchvision torchaudio \
    --index-url https://download.pytorch.org/whl/cu126 \
    --extra-index-url $PIP_INDEX_URL

$pip_exe install -r https://github.com/comfyanonymous/ComfyUI/raw/refs/heads/master/requirements.txt

$pip_exe install \
https://github.com/YanWenKun/Comfy3D-WinPortable/releases/download/r7-wheels/texture_baker-0.0.1-cp312-cp312-win_amd64.whl \
https://github.com/YanWenKun/Comfy3D-WinPortable/releases/download/r7-wheels/uv_unwrapper-0.0.1-cp312-cp312-win_amd64.whl

$pip_exe install -r "$workdir"/requirements.txt

$pip_exe list

# Done installing dependencies
# Downloading repos

cd "$workdir"

mkdir SF3D

mv python_standalone SF3D/

cd SF3D

mkdir HuggingFaceHub

git clone https://github.com/comfyanonymous/ComfyUI.git
cd ComfyUI
git reset --hard "$(git tag | grep -e '^v' | sort -V | tail -1)"

cd custom_nodes
$gcs https://github.com/Stability-AI/stable-fast-3d.git

cp stable-fast-3d/demo_files/examples/* ../input/

cd "$workdir"

cp -rf "$workdir"/files-to-attach/* \
    "$workdir"/SF3D/

du -hd1
