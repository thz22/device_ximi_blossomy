DEVICE_PATH := device/xiaomi/blossom

# Use the low memory allocator outside of eng builds to save RSS.
ifneq (,$(filter eng, $(TARGET_BUILD_VARIANT)))
  MALLOC_LOW_MEMORY := true
endif

# Do not spin up a separate process for the network stack on go devices, use an in-process APK.
PRODUCT_PACKAGES += InProcessNetworkStack
PRODUCT_PACKAGES += CellBroadcastAppPlatform
PRODUCT_PACKAGES += CellBroadcastServiceModulePlatform

# use the go specific handheld_core_hardware.xml from frameworks
PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/go_handheld_core_hardware.xml:$(TARGET_COPY_OUT_VENDOR)/etc/permissions/handheld_core_hardware.xml