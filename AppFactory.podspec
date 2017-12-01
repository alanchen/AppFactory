# use pod spec lint --allow-warnings

Pod::Spec.new do |s|

    s.name         = "AppFactory"
    s.version      = "1.0.0"
    s.summary      = "General library"
    s.homepage     = "https://github.com/alanchen/AppFactory"
    s.license      = "MIT"
    s.author       = { "Alan" => "mvpi3.tw@gmail.com" }
    s.platform     = :ios
    s.ios.deployment_target = "9.0"
    s.source       = { :git => "https://github.com/alanchen/AppFactory.git", :tag => "master" }
    s.requires_arc = true
    s.resources    = "AppFactory/Core/Resource/*.{png,bundle}"
    s.frameworks   = "Foundation","UIKit"
    s.public_header_files = 'AppFactory/Core/**/*.h'
    s.source_files = 'AppFactory/Core/**/*.{h,m}'

	s.dependency "AFNetworking", "~> 3.0"
	s.dependency "BlocksKit", "~> 2.2.5"
	s.dependency "ReactiveObjC", "~> 3.0.0"
	s.dependency "PromiseKit", "~> 4.4.0"
	s.dependency "MJExtension", "~> 3.0.13"
	s.dependency "Aspects", "~> 1.4.1"
	s.dependency "Masonry", "~> 0.6.4"
	s.dependency "SVProgressHUD", "~> 2.1.2"
	s.dependency "ObjcAssociatedObjectHelpers", "~> 2.0.1"
	s.dependency "FBSDKCoreKit", "~> 4.25.0"
	s.dependency "FBSDKLoginKit", "~> 4.25.0"
	s.dependency "SDWebImage", "~> 4.0.0"
	s.dependency "NYXImagesKit", "~> 2.3"
	s.dependency "UIImage-Helpers", "~> 0.0.3"
	s.dependency "IDMPhotoBrowser", "~> 1.11.3"
	s.dependency "TTTAttributedLabel", "~> 2.0.0"
	s.dependency "ViewUtils", "~> 1.1.2"
	s.dependency "MJRefresh", "~> 3.1.4"
	s.dependency "Toaster", "~> 2.1.1"
	s.dependency "RMessage", "~> 2.1.5"
	s.dependency "SAMKeychain", "~> 1.5.2"
	s.dependency "ArrayUtils", "~> 1.3"
	s.dependency "NSHash", "~> 1.2.0"
    s.dependency "MWFeedParser", "~> 1.0.1"
	s.dependency "ActionSheetPicker-3.0", "~> 2.2.0"
	s.dependency "DateTools", "~> 2.0.0"
	s.dependency "hpple", "~> 0.2.0"
	s.dependency "PINCache", "~> 3.0.1-beta.5"
    s.dependency "EDColor", "~> 1.0.1"
	s.dependency "UIDeviceIdentifier", "~> 1.1.1"

  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #
  # s.framework  = "SomeFramework"
  # s.frameworks = "AppsFlyerFramework", "AnotherFramework"
  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"
  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }

end
