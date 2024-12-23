# Disable Scudo outside of eng builds to save RAM.
ifneq (,$(filter eng, $(TARGET_BUILD_VARIANT)))
  PRODUCT_DISABLE_SCUDO := true
endif

# Dedupe VNDK libraries with identical core variants.
TARGET_VNDK_USE_CORE_VARIANT := true

# Always preopt extracted APKs to prevent extracting out of the APK for gms
# modules.
PRODUCT_ALWAYS_PREOPT_EXTRACTED_APK := true

# set threshold to filter unused apps
PRODUCT_SYSTEM_PROPERTIES += \
    pm.dexopt.downgrade_after_inactive_days=10

# set the compiler filter for shared apks to quicken.
# Rationale: speed has a lot of dex code expansion, it uses more ram and space
# compared to quicken. Using quicken for shared APKs on Go devices may save RAM.
# Note that this is a trade-off: here we trade clean pages for dirty pages,
# extra cpu and battery. That's because the quicken files will be jit-ed in all
# the processes that load of shared apk and the code cache is not shared.
# Some notable apps that will be affected by this are gms and chrome.
# b/65591595.
PRODUCT_SYSTEM_PROPERTIES += \
    pm.dexopt.shared=quicken