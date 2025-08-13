## 进入烧录模式

进入loader或者maskrom的方式参考官方手册《IDO-EVB3506-V1 开发板上手指南.pdf》

具体lsusb显示参考[luckfox lyra的资料](https://wiki.luckfox.com/zh/Luckfox-Lyra/Image-flashing#42-linuxx86_64-%E5%B9%B3%E5%8F%B0)

![Snipaste_2025-08-13_17-52-41](https://markdownforyuanhao.oss-cn-hangzhou.aliyuncs.com/img1/20250813175348875.png)

只有开发板处于“LOADER” 或者“MASKROM”模式的时候才能烧录

## 常用烧录指令

进入sdk目录（rkflash.sh脚本所在的路径） ，注意是主机而不是docker容器

#### 基础用法

```bash
./rkflash.sh [command] [image_path]
```

- `[command]` (必需): 指定要执行的操作，例如烧录哪个分区。
- `[image_path]` (可选): 指定自定义的镜像文件路径。如果未提供，脚本会使用 `rockdev` 目录下的默认镜像。

#### 完整烧录系统

```bash
./rkflash.sh all
```

会依次烧录 `loader`, `parameter`, `uboot`, `trust`, `boot`, `recovery`, `misc`, `oem`, `userdata` 和 `rootfs` 分区，最后重启设备

#### 烧录最小系统

```bash
./rkflash.sh tb
```

只烧录 `loader`, `parameter`, `uboot`, 和 `boot` 这四个核心镜像，然后重启设备，用于快速验证基础启动流程

#### 烧录完整固件`update.img`

```bash
./rkflash.sh update
```

#### 烧录单个分区

```bash
./rkflash.sh <partition_name>

# 如，单独烧录根文件系统部分
./rkflash.sh rootfs
```

用于在开发过程中快速更新某个特定分区，无需重新烧录整个系统。支持的分区名包括：`loader`, `parameter`, `uboot`, `trust`, `boot`, `recovery`, `misc`, `oem`, `userdata`, `rootfs`

## 其他操作

重启设备

```bash
./rkflash.sh rd
```

擦出闪存

```bash
./rkflash.sh erase
```