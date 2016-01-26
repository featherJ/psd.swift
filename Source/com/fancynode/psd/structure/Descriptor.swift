//
// Descriptor.swift
// psd.swift
//
// Created by featherJ on 16/1/12.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
/**
 一个描述者是一个用于描述负责数据结构的数据块。他是在Photoshop 5.0之后被添加并支持的轻微过失的产物。<p>
 A descriptor is a block of data that describes a complex data structure of some kind.
 It was added sometime around Photoshop 5.0 and it superceded a few legacy things such
 as layer names and type data.
 - author: featherJ
 */
public class Descriptor {
	/** 描述者解析器实例 <br> An instance of descriptor */
	private static var instance: Descriptor = Descriptor() ;
	
	/**
	 解析一个描述者。<br>
	 Parse the descriptor.
	 - parameter bytes: 文件的二进制数据 <br> The bytes of psd file
	 - returns: 解析结果 <br> The parsed object.
	 */
	public static func read(bytes: PSDBytes) -> NSDictionary {
		return Descriptor.instance.parse(bytes) ;
	}
	/**
	 解析一个描述着，描述着通常是由一个类标识开始， 随后跟随舍一系列的项。<br>
	 Parse the descriptor. Descriptors always start with a class identifier, followed by a variable number of items in the descriptor.
	 - parameter bytes: 文件的二进制数据 <br> The bytes of psd file
	 - returns: 解析结果 <br> The parsed object.
	 */
	public func parse(bytes: PSDBytes) -> NSDictionary {
		let data = NSMutableDictionary() ;
		data["class"] = parseClass(bytes) ;
		let numItems = bytes.readInt() ;
		Logger.debug("Class = \(data["class"]) + Item count = \(numItems)") ;
		for (var i = 0;i < numItems;i++)
		{
			let item = parseKeyItem(bytes) ;
			let id = item["id"] as! String ;
			let value = item["value"] ;
			data[id] = value;
		}
		return data;
	}
	private func parseClass(bytes: PSDBytes) -> NSMutableDictionary {
		return NSMutableDictionary(dictionary: [
				"name": bytes.readUnicodeString(),
				"id": parseId(bytes)
			]) ;
	}
	private func parseId(bytes: PSDBytes) -> String
	{
		let len = bytes.readInt() ;
		return len == 0 ? bytes.readString(4) : bytes.readString(len) ;
	}
	private func parseKeyItem(bytes: PSDBytes) -> NSMutableDictionary
	{
		let id = parseId(bytes) ;
		Logger.debug("Key = " + id) ;
		let value = parseItem(bytes) ;
		return NSMutableDictionary(dictionary: ["id": id, "value": value]) ;
	}
	private func parseItem(bytes: PSDBytes, var _ type: String = "") -> AnyObject
	{
		if (type == "") {
			type = bytes.readString(4) ;
		}
		Logger.debug("Type = " + type) ;
		var value: AnyObject = []
		switch (type) {
		case "bool":
			value = parseBoolean(bytes) ;
			break;
		case "type", "GlbC":
			value = parseClass(bytes) ;
			break;
		case "Objc", "GlbO":
			value = Descriptor.read(bytes) ;
			break;
		case "doub":
			value = parseDouble(bytes) ;
			break;
		case "enum":
			value = parseEnum(bytes) ;
			break;
		case "alis":
			value = parseAlias(bytes) ;
			break;
		case "Pth":
			value = parseFilePath(bytes) ;
			break;
		case "long":
			value = parseInteger(bytes) ;
			break;
		case "comp":
			value = NSNumber(longLong: parseLargeInteger(bytes)) ;
			break;
		case "VlLs":
			value = parseList(bytes) ;
			break;
		case "ObAr":
			value = parseObjectArray(bytes) ;
			break;
		case "tdta":
			value = parseRawData(bytes) ;
			break;
		case "obj ":
			value = parseReference(bytes) ;
			break;
		case "TEXT":
			value = bytes.readUnicodeString() ;
			break;
		case "UntF":
			value = parseUnitDouble(bytes) ;
			break;
		case "UnFl":
			value = parseUnitFloat(bytes) ;
			break;
		default:
			break;
		}
		return value
	}
	
