#!/bin/sh

readonly PRO="./projects"
readonly TOL="./tolset"
readonly ZTO="./z_tools"

# check HariboteOS

if [ ! -d $PRO ]; then
    echo "projectsディレクトリがありませんぞ＞＜"
    exit 1
elif [ ! -d $TOL ]; then
    echo "tolsetディレクトリがありゃしません＞＜"
    exit 1
elif [ ! -d $ZTO ]; then
    echo "z_toolsディレクトリがどこにも無な〜い＞＜"
    exit 1
fi

if [ ! -e $HOS/Q.app ]; then
    echo "Create symlink to Q.app"
    ln -s /Applications/Q.app ./Q.app
fi

# set z_tools
mkdir -p $ZTO/qemu
cp $TOL/z_tools/qemu/bios.bin $ZTO/qemu/bios.bin
cp $TOL/z_tools/qemu/vgabios.bin $ZTO/qemu/vgabios.bin
mv -f $HOS/Q.app $ZTO/qemu

# set projects
cd $PRO
find . -maxdepth 1 -regex ".*_day" -type d | xargs -J % cp -rp % ../
cd ../

# set Makefile
curl -L https://github.com/ryotarai/30nichideosjisaku/tarball/master | tar xz -C ./
readonly SANDAI=$(find . -maxdepth 1 -regex ".*sandai-30nichideosjisaku.*" -type d)
cd $SANDAI
find . -regex ".*_day" -o -name "z_tools" -maxdepth 1 -type d | xargs -J % cp -rpf % ../
cd ../

# move file
mkdir -p trash
mv -f $PRO ./trash
mv -f $TOL ./trash
mv -f $SANDAI ./trash
cd trash
echo "このディレクトリは開発に必要の無いファイル郡です。削除しても構いません。" > readme.txt

# All done!
echo "おわり！がんばってOS作ってね！"
