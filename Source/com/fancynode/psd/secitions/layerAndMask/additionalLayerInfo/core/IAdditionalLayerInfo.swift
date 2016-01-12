//
// IAdditionalLayerInfo.swift
// psd.swift
//
// Created by featherJ on 16/1/11.
// Copyright © 2016年 fancynode. All rights reserved.
//

/**
 图层附加调整信息的接口。<br>
 The interface for all of the addjustment layer info.
 - author:featherJ
 */
public protocol IAdditionalLayerInfo {
	init();
	/**
	 初始化图层调整附加信息。<br>Initialise the adjustment layer info.
	 - parameter layer:  所属图层 <br> The layer record belongs to
	 - parameter length: 该数据块的长度 <br> The length of this section.
	 */
	func initInfo(layer: LayerRecord, _ length: Int) ;
	/**
	 跳过该数据块<br>
	 skip this section
	 */
	func parse() ;
	/**
	 重写该方法，默认会执行跳过。<br>
	 Override this， default seeks to end of section.
	 */
	func skip() ;
}