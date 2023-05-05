#!/bin/bash

root_dir=`pwd`
root_dir="${root_dir}/2_ACKs"

declare -a branches=(
    [0]="android-mainline"
    [1]="android14-6.1"
    [3]="android13-5.15"
    [5]="android12-5.10"
    [7]="android11-5.4"
    [9]="android-4.19"
)

for key in ${!branches[*]}; do
    branch="common-${branches[${key}]}"
    des_dir="${root_dir}/${key}_${branches[${key}]}"
    echo ${des_dir} ${branch}

    if [ ! -d "${des_dir}" ]; then
        mkdir -p ${des_dir}
        cd ${des_dir}
        repo init -u https://android.googlesource.com/kernel/manifest -b ${branch}
    fi

    cd ${des_dir}
    echo "sync code in `pwd`"
    repo sync -c -j4
    repo sync -c -j4
done
