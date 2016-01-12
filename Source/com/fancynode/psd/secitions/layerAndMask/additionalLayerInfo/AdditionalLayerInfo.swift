//
// AdditionalLayerInfo.swift
// psd.swift
//
// Created by featherJ on 16/1/11.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
/**
 图层附加信息的解析类。<br>
 Addjustment layer info parser.
 - author: featherJ
 */
public class AdditionalLayerInfo {
	/** 文件的二进制数据 <br> The bytes of psd file */
	private var fileBytes: PSDBytes
	/** 所属图层 <br> The layer record belongs to */
	private var layer: LayerRecord;
	/** 文件头 <br> Psd header  */
	private var header: Header;
	/**
	 构造函数<br>
	 Constructor
	 - parameter bytes:  文件的二进制数据 <br> The bytes of psd file
	 - parameter header: 文件头 <br> Psd header
	 - parameter layer:  所属图层 <br> The layer record belongs to
	 */
	public init(bytes: PSDBytes, _ header: Header, _ layer: LayerRecord)
	{
		self.fileBytes = bytes;
		self.layer = layer;
		self.header = header;
	}
	/** 64位长度的key. <br> **PSB**, the following keys have a length count of 8 bytes */
	private static let PSB_KEYS: [String] = [
		"LMsk", "Lr16", "Lr32", "Layr", "Mt16", "Mt32",
		"Mtrn", "Alph", "FMsk", "lnk2", "FEid", "FXid", "PxSD"] ;
	
	/**
	 读取附加图层信息的长度 <br>
	 Read the length of the given addjustment info
	 - parameter bytes:  文件的二进制数据 <br> The bytes of psd file
	 - parameter header: 文件头 <br> Psd header
	 - parameter key:    图层附加信息的Key <br> The key of the given addjustment info
	 - returns: 图层附加信息的长度 <br> The length of addjustmen info
	 */
	private static func readInfoLength(bytes: PSDBytes, _ header: Header, _ key: String) -> Int
	{
		if (header.isPSB && PSB_KEYS.indexOf(key) != -1) {
			return Int(PsdUtil.pad2(bytes.readInt64())) ;
		}
		return PsdUtil.pad2(bytes.readInt()) ;
	}
	/** 已解析读取的附加信息列表 <br> The parsed info list*/
	private var _infos: [IAdditionalLayerInfo] = [] ;
	/** 已解析的附加信息列表 <br> The parsed info list */
	public var infos: [IAdditionalLayerInfo] {
		get {
			return _infos;
		}
	}
	/** 当前图层包含的所有附加信息Key <br> All contained key in current layer record.  */
	private var _infoKeys: [String] = [] ;
	/** 当前图层包含的所有附加信息Key <br> All contained key in current layer record. */
	public var infoKeys: [String] {
		get {
			return _infoKeys;
		}
	}
	private var infoMap: Dictionary<String, IAdditionalLayerInfo> = Dictionary<String, IAdditionalLayerInfo>() ;
	/**
	 通过类定义得到当前图层包含的附加信息<br>
	 Get the additional layer info by Class Type.
	 - parameter infoCls: 要得到的类定义 <br> Additional layer info class type.
	 - returns: 附加信息实例 <br> The instance of the target Class
	 */
	public func getInfo(infoCls: AnyClass) -> IAdditionalLayerInfo? {
		let key: String = NSStringFromClass(infoCls) ;
		if ((infoMap[key]) != nil) {
			return infoMap[key]! as IAdditionalLayerInfo;
		}
		var targetInstance: IAdditionalLayerInfo?;
		for (var i: Int = 0;i < infos.count;i++) {
			if (infos[i].dynamicType == infoCls) {
				targetInstance = infos[i] ;
				break;
			}
		}
		// 将已经获取过的实例缓存起来 | Cache the instance.
		if (targetInstance != nil) {
			infoMap[key] = targetInstance!;
		}
		return infoMap[key] as IAdditionalLayerInfo?;
	}
	/**
	 解析<br>
	 Parse
	 */
	public func parse(endPos: Int) {
		while (fileBytes.position < endPos)
		{
			// 固定标识，并不需要 | Signature, don't need
			fileBytes.position += 4;
			// Key, 非常重要 | Key, very important
			let key: String = fileBytes.readString(4) ;
			_infoKeys.append(key) ;
			let length: Int = AdditionalLayerInfo.readInfoLength(fileBytes, header, key) ;
			let pos: Int = fileBytes.position;
			let info: IAdditionalLayerInfo? = AdditionalLayerInforFactory.create(key) ;
			if (info != nil) {
				Logger.debug("Layer Info: key = " + String(key) + ", start = " + String(pos) + ", length = " + String(length)) ;
				let infoEnd: Int = fileBytes.position + length;
				info!.initInfo(layer, length) ;
				// todo 需要做懒加载处理
				info!.parse() ;
				self._infos.append(info!) ;
				fileBytes.position = infoEnd;
			} else
			{
				Logger.debug("Skipping unknown layer info block: key = " + String(key) + ", length = " + String(length)) ;
				fileBytes.position += length;
			}
		}
	}
}