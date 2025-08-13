# Buildroot Rust 交叉编译指南

Buildroot 提供了一整套完整的 Rust 交叉编译工具链。为了避免潜在的兼容性问题，推荐直接使用 Buildroot 提供的 Shell 环境进行所有编译操作。

## 一、开启 Buildroot 的 Rust 交叉编译支持

默认配置中，Buildroot 会开启 Rust 工具链支持（获取预编译包）。执行 `./build.sh` 后，相关的工具链会生成在指定目录中。

**1. 确认 Cargo 工具链**

`cargo` 工具链应位于以下路径：

```bash
ls -l buildroot/output/rockchip_rk3506/host/bin/cargo
```

输出示例：

```
-rwxr-xr-x. 1 builder builder 41713392 Aug 12 14:43 buildroot/output/rockchip_rk3506/host/bin/cargo
```

**2. 进入 Buildroot Shell 环境**

使用 `build.sh` 脚本进入专用的 Shell 环境：

```bash
./build.sh shell
```

**3. 配置环境变量**

在进入的 Shell 环境中，将 C 和 Rust 的交叉编译工具链路径添加到 `PATH` 环境变量中。

```bash
# 进入容器后，在 /workspace/rk3506_linux6.1_rkr4_v1 目录下执行
export PATH=/workspace/rk3506_linux6.1_rkr4_v1/buildroot/output/rockchip_rk3506/host/bin:/workspace/rk3506_linux6.1_rkr4_v1/prebuilts/gcc/linux-x86/arm/gcc-arm-10.3-2021.07-x86_64-arm-none-linux-gnueabihf/bin:$PATH
```

**4. 验证 Cargo 版本**

执行以下命令确认 `cargo` 已配置成功：

```bash
cargo --version
```

输出示例：

```
cargo 1.74.1 (ecb9851af 2023-10-18)
```

## 二、创建工程并进行编译

**1. 创建新的 Rust 项目**

```bash
cargo new new_project
```

**2. 配置交叉编译目标**

在项目根目录下创建 `.cargo/config.toml` 文件，并添加目标平台和链接器配置。

```toml
[build]
# 设置默认编译目标平台
target = "armv7-unknown-linux-gnueabihf"

[target.armv7-unknown-linux-gnueabihf]
# 为目标平台指定 C 语言链接器
linker = "arm-buildroot-linux-gnueabihf-gcc"
```

**3. 执行编译**

进入项目目录，执行 `cargo build` 命令。

```bash
cd new_project
# 编译 Debug 版本
cargo build
# 或编译 Release 版本
cargo build --release 
```

编译生成的可执行文件位于 `target/armv7-unknown-linux-gnueabihf/debug/` 或 `target/armv7-unknown-linux-gnueabihf/release/` 目录下。

## 三、传输文件至目标设备

使用 `scp` 命令将编译好的可执行文件传输到目标设备上。

```bash
# 格式：scp <本地文件路径> <用户名@设备IP>:<目标路径>
scp target/armv7-unknown-linux-gnueabihf/debug/new_project root@192.168.31.75:/root/
```