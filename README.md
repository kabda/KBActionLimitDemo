# UIControl+kb_limit
UIControl+kb_limit.h是UIControl的一个Category，用于UIControl的限流，即限流间隔内只响应一次touch事件；

##使用方法
设置全局限流间隔：

``` Object-C
[UIControl setGlobalLimitTime:2.0];
```

单控件独立设置限流间隔:

``` Object-C
[button setLimitTime:3.0];
[UIButton setGlobalLimitTime:2.0];
[UISwitch setGlobalLimitTime:2.0];
[UISlider setGlobalLimitTime:2.0];
[UITextField setGlobalLimitTime:2.0];
[UIPageControl setGlobalLimitTime:2.0];
[UISegmentedControl setGlobalLimitTime:2.0];
```

##CocoaPods
`pod 'UIControl+kb_limit', '~> 1.0.1'`
