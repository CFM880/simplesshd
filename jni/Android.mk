LOCAL_PATH := $(call my-dir)

include $(CLEAR_VARS)

LOCAL_CFLAGS    := -Wall
LOCAL_MODULE    := simplesshd-jni
LOCAL_SRC_FILES := interface.c
# LOCAL_C_INCLUDES:= /home/greg/android/src/gmp/include
# LOCAL_LDLIBS    := -L/home/greg/android/src/gmp/lib -lmpc -lmpfr -lgmp

include $(BUILD_SHARED_LIBRARY)
