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


# set z_tools
mkdir -p $ZTO/qemu
cp $TOL/z_tools/qemu/bios.bin $ZTO/qemu/bios.bin
cp $TOL/z_tools/qemu/vgabios.bin $ZTO/qemu/vgabios.bin

if [ ! -e $ZTO/qemu/Q.app ]; then
    echo "Create symlink to Q.app"
    ln -s /Applications/Q.app $ZTO/qemu/Q.app
fi

# set projects
cd $PRO
find . -maxdepth 1 -regex ".*_day" -type d | xargs -J % cp -rp % ../
cd ../

# set Makefile
curl -L https://github.com/ryotarai/30nichideosjisaku/tarball/master | tar xz -C ./
readonly SANDAI=$(find . -maxdepth 1 -regex "ryotarai-30nichideosjisaku.*" -type d)
cd $SANDAI
find . -regex ".*_day" -o -name "z_tools" -maxdepth 1 -type d | xargs -J % cp -rpf % ../
cd ../

echo "You can remove $PRO, $TOL and $SANDAI"

# All done!
echo "おわり！がんばってOS作ってね！"
