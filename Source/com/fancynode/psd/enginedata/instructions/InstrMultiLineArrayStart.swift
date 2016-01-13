//
// InstrMultiLineArrayStart.swift
// EngineDataTest
//
// Created by featherJ on 16/1/13.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
/**
 多行数组起始解析指令<br>
 Start of multi line array instruction

 - author: featherJ
 */
class InstrMultiLineArrayStart : AbstractInstruction{
	static let regExp = try! NSRegularExpression(pattern: "^\\/(\\w+) \\[$", options: NSRegularExpressionOptions.AnchorsMatchLines)
	
	override func execute(match: [String]) -> AnyObject? {
		self.engineData.stackPush(match[1]) ;
		self.engineData.setNode(NSMutableArray()) ;
		self.engineData.setProperty() ;
		return nil;
	}
}