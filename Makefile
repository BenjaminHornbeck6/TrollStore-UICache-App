TARGET_CODESIGN = $(shell which ldid)

TrollStore-UICacheTMP = $(TMPDIR)/TrollStore-UICache
TrollStore-UICache_STAGE_DIR = $(TrollStore-UICacheTMP)/stage
TrollStore-UICache_APP_DIR 	= $(TrollStore-UICacheTMP)/Build/Products/Release-iphoneos/TrollStore-UICache.app
GIT_REV=$(shell git rev-parse --short HEAD)

package:
	@set -o pipefail; \
	xcodebuild -jobs $(shell sysctl -n hw.ncpu) -project 'TrollStore-UICache.xcodeproj' -scheme TrollStore-UICache -configuration Release -arch arm64 -sdk iphoneos -derivedDataPath $(TrollStore-UICacheTMP) \
	#CODE_SIGNING_ALLOWED=NO DSTROOT=$(TrollStore-UICacheTMP)/install ALWAYS_EMBED_SWIFT_STANDARD_LIBRARIES=NO
	@rm -rf Payload
	@rm -rf $(TrollStore-UICache_STAGE_DIR)/
	@mkdir -p $(TrollStore-UICache_STAGE_DIR)/Payload
	@mv $(TrollStore-UICache_APP_DIR) $(TrollStore-UICache_STAGE_DIR)/Payload/TrollStore-UICache.app
	
	@echo $(TrollStore-UICacheTMP)
	@echo $(TrollStore-UICache_STAGE_DIR)
	
	@$(TARGET_CODESIGN) -Sentitlements.xml $(TrollStore-UICache_STAGE_DIR)/Payload/TrollStore-UICache.app/
	
	@rm -rf $(TrollStore-UICache_STAGE_DIR)/Payload/TrollStore-UICache.app/_CodeSignature
	
	@ln -sf $(TrollStore-UICache_STAGE_DIR)/Payload Payload
	
	@rm -rf packages
	@mkdir -p packages
	
	@zip -r9 packages/TrollStore-UICache.ipa Payload
	
	@rm -rf Payload && mv packages/TrollStore-UICache.ipa TrollStore-UICache.tipa && rm -rf packages
