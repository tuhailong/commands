#!/bin/bash

acks_dir="/home/tuhailong/1_ACKs"
declare -a acks_branches=(
    [0]="android-mainline"
    [1]="android14-6.1"
    [3]="android13-5.15"
    [5]="android12-5.10"
    [7]="android11-5.4"
)
for key in ${!acks_branches[*]}; do
    branch="common-${acks_branches[${key}]}"
    des_dir="${acks_dir}/${key}_${acks_branches[${key}]}"
    echo ${des_dir} ${branch}

    if [ ! -d "${des_dir}" ]; then
        mkdir -p ${des_dir}
        cd ${des_dir}
        repo init -u https://android.googlesource.com/kernel/manifest -b ${branch}
    fi

    cd ${des_dir}
    echo "sync code in `pwd`"
    repo sync -c -j16
    repo sync -c -j16
done
cd /home/tuhailong


aosp_dir="/home/tuhailong/2_AOSP"
declare -a aosp_branches=(
    [0]="master"
    [1]="android-13.0.0_r43"
)
for key in ${!aosp_branches[*]}; do
    branch="${aosp_branches[${key}]}"
    des_dir="${aosp_dir}/${key}_${aosp_branches[${key}]}"
    echo ${des_dir} ${branch}

    if [ ! -d "${des_dir}" ]; then
        mkdir -p ${des_dir}
        cd ${des_dir}
        repo init -u https://android.googlesource.com/a/platform/manifest -b ${branch}
    fi

    cd ${des_dir}
    echo "sync code in `pwd`"
    repo sync -c -j16
    repo sync -c -j16
done
cd /home/tuhailong


# java -Xmx32g \
#     -Djava.util.logging.config.file=/home/tuhailong/opengrok/doc/logging.properties \
#     -jar /home/tuhailong/opengrok/lib/opengrok.jar \
#     -c /usr/bin/ctags \
#     -s /home/tuhailong/opengrok/src -d /home/tuhailong/opengrok/data -H -P -S -G -v \
#     -W /home/tuhailong/opengrok/etc/configuration.xml -U http://localhost:8080/source \
#     --depth 51200 \
#     --progress \
#     -m 4096
