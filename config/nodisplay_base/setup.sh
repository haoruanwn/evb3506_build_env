#!/bin/bash

# 当任何命令失败时立即退出脚本
set -e

# 定义目录变量，让脚本更清晰
# '..' 代表从当前 config 目录回到项目根目录
PROJECT_ROOT=$(pwd)/..
SDK_DIR="$PROJECT_ROOT/rk3506_linux6.1_rkr4_v1"
CONFIG_DIR="$PROJECT_ROOT/config"

echo "--- Linking custom configurations into SDK ---"

# --- 1. 链接自定义的 defconfig 文件 ---
# 假设您的自定义配置文件在 config/my_lora_gw_defconfig
# 目标路径是 SDK 中的 configs 目录
DEFCONFIG_SRC="$CONFIG_DIR/my_lora_gw_defconfig"
DEFCONFIG_DEST_DIR="$SDK_DIR/device/rockchip/my_lora_gw/configs"
# 创建目标目录（如果不存在）
mkdir -p "$DEFCONFIG_DEST_DIR"
# 创建软链接，-s代表软链接, -v显示过程, -f代表如果已存在则强制覆盖
ln -svf "$DEFCONFIG_SRC" "$DEFCONFIG_DEST_DIR/my_lora_gw_defconfig"


# --- 2. 链接自定义的设备树 .dts 文件 ---
# 假设您的自定义设备树在 config/my_lora_gw.dts
DTS_SRC="$CONFIG_DIR/my_lora_gw.dts"
DTS_DEST_DIR="$SDK_DIR/kernel/arch/arm/boot/dts"
ln -svf "$DTS_SRC" "$DTS_DEST_DIR/my_lora_gw.dts"


# --- 3. (示例) 链接您自己的 Rust 网关项目源码 ---
# 这允许您在 SDK 内直接编译您的 Rust 项目
RUST_APP_SRC="$PROJECT_ROOT/my_rust_gateway_app" # 假设您的 Rust 项目在根目录
RUST_APP_DEST_DIR="$SDK_DIR/app"
mkdir -p "$RUST_APP_DEST_DIR"
ln -svf "$RUST_APP_SRC" "$RUST_APP_DEST_DIR/my_rust_gateway_app"


echo "--- Link setup finished successfully! ---"