######################
1.校验MD5码
$ md5sum rk3506_linux6.1_rkr4_v1.tar.gz
26dfe81bc3f4c1ccb6449e5052e61152 rk3506_linux6.1_rkr4_v1.tar.gz

2.解压sdk
$ tar -xvf rk3506_linux6.1_rkr4_v1.tar.gz
解压后得到rk3506_linux6.1_rkr4_v1的目录，进入rk3506_linux6.1_rkr4_v1后即为sdk的主目录。

3.配置
$ cd rk3506_linux6.1_rkr4_v1
$ ./build.sh lunch
Log colors: message notice warning error fatal

Log saved at /mnt/5c953a98-9ee6-45b9-8cea-a2898eb313d7/mhk/rk/rk3506/rk3506_release/rk3506_linux6.1_rkr4_v1/output/sessions/2025-04-03_15-10-27
Pick a defconfig:

1. ido-evb3506-v1a-mipi-720x720-emmc_defconfig
2. ido-evb3506-v1a-mipi-720x720-nand_defconfig
3. ido-evb3506-v1a-rgb-1024x600-emmc_defconfig
4. ido-evb3506-v1a-rgb-1024x600-nand_defconfig
...

4.编译
$ ./build.sh
