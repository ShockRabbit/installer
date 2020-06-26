#!/bin/sh

function install_process_android_ndk() {
    local config_path=$1

    local location_str=`cat $config_path | jq -r ".android_ndk | .location"`
    local location=$(eval echo $location_str)
    local download_url=`cat $config_path | jq -r ".android_ndk | .download_url"`
    local temp_path=./temp_for_install
    local ndk_temp_path=$temp_path/android_ndk
    local ndk_zip_path=$ndk_temp_path/ndk.zip
    if [ ! -d "$ndk_temp_path" ]; then
        mkdir -p $ndk_temp_path
    fi
    if [ ! -d "$location" ]; then
        mkdir -p $location
    fi

    echo "-----------------------------------------------------"
    echo "Download Android NDK from ${download_url} to ${location}"
    echo "-----------------------------------------------------"
    wget -O $ndk_zip_path $download_url
    unzip $ndk_zip_path -d $location
}

install_process_android_ndk ../config.json
