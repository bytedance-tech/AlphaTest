# Bytedance-UnionAD Only for test

Pod for Bytedance-UnionAD only support **x86_64, armv7, armv7s, arm64**.

## How To Get Started

+ [Download Bytedance-UnionAD](https://github.com/bytedance-tech/AlphaTest.git) and try out the included [example app](https://github.com/bytedance-tech/AlphaTest/tree/master/Example/BUDemo)


## Installation with CocoaPods

[CocoaPods](https://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like Bytedance-UnionAD in your projects. You can install it with the following command:
```ruby
$ gem install cocoapods
```

### Podfile

To integrate Bytedance-UnionAD into your Xcode project using CocoaPods, **you must install Git LFS first**,then specify it in your **Podfile**:
```ruby
source 'https://github.com/bytedance-tech/AlphaTestRepo.git'
platform :ios, '9.0'

target 'TargetName' do
pod 'Pangle-UnionAD-Test'
end
```
Then, run the following command:
```ruby
$ pod install
```

Pod access is only supported after **version 1982**

If you want to get Bytedance-UnionAD before version 1982 ，Please go to [union](http://ad.toutiao.com/union/media) for more information.

## Author

Siwant

## License

Bytedance-UnionAD is available under the MIT license. See the LICENSE file for more info.
