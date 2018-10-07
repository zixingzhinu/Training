#  感谢

### 获取类的类型的方法

```swift
//        获取纯Swift类(不是继承于NSObject)的类型
let config = FCAPageConfig()
print(config.self)
print(type(of: config))
print(FCAPageConfig.self)
//        FCAPageConfig(titleViewH: 44.0, titleColorNormally: UIExtendedGrayColorSpace 0 1, titleColorSelected: UIExtendedGrayColorSpace 0 1)
//        FCAPageConfig
//        FCAPageConfig


//        获取继承于NSObject的类的类型
let v = UIView()
print(v.self)
print(v.classForCoder)
print(type(of: v))
print(UIView.classForCoder())
print(UIView.self)
//        <UIView: 0x10222e830; frame = (0 0; 0 0); layer = <CALayer: 0x283efdf00>>
//        UIView
//        UIView
//        UIView
//        UIView
```

### 使用Runtime动态获取类的成员

此处以HomeViewController为例进行扩展

```swift
extension HomeViewController {

/// 调用指定方法动态获取指定类(self)所有成员变量
fileprivate func my_get_ivars() {
//        let searchBarTextField = navigationItem.titleView!.value(forKeyPath: "_searchField") as! UITextField
let ivars = my_objc_ivars(of: type(of: self))
for item in ivars {
print("变量：\(item)")
}

//        获取searchBar对象所有成员变量名
//        let ivars = objc_ivars(of: type(of: searchBar))
//        for item in ivars {
//            print("变量：\(item)")
//        }
}
}

extension HomeViewController {

/// 自定义获取指定类的所有成员变量
///
/// - Parameter clazz: 指定类
/// - Returns: 成员变量名数组
public func my_objc_ivars(of clazz: AnyClass) -> [String] {
var arr = [String]()
var p_count: UInt32 = 0
if let ivars = class_copyIvarList(clazz, &p_count) {
for i in 0..<p_count {
let p = ivars[Int(i)]
let name = String(cString:ivar_getName(p)!)

//                print("成员变量:\(name)")
arr.append(name)
}
free(ivars)
}
return arr
}

/// 获取指定类所有方法
///
/// - Parameter clazz: 指定类
/// - Returns: 所有方法名数组
public func my_objc_methods(of clazz: AnyClass) -> [String] {

var methodArr = [String]()
var m_count:UInt32 = 0
if let methods = class_copyMethodList(clazz, &m_count){
//            debugPrint(methods[0]);

for i in 0..<m_count{
let m = methods[Int(i)];
let sel = method_getName(m);
let name = sel_getName(sel);
let method = NSStringFromSelector(sel)
//                debugPrint("方法:\(name): \(method)");
methodArr.append(method)
}
free(methods)
}
return methodArr
}
}

extension HomeViewController {

/// 获取指定类所有方法
///
/// - Parameter clazz: 指定类
/// - Returns: 所有方法名数组
public func objc_methods(of clazz: AnyClass) -> [String] {
var count: UInt32 = 0
let methodList = class_copyMethodList(clazz, &count)

return (0..<count).compactMap { idx in
methodList.map { method_getName($0.advanced(by: Int(idx)).pointee).description }
}
}

/// 动态获取指定类所有属性
///
/// - Parameter clazz: 指定类
/// - Returns: 所有属性名数组
public func objc_properties(of clazz: AnyClass) -> [String] {
var count: UInt32 = 0
let propertyList = class_copyPropertyList(clazz, &count)

return (0..<count).compactMap { idx in
propertyList.map { String(cString: property_getName($0.advanced(by: Int(idx)).pointee)) }
}
}

/// 动态获取指定类所有成员变量名
///
/// - Parameter clazz: 指定类
/// - Returns: 所有成员变量名数组
public func objc_ivars(of clazz: AnyClass) -> [String] {
var count: UInt32 = 0
let ivarList = class_copyIvarList(clazz, &count)

return (0..<count).compactMap { idx in
ivarList.flatMap { ivar_getName($0.advanced(by: Int(idx)).pointee).map({ String(cString: $0) }) }
}
}

/// 动态获取指定类所有协议
///
/// - Parameter clazz: 指定类
/// - Returns: 所有协议名数组
public func objc_protocols(of clazz: AnyClass) -> [String] {
var count: UInt32 = 0
let protocolList = class_copyProtocolList(clazz, &count)

return (0..<count).compactMap { idx in
String(cString: protocol_getName(protocolList![Int(idx)]))
}
}
}
```


## 使用NSClassFromString

<div style="color:red">
注意点：在swift中使用该方法需要传入的参数必须包含项目名。

> 格式：项目名.类名
</div>

使用举例：
```swift
func getChildViewController(targetVcName: String, title: String, imageName: String, selectedImageName: String) -> UINavigationController? {
guard let clazz = NSClassFromString(getClassName(targetClassName: targetVcName)) as? UIViewController.Type else {
return nil
}
let vc = clazz.init()
let selectedImage = UIImage(named: selectedImageName)
//        if let selectedImage = selectedImage {
//            vc.tabBarItem = UITabBarItem(title: title, image: UIImage(named: imageName), selectedImage: selectedImage.withRenderingMode(.alwaysOriginal))
//        }
// UIColor(red: 207, green: 149, blue: 55, alpha: 1.0)   UIColor("#CF9537")
let myTabBarItem = UITabBarItem(title: title, image: UIImage(named: imageName), selectedImage: selectedImage)
myTabBarItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor(rede: 207, greene: 149, bluee: 55, alphae: 1.0)], for: UIControl.State.selected)
vc.tabBarItem = myTabBarItem
let nav = FCANavigationController(rootViewController:vc)
//        print(nav)
return nav
}
```

获取项目名和组装类名的方法：

```swift
extension FCATabBarController {

/// 获取项目名称
///
/// - Returns: 项目名称
func getProjectName() -> String {
//        let nameKey = "CFBundleName"
//        let projectName = Bundle.main.object(forInfoDictionaryKey: nameKey) as! String
// 上下两种方式都可以，目的是获取项目名
let nameKey = "CFBundleExecutable"
let projectName = Bundle.main.infoDictionary![nameKey] as! String
return projectName
}

/// 获取完整类名
///
/// - Parameter targetClassName: 目标类名
/// - Returns: 完整类名
func getClassName(targetClassName: String) -> String {
// 如果你的工程名字中带有“-” 符号  需要加上 replacingOccurrences(of: "-", with: "_") 这句代码把“-” 替换掉  不然还会报错 要不然系统会自动替换掉 这样就不是你原来的包名了 如果不包含“-”  这句代码 可以不加
let projectName = getProjectName().replacingOccurrences(of: "-", with: "_")
let newClassName = projectName + "." + targetClassName
return newClassName
}
}
```

## iOS 11 UINavigation 高度异常
```swift
// iOS11开始，如果NavigationBar中titleView为UISearchBar的话，UISearchBar的height会变为56，导致navigationBar的height也会变为56，可以通过强行设置searchBar的高度约束为44来解决，或者在viewDidAppear中才能获取到UISearchBar真正的高度，注意：这里的isActive要设置成true，否则只会生效一次。
if #available(iOS 11.0, *) {
searchBar.heightAnchor.constraint(equalToConstant: 44.0).isActive = true
}
```
