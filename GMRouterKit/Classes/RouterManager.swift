//
//  RouterManager.swift
//  ManagerKit
//
//  Created by 高濛 on 2018/4/9.
//

import UIKit

public func findRootNavgationController() -> UINavigationController? {
    let rootVC = UIApplication.shared.windows[0].rootViewController
    return (rootVC != nil && rootVC is UINavigationController) ? rootVC as? UINavigationController : nil
}

public typealias RouterCallBack = (NSDictionary)->(UIViewController)
public typealias RouterCallBackForView = (NSDictionary)->(UIView)

public class RouterManager : NSObject {
    
    var registers = NSMutableDictionary() //注册回调目录
    var config : RouterConfig?
    
    public static let shared = RouterManager()

    public override init() {
        super.init()
    }
    
    public func registerConfig(config : RouterConfig) {
        //将config注册到manager
        config.registerCallBacks()
        registers.addEntries(from: config.registers)
    }
    
    //获取View
    public func getAssemblyForViewClass(key : String, parmars : NSDictionary) -> UIView? {
        
        let call = self.registers[key] as? RouterCallBackForView
        guard let callBack = call else {
            print("error : not find \(key) type in registers")
            return nil
        }
        let v = callBack(parmars)
        return v
    }
    
    //获取VC
    public func getAssemblyForViewControllerClass(key : String, parmars : NSDictionary) -> UIViewController? {
        
        let call = self.registers[key] as? RouterCallBack
        guard let callBack = call else {
            print("error : not find \(key) type in registers")
            return nil
        }
        let vc = callBack(parmars)
        return vc
    }
    
    //字符串常亮方式
    public func rootNavigationPush(kActionKey : String ,parmars : NSDictionary) {
        let call = self.registers[kActionKey] as? RouterCallBack
        
        guard let callBack = call else {
            return print("error : not find \(kActionKey) type in registers")
        }
        
        let nav = findRootNavgationController()
        let vc = callBack(parmars)
        nav?.pushViewController(vc, animated: true)
    }
}





