//
// AdditionalLayerInfoBase.swift
// psd.swift
//
// Created by featherJ on 16/1/11.
// Copyright © 2016年 fancynode. All rights reserved.
//

/**
 所有图层附加调整信息的子类。<br>
 Base class for all of the addjustment layer info.
 - author: featherJ
 */
public class AdditionalLayerInfoBase: IAdditionalLayerInfo {
	/** 所属图层 <br> The layer record belongs to */
	var layer: LayerRecord?;
	/** 文件的二进制数据 <br> The bytes of psd file */
	var fileBytes: PSDBytes?
	/** 该模块的长度 <br> The length of this section. */
	var length: Int = 0;
	/** 该模块的结束位置 <br> The end position of this section */
	var infoEnd: Int = 0;

	required public init()
	{
	}
	/**
	 初始化图层调整附加信息。<br>
	 Initialise the adjustment layer info.
	 - parameter layer:  所属图层 <br> The layer record belongs to
	 - parameter length: 该数据块的长度 <br> The length of this section.
	 */
	public func initInfo(layer: LayerRecord, _ length: Int)
	{
		self.layer = layer;
		self.fileBytes = layer.fileBytes;
		self.length = length;
		self.infoEnd = fileBytes!.position + self.length;
	}
	/**
	 跳过该数据块<br>
	 Skip this section
	 */
	public func skip() {
		if (fileBytes != nil) {
			fileBytes!.position = infoEnd;
		}
	}
	/**
	 重写该方法，默认会执行跳过。<br>
	 Override this， default seeks to end of section.
	 */
	public func parse() {
		self.skip() ;
	}
}