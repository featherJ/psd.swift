//
// InstrObjectStart.swift
// EngineDataTest
//
// Created by featherJ on 16/1/13.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
/**
 对象起始解析指令 <br>
 Object start instruction

 - author: featherJ
 */
class InstrObjectStart : AbstractInstruction {
	static let regExp = try! NSRegularExpression(pattern: "^<<$", options: NSRegularExpressionOptions.AnchorsMatchLines)
	
	override func execute(match: [String]) -> AnyObject? {
		self.engineData.stackPush() ;
		self.engineData.resetNode() ;
		self.engineData.setProperty() ;
		return nil;
	}
}