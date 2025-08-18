# 绕过 check-sdk.sh 的 WSL 检测以支持 menuconfig 编译

运行 `./build.sh menuconfig` 命令会报错，原因是该 SDK 的 `check-sdk.sh` 脚本中包含了针对 WSL 环境的检测逻辑，一旦检测到当前运行环境为 WSL，脚本便会直接退出。如需在 WSL 环境下编译，可按以下方式修改该脚本。

**脚本路径(需根据自己文件结构调整)**

```bash
cd ~/rk3506_work/evb3506_build_env-main/rk3506_linux6.1_rkr4_v1/device/rockchip/common/scripts
```

**编辑脚本**

```bash
nano check-sdk.sh
```

**注释掉 `check-sdk.sh` 里这段代码**

```bash
if grep -iwq Microsoft /proc/version; then
    echo -e "\e[35m"
    echo "WSL is not supported!"
    echo -e "\e[0m"
    exit 1
fi
```
