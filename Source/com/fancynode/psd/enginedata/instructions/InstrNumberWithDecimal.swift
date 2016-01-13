//
// InstrNumberWithDecimal.swift
// EngineDataTest
//
// Created by featherJ on 16/1/13.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
/**
 十进制解析指令<br>
 Decimal number instruction

 - author :featherJ
 */
class InstrNumberWithDecimal : AbstractInstruction {
	static let regExp = try! NSRegularExpression(pattern: "^(-?\\d*)\\.(\\d+)$", options: NSRegularExpressionOptions.AnchorsMatchLines)
	
	override func execute(match: [String]) -> AnyObject? {
		return Double(match[1] + "." + match[2]) ;
	}
}