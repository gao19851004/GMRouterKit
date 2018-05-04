//
//  RouterConfig.swift
//  ManagerKit
//
//  Created by 高濛 on 2018/4/10.
//

import Foundation

open class RouterConfig : NSObject {
    
    public var registers : Dictionary<String,RouterCallBack> = [:]
    
    /*
     在继承后的Config子类中复写此方法，注册所需要的所有回调
     */
    
    open func registerCallBacks() {
        
    }
}
