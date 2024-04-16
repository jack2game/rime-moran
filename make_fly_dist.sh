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
python3 schemagen.py convert-sp --to=flypy --rime-dict=../moran.chars.dict.yaml > ../moran.chars.dict.yaml.bak
python3 schemagen.py convert-sp --to=flypy --rime-dict=../moran.essay.dict.yaml > ../moran.essay.dict.yaml.bak
python3 schemagen.py convert-sp --to=flypy --rime-dict=../moran.tencent.dict.yaml > ../moran.tencent.dict.yaml.bak
python3 schemagen.py convert-sp --to=flypy --rime-dict=../moran.moe.dict.yaml > ../moran.moe.dict.yaml.bak
python3 schemagen.py convert-sp --to=flypy --rime-dict=../moran.thuocl.dict.yaml > ../moran.thuocl.dict.yaml.bak
python3 schemagen.py convert-sp --to=flypy --rime-dict=../moran.computer.dict.yaml > ../moran.computer.dict.yaml.bak
python3 schemagen.py convert-sp --to=flypy --rime-dict=../moran.hanyu.dict.yaml > ../moran.hanyu.dict.yaml.bak
python3 schemagen.py convert-sp --to=flypy --rime-dict=../moran.words.dict.yaml > ../moran.words.dict.yaml.bak
python3 schemagen.py convert-fixed-sp --to=flypy --rime-dict=../moran_fixed.dict.yaml > ../moran_fixed.dict.yaml.bak
python3 schemagen.py convert-fixed-sp --to=flypy --rime-dict=../moran_fixed_simp.dict.yaml > ../moran_fixed_simp.dict.yaml.bak

mv ../moran.chars.dict.yaml{.bak,}
mv ../moran.computer.dict.yaml{.bak,}
mv ../moran.essay.dict.yaml{.bak,}
mv ../moran.hanyu.dict.yaml{.bak,}
mv ../moran.moe.dict.yaml{.bak,}
mv ../moran.tencent.dict.yaml{.bak,}
mv ../moran.thuocl.dict.yaml{.bak,}
mv ../moran.words.dict.yaml{.bak,}
mv ../moran_fixed.dict.yaml{.bak,}
mv ../moran_fixed_simp.dict.yaml{.bak,}

# # 生成碼表
# # 繁体：
# now=$(date +'%Y%m%d')
# echo "# Rime dictionary
# # encoding: utf-8
# # license: CC-BY-SA 4.0

# # 注意：三字詞編碼應該留空，否則 moran_fixed_aabc 詞庫無法生成 AaBC 格式編碼！

# ---
# name: moran_fixed
# version: \"${now}\"
# sort: by_weight
# columns:
  # - text
  # - code
  # - stem
  # - weight
  # - comment
# encoder:
  # rules:
    # - length_equal: 2
      # formula: \"AaAbBaBb\"
    # - length_equal: 3
      # formula: \"AaBaCaCb\"
    # - length_in_range: [4, 32]
      # formula: \"AaBaCaZa\"
# ...
# " > ../moran_fixed.dict.yaml.bak
# python3 schemagen.py --double-pinyin=flypy --pinyin-table=./data/pinyin.txt gen-fixed --charset=./data/trad_chars.txt --input-dict=./data/pinyin.txt --format=word-code >> ../moran_fixed.dict.yaml.bak
# cp ../moran_fixed.dict.yaml.bak ..dist/moran_fixed.dict.yaml.bak

