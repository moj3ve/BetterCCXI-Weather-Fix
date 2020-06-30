@interface CALayer (Private)
@property (atomic, assign, readwrite) BOOL continuousCorners;
@end

@interface CCUIContentModuleContentContainerView : UIView
@property (assign,nonatomic) double compactContinuousCornerRadius;
@property (assign,nonatomic) double expandedContinuousCornerRadius;
@end

@interface CCUIContentModuleContainerViewController : UIViewController
@property (nonatomic,readonly) CCUIContentModuleContentContainerView * moduleContentView;
-(BOOL)isExpanded;
@end

@interface WAWeatherPlatterViewController : UIViewController
@property UIView *backgroundView;
@end

@interface BCIWeatherContentViewController : UIViewController {
	WAWeatherPlatterViewController *_platterController;
	UIView *_weatherView;
}
@end

%hook BCIWeatherContentViewController

- (void)viewWillLayoutSubviews {
  %orig;
  WAWeatherPlatterViewController *platterController = MSHookIvar<WAWeatherPlatterViewController *>(self, "_platterController");
  platterController.backgroundView.hidden = YES;
  UIView *weatherView = MSHookIvar<UIView *>(self, "_weatherView");
	weatherView.layer.continuousCorners = YES;
  CCUIContentModuleContainerViewController  *parentViewController = (CCUIContentModuleContainerViewController *)self.parentViewController;
  BOOL expanded = [parentViewController isExpanded];
  if (expanded) {
    weatherView.layer.cornerRadius = parentViewController.moduleContentView.expandedContinuousCornerRadius;
  } else {
    weatherView.layer.cornerRadius = parentViewController.moduleContentView.compactContinuousCornerRadius;
  }
}

%end

%ctor {
  dlopen("/Library/ControlCenter/Bundles/BCIXWeatherModule.bundle/BCIXWeatherModule", RTLD_LAZY);
  %init;
}
