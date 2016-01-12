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
	public static func parse(bytes: ByteArray) -> AnyObject? {
		return instance.parse(bytes.toString()) ;
	}
	// // 用于EngineData数据解析的指令表
	// // All of the instructions map
	// private static const INSTRUCTIONS: Array = [
	// {"instr": InstrObjectStart, "match": AbstractInstruction.createMatchFunc(InstrObjectStart.regExp)},
	// {"instr": InstrObjectEnd, "match": AbstractInstruction.createMatchFunc(InstrObjectEnd.regExp)},
	// {"instr": InstrSingleLineArray, "match": AbstractInstruction.createMatchFunc(InstrSingleLineArray.regExp)},
	// {"instr": InstrMultiLineArrayStart, "match": AbstractInstruction.createMatchFunc(InstrMultiLineArrayStart.regExp)},
	// {"instr": InstrMultiLineArrayEnd, "match": AbstractInstruction.createMatchFunc(InstrMultiLineArrayEnd.regExp)},
	// {"instr": InstrProperty, "match": AbstractInstruction.createMatchFunc(InstrProperty.regExp)},
	// {"instr": InstrPropertyWithData, "match": AbstractInstruction.createMatchFunc(InstrPropertyWithData.regExp)},
	// {"instr": InstrString, "match": AbstractInstruction.createMatchFunc(InstrString.regExp)},
	// {"instr": InstrNumberWithDecimal, "match": AbstractInstruction.createMatchFunc(InstrNumberWithDecimal.regExp)},
	// {"instr": InstrNumber, "match": AbstractInstruction.createMatchFunc(InstrNumber.regExp)},
	// {"instr": InstrBoolean, "match": AbstractInstruction.createMatchFunc(InstrBoolean.regExp)},
	// {"instr": InstrEmpty, "match": AbstractInstruction.createMatchFunc(InstrEmpty.regExp)}
	// ] ;
	/** 文本行数据 <br> Text line datas */
	private var _textLines: TextLines?;
	/** 属性栈 <br> Property stack */
	private var _propertyStack: [AnyObject]?;
	/** 节点栈 <br> Node stack */
	private var _nodeStack: [AnyObject]?;
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
	public func parse(text: String) -> AnyObject?
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
			//parseTokens(line) ;
			self._textLines!.readNext() ;
		}
		return _node;
	}
	// /**
	// * 解析Tokens
	// * <p>
	// * Parse tokens
	// * @param text 要被解析的文本行 | The text line need to be parsed
	// */
	// public function parseTokens(text: String): Object
	// {
	// for each(var instr: Object in INSTRUCTIONS)
	// {
	// var instrCls: Class = instr["instr"] ;
	// var matchFunc: Function = instr["match"] ;
	// var match: Array = matchFunc(text) ;
	// if (match)
	// return AbstractInstruction(new instrCls(self, text)).execute(match) ;
	// }
	// // 用于实现日语字符的显示
	// // self is a hack for the Japanese character rules that the format embeds
	// match = AbstractInstruction.createMatchFunc(InstrString.regExp)(text + self._textLines.getNext()) ;
	// if (match)
	// {
	// text += self._textLines.readNext() ;
	// return new InstrString(self, text).execute(match) ;
	// }
	// throw new Error("Text = " + text + ", Line = " + self._textLines.lineIndex + 1)
	// }
	// /**
	// * 属性和节点的入栈
	// * <p>
	// * Pushes a property and node onto the parsing stack.
	// * @param property 属性 | Property
	// * @param node 节点 | Node
	// */
	// public function stackPush(property: String = null, node: Object = null): void
	// {
	// if (!node) node = self._node;
	// if (!property) property = self._property;
	// self._nodeStack.push(node) ;
	// self._propertyStack.push(property) ;
	// }
	// /**
	// * 属性和节点的出栈
	// * <p>
	// * Pops a property and node from the parsing stack
	// * @return 属性和节点的对象 | The object contains property and node.
	// */
	// public function stackPop(): Object
	// {
	// return {
	// "property": self._propertyStack.pop(),
	// "node": self._nodeStack.pop()} ;
	// }
	// /**
	// * 设置当前活动节点
	// * <p>
	// * Sets the current active node
	// * @param node 指定节点 | Specified node
	// */
	// public function setNode(node: Object): void
	// {
	// self._node = node;
	// }
	// /**
	// * 重置节点
	// * <p>
	// * Creates a new node
	// */
	// public function resetNode(): void
	// {
	// self._node = new Object() ;
	// }
	// /**
	// * 设置当前活动属性
	// * <p>
	// * Sets the current active property
	// * @param property 指定属性 | Specified property
	// */
	// public function setProperty(property: String = null): void
	// {
	// self._property = property;
	// }
	// /**
	// * 用指定的属性将指定节点作为子节点
	// * <p>
	// * Updates a node with a given property and child node.
	// * @param property 指定属性 | Specified property
	// * @param node 指定节点 | Specified node
	// */
	// public function updateNode(property: String, node: Object): void
	// {
	// if (node is Array)
	// (node as Array).push(self._node) ;
	// else
	// node[property] = self._node;
	// }
}