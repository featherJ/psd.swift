//
// EngineData.swift
// psd.swift
//
// Created by featherJ on 16/1/12.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation

/**
 用于解析psd文档的中Markup文本数据的解析器。<br>
 General purpose parser for the text data markup present within PSD documents.

 - author: featherJ
 */
public class EngineData
{
	private static var instance: EngineData = EngineData() ;
	
	/**
	 解析数据为一个对象<br>
	 Parse the EngineData to Object

	 - parameter bytes: 二进制数组 <br>
	 Byte array

	 - returns: 解析之后的对象 <br>
	 The Object after parsed.
	 */
	public static func parse(bytes: ByteArray) -> NSMutableDictionary? {
		return instance.parse(bytes.toString()) ;
	}
	// 用于EngineData数据解析的指令表
	// All of the instructions map
	private static let INSTRUCTIONS: [[String: Any]] = [
		["instr": InstrObjectStart.self, "match": AbstractInstruction.createMatchFunc(InstrObjectStart.regExp)],
		["instr": InstrObjectEnd.self, "match": AbstractInstruction.createMatchFunc(InstrObjectEnd.regExp)],
		["instr": InstrSingleLineArray.self, "match": AbstractInstruction.createMatchFunc(InstrSingleLineArray.regExp)],
		["instr": InstrMultiLineArrayStart.self, "match": AbstractInstruction.createMatchFunc(InstrMultiLineArrayStart.regExp)],
		["instr": InstrMultiLineArrayEnd.self, "match": AbstractInstruction.createMatchFunc(InstrMultiLineArrayEnd.regExp)],
		["instr": InstrProperty.self, "match": AbstractInstruction.createMatchFunc(InstrProperty.regExp)],
		["instr": InstrPropertyWithData.self, "match": AbstractInstruction.createMatchFunc(InstrPropertyWithData.regExp)],
		["instr": InstrString.self, "match": AbstractInstruction.createMatchFunc(InstrString.regExp)],
		["instr": InstrNumberWithDecimal.self, "match": AbstractInstruction.createMatchFunc(InstrNumberWithDecimal.regExp)],
		["instr": InstrNumber.self, "match": AbstractInstruction.createMatchFunc(InstrNumber.regExp)],
		["instr": InstrBoolean.self, "match": AbstractInstruction.createMatchFunc(InstrBoolean.regExp)],
		["instr": InstrEmpty.self, "match": AbstractInstruction.createMatchFunc(InstrEmpty.regExp)]
	] ;
	/** 文本行数据 <br> Text line datas */
	private var _textLines: TextLines?;
	/** 属性栈 <br> Property stack */
	private var _propertyStack: NSMutableArray?;
	/** 节点栈 <br> Node stack */
	private var _nodeStack: NSMutableArray?;
	private var _property: String = "";
	/** 属性 <br> Property */
	public var property: String {
		get {
			return _property;
		}
	}
	private var _node: AnyObject?;
	/** 节点 <br> Node */
	public var node: AnyObject? {
		get {
			return _node;
		}
	}
	/**
	 * 解析EngineData
	 * <p>
	 * Parses the full document.
	 * @param text 要被解析的文本数据 | The text data need to be parsed
	 * @return 解析结果 | Result
	 */
	public func parse(text: String) -> NSMutableDictionary?
	{
		self._textLines = TextLines(text) ;
		self._propertyStack = [] ;
		self._nodeStack = [] ;
		self._property = "root";
		self._node = nil;
		while (true)
		{
			let line: String? = self._textLines!.currentLine;
			if (line == nil) {
				break;
			}
			parseTokens(line!) ;
			self._textLines!.readNext() ;
		}
		return _node as? NSMutableDictionary;
	}
	
	/**
	 解析Tokens<br>
	 Parse tokens

	 - parameter text: 要被解析的文本行 | The text line need to be parsed
	 */
	func parseTokens(var text: String) -> AnyObject?
	{
		for var instr in EngineData.INSTRUCTIONS
		{
			let instrCls: AnyClass = instr["instr"] as! AnyClass ;
			let matchFunc = instr["match"] as! (text: String) -> [String] ;
			let match = matchFunc(text: text) ;
			
			if (match.count > 0) {
				let classType = instrCls as? AbstractInstruction.Type
				if let type = classType {
					let layerInfo = type.init(self, text) ;
					let data = layerInfo.execute(match)
					return data;
				}
			}
		}
		// 用于实现日语字符的显示
		// self is a hack for the Japanese character rules that the format embeds
		
		let match = AbstractInstruction.createMatchFunc(InstrString.regExp)(text: text + self._textLines!.getNext()) ;
		if (match.count > 0)
		{
			text += self._textLines!.readNext()! ;
			return InstrString(self, text).execute(match) ;
		}
		return nil;
	}
	
	/**
	 属性和节点的入栈<br>
	 Pushes a property and node onto the parsing stack.

	 - parameter property: 属性 <br> Property
	 - parameter node:     节点 <br> Node
	 */
	public func stackPush(var property: String? = nil, var _ node: AnyObject? = nil) {
		if (node == nil) {
			node = self._node;
		}
		if (property == nil) {
			property = self._property;
		}
		if (node != nil) {
			self._nodeStack!.addObject(node!) ;
		}
		if (property != nil) {
			self._propertyStack!.addObject(property!) ;
		}
	}
	
	/**
	 属性和节点的出栈<br>
	 Pops a property and node from the parsing stack

	 - returns: 属性和节点的对象 <br> The object contains property and node.
	 */
	public func stackPop() -> [String: AnyObject?]
	{
		let lastProperty = self._propertyStack!.lastObject!;
		self._propertyStack!.removeLastObject() ;
		let lastNode = self._nodeStack!.lastObject;
		self._nodeStack!.removeLastObject() ;
		
		return [
			"property": lastProperty,
			"node": lastNode
		] ;
	}
	
	/**
	 设置当前活动节点<br>
	 Sets the current active node

	 - parameter node: 指定节点 <br> Specified node
	 */
	public func setNode(node: AnyObject) {
		self._node = node;
	}
	
	/**
	 重置节点<br>
	 Creates a new node
	 */
	public func resetNode() {
		self._node = NSMutableDictionary() ;
	}
	
	/**
	 设置当前活动属性<br>
	 Sets the current active property

	 - parameter property: 指定属性 <br> Specified property
	 */
	public func setProperty(property: String = "") {
		self._property = property;
	}
	
	/**
	 用指定的属性将指定节点作为子节点<br>
	 Updates a node with a given property and child node.

	 - parameter property: 指定属性 <br> Specified property
	 - parameter node:     指定节点 <br> Specified node
	 */
	public func updateNode(property: String, _ node: AnyObject) {
		if (node is NSMutableArray) {
			let arr: NSMutableArray = node as! NSMutableArray
			arr.addObject(self._node!) ;
		}
		else {
			let currentNode = node as! NSMutableDictionary ;
			currentNode[property] = self._node!;
		}
	}
}