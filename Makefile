
#编译debug或者release
DEBUG = 1

#指定支持的处理器架构
#ARCHS = armv7 arm64

export THEOS_DEVICE_IP=localhost
export THEOS_DEVICE_PORT=12345
#指定需要的SDK版本
TARGET := iphone:clang:latest:7.0
INSTALL_TARGET_PROCESSES = AlipayWallet


include $(THEOS)/makefiles/common.mk

TWEAK_NAME = AlipayHook

AlipayHook_FILES = Tweak.xm fishhook.c AntiAntiDebug.m 
AlipayHook_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk

#make clean 调用clean命令后删除packages
clean::
	rm -rf ./packages/*

#在安装插件后杀掉进程
after-install::
	install.exec "killall -9 AlipayWallet"
