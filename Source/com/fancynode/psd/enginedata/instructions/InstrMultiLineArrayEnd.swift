//
// InstrMultiLineArrayEnd.swift
// EngineDataTest
//
// Created by featherJ on 16/1/13.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
/**
 多行数组结束解析指令<br>
 End of multi line array instruction

 - author: featherJ
 */
class InstrMultiLineArrayEnd : AbstractInstruction{
	static let regExp = try! NSRegularExpression(pattern: "^\\]$", options: NSRegularExpressionOptions.AnchorsMatchLines)
	
	override func execute(match: [String]) -> AnyObject? {
		let stack = self.engineData.stackPop() ;
		let property: String? = stack["property"]! as? String;
		let node: AnyObject? = stack["node"]! ;
		self.engineData.updateNode(property!, node!) ;
		self.engineData.setNode(node!) ;
		return nil;
	}
}