//
// AdditionalLayerInforFactory.swift
// psd.swift
//
// Created by featherJ on 16/1/12.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
/**
 图层附加信息的工厂类。<br>
 The factory of additional layer information.
 - author: featherJ
 */
class AdditionalLayerInforFactory {
	/** 附加信息表 | Information map */
	private static var infoMap: Dictionary<String, AnyClass> = Dictionary<String, AnyClass> () ;
	private static var inited: Bool = false;
	/** 初始化信息表 | Initialise the information map. */
	private static func initSelf()
	{
		if (inited) {
			return
		}
		inited = true;
	}
	/**
	 注册一个key和附加信息类。<br> Register a Information class with key
	 - parameter key:     要注册的key <br> The key to register
	 - parameter infoCls: 要注册的信息类 <br> The information class to register.
	 */
	private static func register(key: String, infoCls: AnyClass) {
		let keys = key.characters.split {$0 == ","}.map(String.init)
		for key in keys
		{
			infoMap[key] = infoCls;
		}
	}
	/**
	 通过Key创建一个信息的实例。<br>
	 Create an instance of additional information with given key.
	 - parameter key: 指定的key <br> The given key.
	 - returns: 信息实例 <br> The instance of additional information.
	 */
	static func create(key: String) -> IAdditionalLayerInfo?
	{
		initSelf() ;
		let cls: AnyClass? = infoMap[key] ;
		if (cls != nil) {
			let classType = cls! as? IAdditionalLayerInfo.Type
			if let type = classType {
				let layerInfo = type.init() ;
				return layerInfo;
			}
		}
		return nil
	}
}