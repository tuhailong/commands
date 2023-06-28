#!/bin/bash

KNLS_ROOT=${HOME}/0_Kernel
ACKS_ROOT=${HOME}/1_ACKs
AOSP_ROOT=${HOME}/2_AOSP
PIXEL_ROOT=${HOME}/3_Pixel

cd ${HOME}
for dir in ${KNLS_ROOT}/*
do
    if test -d $dir
    then
        cd $dir
        echo "Sync latest kernel code in $dir"
        git pull

        sleep 3

        echo "Sync latest kernel code in $dir"
        git pull
    fi
done

cd ${HOME}
for dir in ${ACKS_ROOT}/*
do
    if test -d $dir
    then
        cd $dir
        cd .repo/repo && git pull
        cd $dir
        echo "Sync latest aosp code in $dir"
        repo sync -c -j8

        sleep 3

        cd $dir
        cd .repo/repo && git pull
        cd $dir
        echo "Sync latest aosp code in $dir"
        repo sync -c -j8
    fi
done

cd ${HOME}
for dir in ${AOSP_ROOT}/*
do
    if test -d $dir
    then
        cd $dir
        cd .repo/repo && git pull
        cd $dir
        echo "Sync latest aosp code in $dir"
        #repo forall -c "git reset --hard" -j8
        repo sync -c -j8

        sleep 3

        cd $dir
        cd .repo/repo && git pull
        cd $dir
        echo "Sync latest aosp code in $dir"
        repo sync -c -j8
    fi
done

cd ${HOME}
for dir in ${PIXEL_ROOT}/*
do
    if test -d $dir
    then
        cd $dir
        cd .repo/repo && git pull
        cd $dir
        echo "Sync latest aosp code in $dir"
        repo sync -c -j8

        sleep 3

        cd $dir
        cd .repo/repo && git pull
        cd $dir
        echo "Sync latest aosp code in $dir"
        repo sync -c -j8
    fi
done
cd ${HOME}
