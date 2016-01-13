//
// InstrProperty.swift
// EngineDataTest
//
// Created by featherJ on 16/1/13.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
/**
 属性解析指令<br>
 Property instruction

 - author: featherJ
 */
class InstrProperty : AbstractInstruction {
	static let regExp = try! NSRegularExpression(pattern: "^\\/([a-zA-Z0-9]+)$", options: NSRegularExpressionOptions.AnchorsMatchLines)
	
	override func execute(match: [String]) -> AnyObject? {
		self.engineData.setProperty(match[1]) ;
		return nil;
	}
}