#!/bin/bash
set -eux

git config --global core.autocrlf true

gcs='git clone --depth=1 --no-tags --recurse-submodules --shallow-submodules'

workdir=$(pwd)

pip_exe="${workdir}/python_embeded/python.exe -s -m pip"

export PYTHONPYCACHEPREFIX="$workdir"/pycache

# Replace URL if you need to use PIP mirror site
# 使用国内源下载，替换为 https://mirrors.tuna.tsinghua.edu.cn/pypi/web/simple
export PIP_INDEX_URL="https://pypi.org/simple"

ls -lahF

# Setup Python embeded
curl https://www.python.org/ftp/python/3.12.7/python-3.12.7-embed-amd64.zip \
    -o python_embeded.zip
unzip python_embeded.zip -d "$workdir"/python_embeded

cd "$workdir"/python_embeded
sed -i '1i../ComfyUI' ./python312._pth
sed -i 's/^#import site/import site/' ./python312._pth

curl https://bootstrap.pypa.io/get-pip.py -o get-pip.py
./python.exe -s get-pip.py

# PIP installs
$pip_exe install \
    --upgrade pip wheel setuptools

$pip_exe install \
    xformers==0.0.28.post3 torch==2.5.1 torchvision torchaudio \
    --index-url https://download.pytorch.org/whl/cu124 \
    --extra-index-url $PIP_INDEX_URL

$pip_exe install -r https://github.com/comfyanonymous/ComfyUI/raw/refs/heads/master/requirements.txt

$pip_exe install \
https://github.com/YanWenKun/ComfyUI-Windows-Portable/releases/download/v6.2-wheels/pynim-0.0.3-cp312-abi3-win_amd64.whl \
https://github.com/YanWenKun/ComfyUI-Windows-Portable/releases/download/v6.2-wheels/texture_baker-0.0.1-cp312-cp312-win_amd64.whl \
https://github.com/YanWenKun/ComfyUI-Windows-Portable/releases/download/v6.2-wheels/uv_unwrapper-0.0.1-cp312-cp312-win_amd64.whl

$pip_exe install -r "$workdir"/requirements.txt

$pip_exe list

# Done installing dependencies
# Downloading repos

cd "$workdir"

mkdir SF3D

mv python_embeded SF3D/

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
