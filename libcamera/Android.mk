ifeq ($(TARGET_BOOTLOADER_BOARD_NAME),adq)

# When zero we link against libmmcamera; when 1, we dlopen libmmcamera.
DLOPEN_LIBMMCAMERA:=1

ifneq ($(BUILD_TINY_ANDROID),true)

LOCAL_PATH:= $(call my-dir)

include $(CLEAR_VARS)

LOCAL_SRC_FILES:= QualcommCameraHardware.cpp

LOCAL_CFLAGS:= -DDLOPEN_LIBMMCAMERA=$(DLOPEN_LIBMMCAMERA)

LOCAL_C_INCLUDES+= \
	vendor/qcom/proprietary/mm-camera/common \
	vendor/qcom/proprietary/mm-camera/apps/appslib \
	vendor/qcom/proprietary/mm-camera/jpeg \
	vendor/qcom/proprietary/mm-camera/jpeg/inc

LOCAL_SHARED_LIBRARIES:= libbinder libutils libui liblog libcamera_client

ifneq ($(DLOPEN_LIBMMCAMERA),1)
LOCAL_SHARED_LIBRARIES+= libqcamera
else
LOCAL_SHARED_LIBRARIES+= libdl
endif

LOCAL_MODULE:= libcamera
include $(BUILD_SHARED_LIBRARY)

endif # BUILD_TINY_ANDROID
endif # adq
