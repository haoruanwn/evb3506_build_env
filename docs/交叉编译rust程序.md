## 一、开启buildroot的rust交叉编译支持

默认配置中，buildroot就会开启rust工具链支持（获取预编译包），在进行`./build.sh`后，会生成在

```bash
builder@latlopwifi:~/sdk$ ls -l buildroot/output/rockchip_rk3506/host/bin/cargo
-rwxr-xr-x. 1 builder builder 41713392 Aug 12 14:43 buildroot/output/rockchip_rk3506/host/bin/cargo
```

进入`./build.sh`提供的shell

```bash
./build.sh shell
```

将cargo添加进环境变量

```bash
export PATH=$(pwd)/buildroot/output/rockchip_rk3506/host/bin:$PATH
```

查看cargo版本

```bash
builder@latlopwifi:~/sdk (rksdk)$ cargo --version
cargo 1.74.1 (ecb9851af 2023-10-18)
```

