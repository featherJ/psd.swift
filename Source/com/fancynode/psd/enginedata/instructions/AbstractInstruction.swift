//
// AbstractInstruction.swift
// psd.swift
//
// Created by featherJ on 16/1/13.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
/**
 用于EngineData数据解析的指令基类。<br>
 A single instruction to match and parse the data in EngineData

 - author: featherJ
 */
class AbstractInstruction
{
	/** 比对方法表 <br> Match function map */
	private static var matchFuncMap = Dictionary < NSRegularExpression, (text: String) -> [String] > () ;
	/**
	 创建一个比对方法<br>
	 Create a match Function.
	 - parameter regExp: regExp 正则表达式 <br> Regular expression
	 - returns: 比对方法 <br> Match Function
	 */
	static func createMatchFunc(regExp: NSRegularExpression) -> (text: String) -> [String]
	{
		if (matchFuncMap[regExp] == nil)
		{
			matchFuncMap[regExp] = {(text: String) -> [String] in
				let matches = regExp.matchesInString(text, options: NSMatchingOptions(rawValue: 0), range: NSMakeRange(0, text.characters.count)) ;
				var results: [String] = [] ;
				for match in matches {
					for i in 0..<match.numberOfRanges {
						let range = match.rangeAtIndex(i) ;
						let startElement = text.startIndex.advancedBy(range.location) ;
						let endElement = text.startIndex.advancedBy(range.location + range.length) ;
						let matchStr = text.substringWithRange(Range<String.Index>(start: startElement, end: endElement)) ;
						results.append(matchStr) ;
					}
					
				}
				return results;
			}
		}
		return matchFuncMap[regExp]!;
	}
	
	
	
	private var _engineData: EngineData;
	/**EngineData*/
	var engineData: EngineData {
		get {
			return _engineData;
		}
	}
	
	var _text: String;
	/**
	 构造函数<br>
	 Constructor
	 - parameter engineData: EngineData实例 | The instance of EngineData
	 - parameter text:       要解析的文本 |  String being parsed.
	 */
	required init(_ engineData: EngineData, _ text: String) {
		self._engineData = engineData;
		self._text = text;
	}
	/**
	 执行<br>
	 execute
	 */
	func execute(match: [String]) -> AnyObject? {
		return nil;
	}
}