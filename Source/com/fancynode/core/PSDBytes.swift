//
// PSDBytes.swift
// psd.swift
//
// Created by featherJ on 16/1/5.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
/**
 用于读取psd文件二进制数据的扩展。<p>A ext for reading binary data from psd file.
 - author: featherJ
 */
class PSDBytes : ByteArray {
	/**
	 从中当前位置读取指定长度的字节数组。<br><br>Reads the specified length of the byte array from the current position
	 - parameter length: length 指定长度 | specified length
	 - returns: 读取出的子字节数组 | Sub byte array
	 */
	func read(length: Int) -> PSDBytes {
		let bytes: PSDBytes = PSDBytes() ;
		readBytes(bytes, 0, length) ;
		return bytes;
	}
	/**
	 读取一段指定长度的gb2312编码的字符串。<br><br>
	 Reads a gb2312 string of the specified length.
	 - parameter length: 指定长度<br><br>
	 The specified length
	 - returns: 字符串<br><br>
	 string
	 */
	func readString(var length: Int = -1) -> String {
		if (length == -1) {
			length = Int(readUnsignedByte()) ;
		}
		let str: String = readMultiByte(length, CFStringEncoding(CFStringEncodings.GB_2312_80.rawValue)) ;
		return str;
	}
	/**
	 读取一段指定长度的Unicode字符串。<br><br>
	 Reads a unicode string of the specified length.
	 - parameter length: 指定长度<br><br>
	 The specified length
	 - returns: 字符串<br><br>
	 string
	 */
	func readUnicodeString(var length: Int = -1) -> String {
		if (length == -1) {
			length = readInt() ;
		}
		var str: String = "";
		for (var i: Int = 0;i < length;i++) {
			str += String.fromCharCode(readUnsignedShort()) ;
		}
		return str;
	}
	/**
	 读取一个路径用浮点数。<br><br>
	 Read a path number.
	 - returns: 路径浮点<br><br>
	 Path number
	 */
	func readPathNumber() -> Double {
		let a: Int = readByte() ;
		let b1: Int = readByte() << 16;
		let b2: Int = readByte() << 8;
		let b3: Int = readByte() ;
		let b: Int = b1 | b2 | b3
		return Double(a + b) / pow(Double(2), Double(24)) ;
	}
	/**
	 读取一个32位的颜色空间和颜色值。<br><br>
	 Reads a 32-bit color space value.
	 - returns: 颜色空间和颜色值对象<br><br>
	 space color object.
	 */
	func readSpaceColor() -> AnyObject {
		let colorSpace: Int = readShort() ;
		var colorComponent: [Int] = [] ;
		for (var i: Int = 0;i < 4;i++) {
			colorComponent.append(readShort() >> 8) ;
		}
		return [
			"colorMode": colorSpace,
			"colorComponents": colorComponent
		]
	}
}