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
	public static var key: String {
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
	private var _color: [AnyObject]? = nil;
	public var color: [AnyObject]? {
		get {
			return _color;
		}
	}
	
	override public func parse(){
		self.fileBytes!.position += 2;
		
		self._monochrome = self.fileBytes!.readShort() > 0
		
		self._color = [] ;
		for (var i = 0;i < 4;i++){
			self._color!.append(
				[
					"redCyan": self.fileBytes!.readShort(),
					"greenMagenta": self.fileBytes!.readShort(),
					"blueYellow": self.fileBytes!.readShort(),
					"black": self.fileBytes!.readShort(),
					"constant": self.fileBytes!.readShort()
				]
			)
		}
	}
}