//
// InstrBoolean.swift
// EngineDataTest
//
// Created by featherJ on 16/1/13.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation

/**
 布尔解析指令<br>
 Boolean instruction

 _author: featherJ
 */
class InstrBoolean : AbstractInstruction{
	static let regExp = try! NSRegularExpression(pattern: "^(true|false)$", options: NSRegularExpressionOptions.AnchorsMatchLines)
	
	override func execute(match: [String]) -> AnyObject? {
		return match[1] == "true" ? true : false
	}
}