	private func parseBoolean(bytes: PSDBytes) -> Bool {
		return bytes.readBoolean() ;
	}
	private func parseDouble(bytes: PSDBytes) -> Double {
		return bytes.readDouble() ;
	}
	private func parseInteger(bytes: PSDBytes) -> Int {
		return bytes.readInt() ;
	}
	private func parseLargeInteger(bytes: PSDBytes) -> Int64 {
		return bytes.readInt64() ;
	}
	private func parseIdentifier(bytes: PSDBytes) -> Int {
		return bytes.readInt() ;
	}
	private func parseIndex(bytes: PSDBytes) -> Int {
		return bytes.readInt() ;
	}
	private func parseOffset(bytes: PSDBytes) -> Int {
		return bytes.readInt() ;
	}
	private func parseProperty(bytes: PSDBytes) -> NSMutableDictionary {
		return NSMutableDictionary(dictionary: [
				"class": parseClass(bytes),
				"id": parseId(bytes)
			]) ;
	}
	private func parseEnum(bytes: PSDBytes) -> NSMutableDictionary{
		return NSMutableDictionary(dictionary:[
			"type": parseId(bytes),
			"value": parseId(bytes)
			]);
	}
	private func parseEnumReference(bytes: PSDBytes) -> NSMutableDictionary
	{
		return NSMutableDictionary(dictionary: [
			"class": parseClass(bytes),
			"type": parseId(bytes),
			"value": parseId(bytes)
			]);
	}
	private func parseAlias(bytes: PSDBytes) -> String {
		let len = bytes.readInt() ;
		return bytes.readString(len) ;
	}
	private func parseFilePath(bytes: PSDBytes) -> NSMutableDictionary {
		_ = bytes.readInt() ;
		// Little-endian, because fuck the world.
		let sig: String = bytes.readString(4) ;
		bytes.endian = Endian.LITTLE_ENDIAN;
		_ = bytes.readInt() ;
		let num_chars = bytes.readInt() ;
		bytes.endian = Endian.BIG_ENDIAN;
		let path = bytes.readUnicodeString(num_chars) ;
		return NSMutableDictionary(dictionary:["sig": sig, "path": path]);
	}
	private func parseList(bytes: PSDBytes) -> NSMutableArray
	{
		let count = bytes.readInt() ;
		var items: [AnyObject] = [] ;
		for (var i = 0;i < count;i++) {
			items.append(parseItem(bytes)) ;
		}
		return NSMutableArray(array: items);
	}
	private func parseObjectArray(bytes: PSDBytes) -> NSMutableDictionary
	{
//		throw new Error("Object array not implemented yet") ;
		let count = bytes.readInt() ;
		let itemInObj = bytes.readInt() ;
		let wat = bytes.readShort() ;
		Logger.put(count) ;
		Logger.put(itemInObj) ;
		Logger.put(wat) ;
		let obj = NSMutableDictionary() ;
		for (var i = 0;i < count;i++)
		{
			let name: String = bytes.readString(bytes.readInt()) ;
			Logger.put(name) ;
			obj[name] = parseList(bytes) ;
		}
		return obj;
	}
	private func parseRawData(bytes: PSDBytes) -> PSDBytes {
		let len = bytes.readInt() ;
		return bytes.read(len) ;
	}
	private func parseReference(bytes: PSDBytes) -> NSMutableArray
	{
		let numItems = bytes.readInt() ;
		let items = NSMutableArray();
		
		for (var i = 0;i < numItems;i++) {
			let type: String = bytes.readString(4) ;
			Logger.debug("Reference type = " + type) ;
			var value: AnyObject = []
			switch (type)
			{
			case "prop":
				value = parseProperty(bytes) ;
				break;
			case "Clss":
				value = parseClass(bytes) ;
				break;
			case "Enmr":
				value = parseEnumReference(bytes) ;
				break;
			case "Idnt":
				value = parseIdentifier(bytes) ;
				break;
			case "indx":
				value = parseIndex(bytes) ;
				break;
			case "name":
				value = bytes.readUnicodeString() ;
				break;
			case "rele":
				value = parseOffset(bytes) ;
				break;
			default:
				break;
			}
			items.push(NSMutableDictionary(dictionary: ["type": type, "value": value])) ;
		}
		return items;
	}
	private func parseUnitDouble(bytes: PSDBytes) -> NSMutableDictionary {
		let unitId: String = bytes.readString(4) ;
		var unit: String = "";
		switch (unitId)
		{
		case "#Ang":
			unit = "Angle";
			break;
		case "#Rsl":
			unit = "Density";
			break;
		case "#Rlt":
			unit = "Distance";
			break;
		case "#Nne":
			unit = "None";
			break;
		case "#Prc":
			unit = "Percent";
			break;
		case "#Pxl":
			unit = "Pixels";
			break;
		case "#Mlm":
			unit = "Millimeters";
			break;
		case "#Pnt":
			unit = "Points";
			break;
		default:
			break;
		}
		let value = bytes.readDouble() ;
		return NSMutableDictionary(dictionary: ["id": unitId, "unit": unit, "value": value]);
	}
	private func parseUnitFloat(bytes: PSDBytes) ->NSMutableDictionary {
		let unitId: String = bytes.readString(4) ;
		var unit: String = "";
		switch (unitId) {
		case "#Ang":
			unit = "Angle";
			break;
		case "#Rsl":
			unit = "Density";
			break;
		case "#Rlt":
			unit = "Distance";
			break;
		case "#Nne":
			unit = "None";
			break;
		case "#Prc":
			unit = "Percent";
			break;
		case "#Pxl":
			unit = "Pixels";
			break;
		case "#Mlm":
			unit = "Millimeters";
			break;
		case "#Pnt":
			unit = "Points";
			break;
		default:
			break;
		}
		let value = bytes.readFloat() ;
		return NSMutableDictionary(dictionary: ["id": unitId, "unit": unit, "value": value]);
	}
}