//
// RegExp.swift
// InstanceTest
//
// Created by featherJ on 16/1/13.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
public class RegExp
{
	let internalExpression: NSRegularExpression
	private let options: NSRegularExpressionOptions;
	public init(re: String,_ flags: String) {
		self._source = re;
		
		if (flags == "x") {
			options = NSRegularExpressionOptions.AllowCommentsAndWhitespace;
			_extended = true;
		} else if (flags == "m") {
			options = NSRegularExpressionOptions.AnchorsMatchLines;
			_multiline = true;
		} else if (flags == "s") {
			options = NSRegularExpressionOptions.DotMatchesLineSeparators;
			_dotall = true;
		} else if (flags == "i") {
			options = NSRegularExpressionOptions.CaseInsensitive;
			_ignoreCase = true;
		} else if (flags == "g") {
			options = NSRegularExpressionOptions(rawValue: 0);
			_global = true;
		}else{
			options = NSRegularExpressionOptions(rawValue: 0);
		}
		self.internalExpression = try! NSRegularExpression(pattern: self._source,options: options)
	}
	
	private var _dotall: Bool = false;
	public var dotall: Bool{
		get {
			return _dotall;
		}
	}
	
	private var _extended: Bool = false;
	public var extended: Bool{
		get {
			return _extended;
		}
	}
	
	private var _global: Bool = false;
	public var global: Bool{
		get {
			return _global;
		}
	}
	
	private var _ignoreCase: Bool = false;
	public var ignoreCase: Bool{
		get {
			return _ignoreCase;
		}
	}
	
	private var _lastIndex: Int = 0;
	public var lastIndex: Int{
		get {
			return _lastIndex;
		}
		set {
			_lastIndex = newValue;
		}
	}
	
	private var _multiline: Bool = false;
	public var multiline: Bool{
		get {
			return _multiline;
		}
	}
	
	private var _source: String = "";
	public var source: String{
		get {
			return _source;
		}
	}
	
	public func exec(str:String)-> AnyObject?{
		return nil
	}
	
	public func test(str:String)-> Bool{
		return false
	}
}