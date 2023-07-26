#!/bin/sh
openssl_path=$(find /nix/store -name openssl.pc -print -quit | xargs dirname)
echo $openssl_path
export PKG_CONFIG_PATH="$openssl_path:$PKG_CONFIG_PATH"