# 轉換简体詞庫
echo 轉換简体詞庫...
python3 schemagen.py convert-sp --to=flypy --rime-dict=../dist/moran.chars.dict.yaml > ../dist/moran.chars.dict.yaml.bak
python3 schemagen.py convert-sp --to=flypy --rime-dict=../dist/moran.computer.dict.yaml > ../dist/moran.computer.dict.yaml.bak
python3 schemagen.py convert-sp --to=flypy --rime-dict=../dist/moran.essay.dict.yaml > ../dist/moran.essay.dict.yaml.bak
python3 schemagen.py convert-sp --to=flypy --rime-dict=../dist/moran.hanyu.dict.yaml > ../dist/moran.hanyu.dict.yaml.bak
python3 schemagen.py convert-sp --to=flypy --rime-dict=../dist/moran.moe.dict.yaml > ../dist/moran.moe.dict.yaml.bak
python3 schemagen.py convert-sp --to=flypy --rime-dict=../dist/moran.tencent.dict.yaml > ../dist/moran.tencent.dict.yaml.bak
python3 schemagen.py convert-sp --to=flypy --rime-dict=../dist/moran.thuocl.dict.yaml > ../dist/moran.thuocl.dict.yaml.bak
python3 schemagen.py convert-sp --to=flypy --rime-dict=../dist/moran.words.dict.yaml > ../dist/moran.words.dict.yaml.bak
python3 schemagen.py convert-fixed-sp --to=flypy --rime-dict=../dist/moran_fixed.dict.yaml > ../dist/moran_fixed.dict.yaml.bak
python3 schemagen.py convert-fixed-sp --to=flypy --rime-dict=../dist/moran_fixed_simp.dict.yaml > ../dist/moran_fixed_simp.dict.yaml.bak

mv ../dist/moran.chars.dict.yaml{.bak,}
mv ../dist/moran.computer.dict.yaml{.bak,}
mv ../dist/moran.essay.dict.yaml{.bak,}
mv ../dist/moran.hanyu.dict.yaml{.bak,}
mv ../dist/moran.moe.dict.yaml{.bak,}
mv ../dist/moran.tencent.dict.yaml{.bak,}
mv ../dist/moran.thuocl.dict.yaml{.bak,}
mv ../dist/moran.words.dict.yaml{.bak,}
mv ../dist/moran_fixed.dict.yaml{.bak,}
mv ../dist/moran_fixed_simp.dict.yaml{.bak,}

# # 生成碼表
# # 简体：
# now=$(date +'%Y%m%d')
# echo "# Rime dictionary
# # encoding: utf-8
# # license: CC-BY-SA 4.0+

# # authors: 吕奉先 SunShine 小幽幽 ksqsf

# ---
# name: moran_fixed_simp
# version: \"20240220\"
# sort: original
# columns:
  # - text
  # - code
  # - stem
  # - weight
  # - comment
# encoder:
  # rules:
    # - length_equal: 2
      # formula: \"AaAbBaBb\"
    # - length_equal: 3
      # formula: \"AaBaCaCb\"
    # - length_in_range: [4, 32]
      # formula: \"AaBaCaZa\"
# ...
# " > ../moran_fixed_simp.dict.yaml.bak
# python3 schemagen.py --double-pinyin=flypy --pinyin-table=./data/pinyin_simp.txt gen-fixed --charset=./data/simp_chars.txt --input-dict=./data/pinyin_simp.txt --format=word-code >> ../moran_fixed_simp.dict.yaml.bak
# cp ../moran_fixed_simp.dict.yaml.bak ..dist/moran_fixed_simp.dict.yaml.bak

cd ..
cd ..

# 打包

echo 打包...

rm -rf flyfication/tools
rm -rf flyfication/.git flyfication/.github flyfication/.gitignore
rm -rf flyfication/make_simp_dist.sh
rm -rf flyfication/make_fly_dist.sh
rm -rf flyfication/default.yaml
rm -rf flyfication/key_bindings.yaml
rm -rf flyfication/punctuation.yaml

rm -rf flyfication/dist/tools
rm -rf flyfication/dist/.git flyfication/.github flyfication/.gitignore
rm -rf flyfication/dist/make_simp_dist.sh
rm -rf flyfication/dist/make_fly_dist.sh
rm -rf flyfication/dist/default.yaml
rm -rf flyfication/dist/key_bindings.yaml
rm -rf flyfication/dist/punctuation.yaml

7z a -t7z -m0=lzma -mx=9 -mfb=64 -md=32m -ms=on "MoranFlyfication-$(date +%Y%m%d).7z" flyfication
# rm -rf flyfication
