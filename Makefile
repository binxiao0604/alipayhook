
#编译debug或者release
DEBUG = 1

#指定支持的处理器架构
#ARCHS = armv7 arm64

export THEOS_DEVICE_IP=localhost
export THEOS_DEVICE_PORT=12345

#####################################################
#指定需要的SDK版本
#例如：TARGET = iphone:8.1:8.0 表示采用8.1版本的SDK,发布对象为IOS 8.0及以上版本。latest指定以Xcode附带的最新版本SDK编译
#####################################################
TARGET := iphone:clang:latest:7.0

#####################################################
# 导入framework
# iOSREProject_FRAMEWORKS = framework name
# 例如：iOSREProject_FRAMEWORKS = UIKit CoreTelephony CoreAudio
# iOSREProject_PRIVATE_FRAMEWORKS  = private framework name
# 例如：iOSREProject_PRIVATE_FRAMEWORKS  = AppSupport ChatKit IMCore
#####################################################


#####################################################
# 链接Match-o对象
# theos 采用GUN Linker来链接Mach-O对象，包括.dylib、 .a 和 .o 。
# iOSREProject_LDFLAGS = -lx
# 例如：iOSREProject_LDFLAGS = -lz -lsqlite3.0 -dylib1.o 
#####################################################


INSTALL_TARGET_PROCESSES = AlipayWallet

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = AlipayHook

#####################################################
# tweak 包含的源文件（不包括头文件）
# 支持匹配通配符，不支持匹配文件夹 
# 多个文件空格隔开
# 对于没有引入的文件格式写了会报错 src/CSeries/*.mm  src/Logos/*.x src/Logos/*.xm 
# Tweak.xm必须单独写
#####################################################
AlipayHook_FILES = src/Tweak.xm src/CSeries/*.c src/CSeries/*.m
AlipayHook_CFLAGS = -fobjc-arc

#固定写法
include $(THEOS_MAKE_PATH)/tweak.mk

#make clean 调用clean命令后删除packages
clean::
	rm -rf ./packages/*

#在安装插件后杀掉进程
after-install::
#install.exec "killall -9 AlipayWallet"
#安装插件成功后杀掉SpringBoard进程，如果是杀掉AlipayWallet 如果AlipayWallet没有启动会报错（不影响功能）。
	install.exec "killall -9 SpringBoard"
