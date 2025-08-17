# Buildroot Rust 交叉编译指南

本文档为在RK3506开发板（或其他ARMv7设备）上部署Rust程序提供两种交叉编译方案。

  * **方法一：静态链接 Musl (推荐)**

      * **优点**: 编译流程更简单，生成的可执行文件是自包含的，不依赖目标系统的C库版本，具有极佳的可移植性。
      * **缺点**: 生成的文件体积稍大。

  * **方法二：动态链接 Glibc (使用Buildroot环境)**
      * **优点**: 生成的文件体积较小。
      * **缺点**: 编译流程相对复杂，强依赖Buildroot SDK提供的特定环境和库版本，可移植性差。

-----

### 方法一：静态链接 Musl (推荐)

此方法生成一个不依赖目标系统动态库的单一可执行文件，极大简化了部署流程。

**1. 准备开发主机 (只需一次)**

首先，在您的开发电脑上安装`musl`目标平台的Rust标准库和C语言交叉编译工具链。

```bash
# 1. 使用 rustup 安装 musl 目标平台的标准库
rustup target add armv7-unknown-linux-musleabihf

# 2. 安装一个能为 ARM 平台链接的 C 语言交叉编译器
# 对于 Debian/Ubuntu 系统:
# sudo apt install gcc-arm-linux-gnueabihf

# 对于 Fedora/CentOS/RHEL 系统:
sudo dnf install gcc-arm-linux-gnu
```

**2. 配置 Rust 项目**

在Rust项目根目录下创建 `.cargo/config.toml` 文件，并配置交叉编译目标和链接器。

**`.cargo/config.toml`**

```toml
[build]
target = "armv7-unknown-linux-musleabihf"

[target.armv7-unknown-linux-musleabihf]
linker = "arm-linux-gnu-gcc"
```

**3. 执行编译**

```bash
cargo build --release
```

-----

### 方法二：动态链接 Glibc (使用Buildroot环境)

此方法利用Rockchip SDK提供的Buildroot工具链，生成一个动态链接到开发板系统`glibc`库的程序。

**1. 进入 Buildroot Shell 环境**

为了使用SDK提供的特定版本工具链，必须进入其专用的`shell`环境。

```bash
# 在SDK根目录下执行
./build.sh shell
```

**2. 在Shell中配置环境变量**

进入`shell`后，需要将Buildroot提供的C交叉编译器和Rust交叉编译器路径添加到`PATH`环境变量中。

```bash
# 进入容器后，在 /workspace/rk3506_linux6.1_rkr4_v1 目录下执行
export PATH=/workspace/rk3506_linux6.1_rkr4_v1/buildroot/output/rockchip_rk3506/host/bin:/workspace/rk3506_linux6.1_rkr4_v1/prebuilts/gcc/linux-x86/arm/gcc-arm-10.3-2021.07-x86_64-arm-none-linux-gnueabihf/bin:$PATH
```

**3. 配置 Rust 项目**

在项目根目录下创建 `.cargo/config.toml` 文件，配置编译目标和Buildroot提供的专用链接器。

**`.cargo/config.toml`**

```toml
[build]
# 设置默认编译目标平台
target = "armv7-unknown-linux-gnueabihf"

[target.armv7-unknown-linux-gnueabihf]
# 为目标平台指定 Buildroot 提供的 C 语言链接器
linker = "arm-buildroot-linux-gnueabihf-gcc"
```

**4. 执行编译**

在**已经配置好环境变量的Buildroot `shell`中**，进入项目目录并执行编译命令。

```bash
# 编译 Debug 版本
cargo build

# 或编译 Release 版本
cargo build --release
```

编译生成的可执行文件位于 `target/armv7-unknown-linux-gnueabihf/release/` 目录下。

-----

### 四、传输文件至目标设备

无论使用哪种方法编译，最后一步都是将生成的可执行文件传输到RK3506开发板上。

使用 `scp` 命令进行传输：

```bash
# 格式：scp <本地文件路径> <用户名@设备IP>:<目标路径>

# 示例 (静态链接 musl)
scp target/armv7-unknown-linux-musleabihf/release/your_program root@192.168.31.75:/root/

# 示例 (动态链接 glibc)
scp target/armv7-unknown-linux-gnueabihf/release/your_program root@192.168.31.75:/root/
```

传输完成后，登录到开发板，为文件添加执行权限即可运行。

```bash
chmod +x /root/your_program
./your_program
```
