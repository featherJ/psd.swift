//
// InstrSingleLineArray.swift
// EngineDataTest
//
// Created by featherJ on 16/1/13.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
/**
 单行数组解析指令<br>
 Single line array instruction

 - author: featherJ
 */
class InstrSingleLineArray : AbstractInstruction{
	static let regExp = try! NSRegularExpression(pattern: "^\\[([\\s\\S]*)\\]$", options: NSRegularExpressionOptions.AnchorsMatchLines)
	
	override func execute(match: [String]) -> AnyObject? {
		let str = StringUtil.trim(match[1]) ;
		let items: [String] = str.characters.split {$0 == " "}.map(String.init)
		let data: NSMutableArray = [] ;
		for item in items {
			data.addObject(self.engineData.parseTokens(item)!) ;
		}
		return data;
	}
}