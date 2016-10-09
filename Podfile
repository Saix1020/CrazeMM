platform :ios, '8.0'
use_frameworks!
def shared_pods
	pod 'SDAutoLayout', '~> 2.1.1'
	pod 'AFNetworking', '~> 3.1.0'
	pod 'PromiseKit', '~> 3.2.0'
	pod 'ReactiveCocoa', '~> 4.0.0'
	pod 'MBProgressHUD', '~> 0.9.2'
	pod 'UITableView+FDTemplateLayoutCell', '~> 1.4'
	pod 'LLBootstrapButton', '~> 0.0.1'
	pod 'iCarousel', '~> 1.8.2'
	pod 'NHArrowView', '~> 0.1.0'
	pod 'MJRefresh', '~> 3.1.0'
	pod 'PPiFlatSegmentedControl', '~> 1.4.0'
	pod 'UIView+FrameEx', '~> 0.0.1'
	pod 'TPKeyboardAvoiding', '~> 1.3'
	pod 'RealReachability', '~> 1.1.7'
	pod 'ImagePlayerView'
	pod 'HKGifLoad', '~> 1.0.0'
end

target "CrazeMM" do
	shared_pods
end

target "CrazeMM_Reveal" do
	shared_pods
end

post_install do |installer|
	installer.pods_project.targets.each do |target|
		target.build_configurations.each do |config|
			config.build_settings['SWIFT_VERSION'] = '2.3'
			end
		end
end
