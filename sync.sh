#!/bin/bash

kernel_dir=${HOME}/0_Kernel
declare -a kernel_branches=(
    [0]="mainline"
    [1]="stable"
)
for key in ${!kernel_branches[*]}; do
    des_dir="${kernel_dir}/${key}_${kernel_branches[${key}]}"
    echo ${des_dir} ${kernel_branches[${key}]}

    if [ ! -d "${des_dir}" ]; then
        mkdir -p ${des_dir}
        cd ${des_dir}
        if [[ ${des_dir} =~ "mainline" ]]
        then
            git clone https://kernel.googlesource.com/pub/scm/linux/kernel/git/torvalds/linux -b master .
        fi
        if [[ ${des_dir} =~ "stable" ]]
        then
            git clone https://kernel.googlesource.com/pub/scm/linux/kernel/git/stable/linux -b master .
        fi
    fi

    cd ${des_dir}
    echo "sync code in `pwd`"
    git pull
    sleep 3
    git pull
done
cd ${HOME}


acks_dir=${HOME}/1_ACKs
declare -a acks_branches=(
    [0]="android-mainline"
    [1]="android14-6.1"
    [3]="android13-5.15"
    [5]="android12-5.10"
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
    cd .repo/repo && git pull
    cd ${des_dir}
    repo sync -c -j6
    sleep 3
    repo sync -c -j6
done
cd ${HOME}
