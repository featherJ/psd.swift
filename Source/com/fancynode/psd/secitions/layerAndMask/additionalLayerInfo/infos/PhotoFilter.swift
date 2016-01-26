//
// PhotoFilter.swift
// psd.swift
//
// Created by featherJ on 16/1/27.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
public class PhotoFilter : AdditionalLayerInfoBase{
	public class var key: String {
		get {
			return "phfl";
		}
	}
	
	private var _color: NSDictionary?;
	public var color: NSDictionary? {
		get {
			return _color;
		}
	}
	private var _density: Int = 0;
	public var density: Int {
		get {
			return _density;
		}
	}
	private var _preserveLuminosity: Bool = false;
	public var preserveLuminosity: Bool {
		get {
			return _preserveLuminosity;
		}
	}
	
	override public func parse() {
		let version = self.fileBytes!.readShort() ;
		switch (version) {
		case 2:
			parseVersion2() ;
			break;
		case 3:
			parse_version_3() ;
			break;
		default:
			return;
		}
		
		self._density = self.fileBytes!.readInt() ;
		self._preserveLuminosity = self.fileBytes!.readBoolean() ;
	}
	
	private func parseVersion2() {
		let colorSpace = self.fileBytes!.readShort() ;
		let colorComponents: NSArray = NSArray(array: [
				self.fileBytes!.readShort(),
				self.fileBytes!.readShort(),
				self.fileBytes!.readShort(),
				self.fileBytes!.readShort()
			]) ;
		
		self._color = [
			"colorSpace": ColorUtil.COLOR_SPACE[colorSpace] != nil ? ColorUtil.COLOR_SPACE[colorSpace]! : "",
			"components": colorComponents
		] ;
	}
	
	private func parse_version_3() {
		self._color = NSDictionary(dictionary: [
				"x": self.fileBytes!.readInt() >> 8,
				"y": self.fileBytes!.readInt() >> 8,
				"z": self.fileBytes!.readInt() >> 8
			]) ;
	}
}