//
// InstrPropertyWithData.swift
// EngineDataTest
//
// Created by featherJ on 16/1/13.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
/**
 有数据属性名解析指令<br>
 Property with data instruction

 - author: featherJ
 */
class InstrPropertyWithData : AbstractInstruction {
	static let regExp = try! NSRegularExpression(pattern: "^\\/([a-zA-Z0-9]+) ([\\s\\S]*)$", options: NSRegularExpressionOptions.AnchorsMatchLines)
	
	override func execute(match: [String]) -> AnyObject? {
		self.engineData.setProperty(match[1]) ;
		let data = self.engineData.parseTokens(match[2])! ;
		if let node: AnyObject = self.engineData.node!{
			if (node is NSMutableArray)
			{
				let arr = node as! NSMutableArray ;
				arr.addObject(data) ;
			} else {
				let currentNode: NSMutableDictionary = node as! NSMutableDictionary
				currentNode[self.engineData.property] = data;
			}
		}
		return nil;
	}
}