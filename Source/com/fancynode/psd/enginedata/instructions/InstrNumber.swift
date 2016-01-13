//
// InstrNumber.swift
// EngineDataTest
//
// Created by featherJ on 16/1/13.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation

/**
 数字解析指令<br>
 Number instruction

 - author: featherJ
 */
class InstrNumber : AbstractInstruction{
	static let regExp = try! NSRegularExpression(pattern: "^(-?\\d+)$", options: NSRegularExpressionOptions.AnchorsMatchLines)
	
	override func execute(match: [String]) -> AnyObject? {
		return Int(match[1]) ;
	}
}