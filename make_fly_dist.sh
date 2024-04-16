#!/bin/bash

set -e
set -x

BUILD_TYPE="$1"

rm -rf flyfication/
git archive HEAD -o archive.tar
mkdir -p flyfication
tar xf archive.tar -C flyfication
rm archive.tar
rm -rf flyfication/flyfication/
# rm -rf flyfication/dist/
cd flyfication

# 轉換繁体詞庫
echo 轉換繁体詞庫...
cd tools
python3 schemagen.py convert-sp --to=flypy --rime-dict=../moran.chars.dict.yaml
python3 schemagen.py convert-sp --to=flypy --rime-dict=../moran.essay.dict.yaml
python3 schemagen.py convert-sp --to=flypy --rime-dict=../moran.tencent.dict.yaml
python3 schemagen.py convert-sp --to=flypy --rime-dict=../moran.moe.dict.yaml
python3 schemagen.py convert-sp --to=flypy --rime-dict=../moran.thuocl.dict.yaml
python3 schemagen.py convert-sp --to=flypy --rime-dict=../moran.computer.dict.yaml
python3 schemagen.py convert-sp --to=flypy --rime-dict=../moran.hanyu.dict.yaml
python3 schemagen.py convert-sp --to=flypy --rime-dict=../moran.words.dict.yaml

# 生成碼表
# 繁体：
python3 schemagen.py --double-pinyin=flypy --pinyin-table=./data/pinyin.txt gen-fixed --charset=./data/trad_chars.txt --input-dict=./data/pinyin.txt  --format=code-word

# 轉換简体詞庫
echo 轉換简体詞庫...
python3 schemagen.py convert-sp --to=flypy --rime-dict=../dist/moran.chars.dict.yaml
python3 schemagen.py convert-sp --to=flypy --rime-dict=../dist/moran.computer.dict.yaml
python3 schemagen.py convert-sp --to=flypy --rime-dict=../dist/moran.essay.dict.yaml
python3 schemagen.py convert-sp --to=flypy --rime-dict=../dist/moran.hanyu.dict.yaml
python3 schemagen.py convert-sp --to=flypy --rime-dict=../dist/moran.moe.dict.yaml
python3 schemagen.py convert-sp --to=flypy --rime-dict=../dist/moran.tencent.dict.yaml
python3 schemagen.py convert-sp --to=flypy --rime-dict=../dist/moran.thuocl.dict.yaml
python3 schemagen.py convert-sp --to=flypy --rime-dict=../dist/moran.words.dict.yaml

# 生成碼表
# 简体：
python3 schemagen.py --double-pinyin=flypy --pinyin-table=./data/pinyin_simp.txt gen-fixed --charset=./data/simp_chars.txt --input-dict=./data/pinyin_simp.txt  --format=code-word

cd ..
cd ..

# 打包

echo 打包...

if [ x$BUILD_TYPE = x"github" ]; then
    # GitHub Actions will take over the tarball creation.
    rm -rf flyfication/tools flyfication/.git flyfication/.github flyfication/make_simp_dist.sh flyfication/make_fly_dist.sh
    exit 0
fi

rm -rf flyfication/tools
rm -rf flyfication/.git flyfication/.github flyfication/.gitignore
rm -rf flyfication/make_simp_dist.sh
rm -rf flyfication/make_fly_dist.sh
# cp 下载与安装说明.txt 更新纪要.txt flyfication
# sedi 's/MORAN_VARIANT/简体/' flyfication/下载与安装说明.txt

7z a -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on "MoranFlyfication-$(date +%Y%m%d).7z" flyfication
# rm -rf flyfication
