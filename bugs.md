# 编译过程问题汇总

本文档汇总了编译过程中遇到的问题及其解决方案。

-----

### 1\. 构建buildroot时因网络检查而报错

  * **SDK版本号**: `rk3506_linux6.1_rkr4_v1`

  * **问题描述**
    在使用路由器代理的情况下，buildroot的构建过程依然会被一个网络检查的配置项阻止。

    ![Snipaste_2025-08-11_22-10-35](https://markdownforyuanhao.oss-cn-hangzhou.aliyuncs.com/img1/20250812134237242.png)
    
  * **解决方案**
    在首次编译前，需要通过menuconfig取消网络检查选项。

    1.  执行以下命令进入配置界面：
        ```bash
        ./build.sh menuconfig
        ```
    2.  在配置界面中，按 `/` 键进入搜索模式，检索 `network`。
    3.  找到并取消勾选检查网络相关的选项，然后保存并退出。

### 2\. 最终阶段生成update.img时报错

  * **SDK版本号**: `rk3506_linux6.1_rkr4_v1`

  * **问题描述**
    在打包的最后一步，脚本会错误地使用安卓模式 (`androidos`) 来生成 `update.img`，导致打包失败。

    ![Snipaste_2025-08-12_12-14-15](https://markdownforyuanhao.oss-cn-hangzhou.aliyuncs.com/img1/20250812134300240.png)

  * **解决方案**
  
    **存疑** 或着`./build.sh cleanall`，再重新执行构建

    需要手动修改打包脚本，指定正确的操作系统类型。

    1.  打开脚本文件: `device/rockchip/common/scripts/mk-updateimg.sh`。

    2.  定位到以下代码行：
    
        ```bash
        update.raw.img update.img -os_type:androidos
        ```

    3.  将其修改为：
    
        ```bash
        update.raw.img update.img -os_type:linux
        ```