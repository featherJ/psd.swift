//
// InstrObjectEnd.swift
// EngineDataTest
//
// Created by featherJ on 16/1/13.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
/**
 对象结束解析指令<br>
 Object end instruction

 — author: featherJ
 */
class InstrObjectEnd : AbstractInstruction {
	static let regExp = try! NSRegularExpression(pattern: "^>>$", options: NSRegularExpressionOptions.AnchorsMatchLines)
	
	override func execute(match: [String]) -> AnyObject? {
		let stack = self.engineData.stackPop() ;
		let property = stack["property"]! as? String;
		let node = stack["node"]!;
		if (node == nil) {
			return nil;
		}
		self.engineData.updateNode(property!, node!) ;
		self.engineData.setNode(node!) ;
		return nil;
	}
}