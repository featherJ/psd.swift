//
// PathRecord.swift
// psd.swift
//
// Created by featherJ on 16/1/27.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
/**
 矢量路径解析器。<p>
 Vector path Parser

 - author: featherJ
 */
public class PathRecord
{
	/**
	 解析一个矢量路径。<p>
	 Parse the vector path.

	 - parameter bytes: 文件的二进制数据 <p> The bytes of psd file

	 - returns: 解析结果 <p> The parsed result.
	 */
	public static func read(bytes: PSDBytes) -> PathRecord {
		let pr = PathRecord(bytes) ;
		return pr;
	}
	/** 文件的二进制数据 <p> The bytes of psd file */
	private var fileBytes: PSDBytes;
	private var recordType: Int = 0;
	/**
	 构造函数<p>
	 Constructor

	 - parameter bytes: 文件的二进制数据 | The bytes of psd file
	 */
	init(_ bytes: PSDBytes)
	{
		self.fileBytes = bytes;
		self.recordType = bytes.readShort() ;
		switch (recordType)
		{
		case 0, 3:
			readPathRecord() ;
			break;
		case 1, 2, 4, 5:
			readBezierPoint() ;
			break;
		case 7:
			readClipboardRecord() ;
			break;
		case 8:
			readInitialFill() ;
			break;
		default:
			bytes.position += 24;
			break;
		}
	}
	
	private var numPoints: Int = 0;
	private var linked: Bool = false;
	private var precedingVert: Double = 0;
	private var precedingHoriz: Double = 0;
	private var anchorVert: Double = 0;
	private var anchorHoriz: Double = 0;
	private var leavingVert: Double = 0;
	private var leavingHoriz: Double = 0;
	private var clipboardTop: Double = 0;
	private var clipboardLeft: Double = 0;
	private var clipboardBottom: Double = 0;
	private var clipboardRight: Double = 0;
	private var clipboardResolution: Double = 0;
	private var initialFill: Int = 0;
	/**
	 将矢量路径转换为一个object，用于更容易的使用。<p>
	 Exports the path record to an easier to work with object

	 - returns:  转换完的对象 <p> The object
	 */
	public func toObject() -> NSDictionary
	{
		let obj = NSMutableDictionary() ;
		switch (recordType)
		{
		case 0, 3:
			obj["numPoints"] = numPoints;
			break;
		case 1, 2, 4, 5:
			obj["linked"] = linked;
			obj["closed"] = [1, 2].indexOf(recordType) != -1;
			obj["preceding"] = NSDictionary(dictionary: [
					"vert": precedingVert,
					"horiz": precedingHoriz
				]) ;
			obj["anchor"] = NSDictionary(dictionary: [
					"vert": anchorVert,
					"horiz": anchorHoriz
				]) ;
			obj["leaving"] = NSDictionary(dictionary: [
					"vert": leavingVert,
					"horiz": leavingHoriz
				]) ;
			break;
		case 7:
			obj["clipboard"] = NSDictionary(dictionary: [
					"top": clipboardTop,
					"left": clipboardLeft,
					"bottom": clipboardBottom,
					"right": clipboardRight,
					"resolution": clipboardResolution
				]) ;
			break;
		case 8:
			obj["initialFill"] = initialFill;
			break;
		default:
			break;
		}
		obj["recordType"] = recordType
		return obj;
	}
	/** 知否含有贝塞尔点。 <p> Is this record a bezier point? */
	public var isBezierPoint: Bool {
		get {
			return [1, 2, 4, 5].indexOf(recordType) != -1;
		}
	}
	private func readPathRecord() {
		numPoints = fileBytes.readShort() ;
		fileBytes.position += 22;
	}
	private func readBezierPoint() {
		linked = [1, 4].indexOf(recordType) != -1;
		
		precedingVert = fileBytes.readPathNumber() ;
		precedingHoriz = fileBytes.readPathNumber() ;
		
		anchorVert = fileBytes.readPathNumber() ;
		anchorHoriz = fileBytes.readPathNumber() ;
		
		leavingVert = fileBytes.readPathNumber() ;
		leavingHoriz = fileBytes.readPathNumber() ;
	}
	private func readClipboardRecord() {
		clipboardTop = fileBytes.readPathNumber() ;
		clipboardLeft = fileBytes.readPathNumber() ;
		clipboardBottom = fileBytes.readPathNumber() ;
		clipboardRight = fileBytes.readPathNumber() ;
		clipboardResolution = fileBytes.readPathNumber() ;
		fileBytes.position += 4;
	}
	private func readInitialFill() {
		initialFill = fileBytes.readShort() ;
		fileBytes.position += 22;
	}
}