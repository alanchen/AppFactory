source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '9.0'
use_frameworks!

# ignore all warnings from all pods
inhibit_all_warnings!

target "AppFactory" do

# Basic SDK
pod 'AFNetworking', '~> 3.0'
pod 'BlocksKit', '~> 2.2.5'
pod 'ReactiveObjC', '~> 3.0.0'
pod 'PromiseKit', '~> 4.4.0'
pod 'MJExtension', '3.0.13'
pod 'Aspects', '~> 1.4.1'
pod 'Masonry', '~> 0.6.4'
pod 'SVProgressHUD', '2.1.2'
pod 'ObjcAssociatedObjectHelpers', '2.0.1'

# Analytics Tools & SDK
pod 'FBSDKCoreKit', '~> 4.25.0'
pod 'FBSDKLoginKit', '~> 4.25.0'

# Image & ImageView & ImagePicker
pod 'SDWebImage', '~> 4.0.0'
pod 'NYXImagesKit', '~> 2.3'
pod 'UIImage-Helpers', '~> 0.0.3'
pod 'IDMPhotoBrowser', '~> 1.11.3'

# View
pod 'TTTAttributedLabel', '~> 2.0.0'
pod 'ViewUtils', '~> 1.1.2'
pod 'MJRefresh', '~> 3.1.4'
pod 'Toaster', '~> 2.1.1'
pod 'RMessage', '~> 2.1.5'

# Helper
pod 'SAMKeychain', '~> 1.5.2'
pod 'ArrayUtils', '~> 1.3'
pod 'NSHash', '~> 1.2.0' # MD5 [string MD5]
pod 'MWFeedParser', '~> 1.0.1' # unescapingFromHTML gtm_stringByUnescapingFromHTML
pod 'ActionSheetPicker-3.0', '2.2.0'
pod 'DateTools', '~> 2.0.0'
pod 'hpple', '~> 0.2.0'
pod 'PINCache', '~> 3.0.1-beta.5'
pod 'EDColor', '~> 1.0.1'
pod 'UIDeviceIdentifier', '~> 1.1.1'
pod 'Harpy', '~> 4.1.8'

end

#
# replace project -> pods_project by https://github.com/CocoaPods/CocoaPods/issues/3918
#
# 64-bit build architecture for all pod targets and override 'Build Active Architecture Only' to NO.
 post_install do |installer|
   installer.pods_project.targets.each do |target|
      target.build_configurations.each do |configuration|
        target.build_settings(configuration.name)['VALID_ARCHS'] = '$(ARCHS_STANDARD)'
        target.build_settings(configuration.name)['ONLY_ACTIVE_ARCH'] = 'NO'
      end
    end
  end
