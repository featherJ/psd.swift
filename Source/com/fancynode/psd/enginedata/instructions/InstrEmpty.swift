//
// InstrEmpty.swift
// EngineDataTest
//
// Created by featherJ on 16/1/13.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
/**
 空数据解析指令<br>
 Empty instruction

 - author: featherJ
 */
class InstrEmpty : AbstractInstruction{
	static let regExp = try! NSRegularExpression(pattern: "^$", options: NSRegularExpressionOptions.AnchorsMatchLines)
}