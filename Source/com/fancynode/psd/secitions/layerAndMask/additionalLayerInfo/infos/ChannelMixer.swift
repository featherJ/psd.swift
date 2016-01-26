//
// ChannelMixer.swift
// psd.swift
//
// Created by featherJ on 16/1/12.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
public class ChannelMixer : AdditionalLayerInfoBase
{
	public class var key: String {
		get {
			return "mixr";
		}
	}
	
	private var _monochrome: Bool = false;
	public var monochrome: Bool {
		get {
			return _monochrome;
		}
	}
	private var _color: NSMutableArray? = nil;
	public var color: NSArray? {
		get {
			return _color;
		}
	}
	
	override public func parse() {
		self.fileBytes!.position += 2;
		self._monochrome = self.fileBytes!.readShort() > 0
		self._color = NSMutableArray() ;
		for (var i = 0;i < 4;i++) {
			self._color!.push(NSDictionary(dictionary:
						[
						"redCyan": self.fileBytes!.readShort(),
						"greenMagenta": self.fileBytes!.readShort(),
						"blueYellow": self.fileBytes!.readShort(),
						"black": self.fileBytes!.readShort(),
						"constant": self.fileBytes!.readShort()
					]
				)) ;
		}
	}
}