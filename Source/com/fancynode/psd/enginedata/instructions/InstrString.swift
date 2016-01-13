//
// InstrString.swift
// EngineDataTest
//
// Created by featherJ on 16/1/13.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
/**
 字符串解析指令<p>
 String instruction

 - author: featherJ
 */
class InstrString : AbstractInstruction {
	static let regExp = try! NSRegularExpression(pattern: "^\\(\\xFE\\xFF([\\s\\S]*)\\)$", options: NSRegularExpressionOptions.AnchorsMatchLines)
	
	override func execute(match: [String]) -> AnyObject? {
		var data: String = self._text.substring(1, self._text.length - 1) ;
		
		let bytes: ByteArray = ByteArray() ;
		for (var i = 0;i < data.length;i++) {
			bytes.writeByte(data.charCodeAt(i)!) ;
		}
		bytes.position = 0;
		
		data = bytes.readMultiByte(bytes.length, CFStringBuiltInEncodings.UTF16BE.rawValue) ;
		data = StringUtil.trim(data);
		return data;
	}
}