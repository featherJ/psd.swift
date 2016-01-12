//
// TextLines.swift
// psd.swift
//
// Created by featherJ on 16/1/12.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation

/**
 文本行解析器<br>
 Text lines parser.

 - author: featherJ
 */
public class TextLines
{
	private var _lines: [String] ;
	/** 当前EngineData数据的文本行 <br> The text lines of current EngineData. */
	public var lines: [String] {
		get {
			return _lines;
		}
	}
	private var _lineIndex: Int;
	/** 当前行索引 <br> Current line index */
	public var lineIndex: Int {
		get {
			return _lineIndex;
		}
		set {
			_lineIndex = newValue;
		}
	}
	/**
	 构造函数<br>
	 Constructor

	 - parameter engineText: EngineData的文本数据 <br>
	 The text of EngineData
	 */
	public init(_ engineText: String) {
		var tmpArr: [String] = engineText.characters.split {$0 == "\n"}.map(String.init)
		var arr: [String] = [] ;
		for (var i = 0;i < tmpArr.count;i++) {
			let tmpStr: String = StringUtil.trim(tmpArr[i]) ;
			if (
				tmpStr.indexOf("<<") == 0 || tmpStr.indexOf("/") == 0 ||
				tmpStr.indexOf(">>") == 0 || tmpStr.indexOf("]") == 0 ||
				tmpStr.indexOf("[") == 0
			) {
				arr.append(tmpArr[i]) ;
			} else {
				if (arr.count == 0)
				{
					arr.append(tmpArr[i]) ;
				}
				else
				{
					arr[arr.count - 1] += tmpArr[i] ;
				}
			}
		}
		self._lines = arr;
		self._lineIndex = 0;
	}
	/**
	 当前文本行 <br>
	 Current text line
	 */
	public var currentLine: String? {
		get {
			if (isEnd()) {
				return nil;
			}
			let str: String = StringUtil.trim(String(self._lines[self._lineIndex])) ;
			return str.stringByReplacingOccurrencesOfString("\t", withString: "", options: NSStringCompareOptions.LiteralSearch, range: nil) ;
		}
	}
	/**
	 是否已经到达结尾。<br>
	 If at the end of text lines
	 */
	public func isEnd() -> Bool {
		return self._lines.count == _lineIndex;
	}
	/**
	 读取下一个文本行，并移动当前索引位置。<br>
	 Read the next text line and move the current line index.
	 */
	public func readNext() -> String?
	{
		self._lineIndex += 1;
		return currentLine;
	}
	/**
	 仅得到下一个文本行。<br>
	 Only get the next text line.
	 */
	public func getNext() -> String {
		return _lines[_lineIndex + 1] ;
	}
}