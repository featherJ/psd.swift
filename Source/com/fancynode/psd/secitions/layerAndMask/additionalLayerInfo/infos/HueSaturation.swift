//
// HueSaturation.swift
// psd.swift
//
// Created by featherJ on 16/1/12.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
public class HueSaturation : AdditionalLayerInfoBase
{
	public class var key: String {
		get {
			return "hue2";
		}
	}
	
	private var _type: String = "";
	public var type: String {
		get {
			return _type;
		}
	}
	private var _colorization: AnyObject?;
	public var colorization: AnyObject? {
		get {
			return _colorization;
		}
	}
	private var _master: AnyObject?;
	public var master: AnyObject? {
		get {
			return _master;
		}
	}
	private var _rangeValues: [Int]?;
	public var rangeValues: [Int]? {
		get {
			return _rangeValues;
		}
	}
	private var _settingValues: [Int]?;
	public var settingValues: [Int]? {
		get {
			return _settingValues;
		}
	}
	
	override public func parse() {
		// Version
		self.fileBytes!.position += 2;
		
		self._type = fileBytes!.readUnsignedByte() == 0 ? "hue" : "colorization";
		
		// Padding byte
		self.fileBytes!.position += 1;
		
		self._colorization = [
			"hue:": self.fileBytes!.readShort(),
			"saturation": self.fileBytes!.readShort(),
			"lightness": self.fileBytes!.readShort()
		] ;
		
		self._master = [
			"hue:": self.fileBytes!.readShort(),
			"saturation": self.fileBytes!.readShort(),
			"lightness": self.fileBytes!.readShort()
		] ;
		
		self._rangeValues = [] ;
		self._settingValues = [] ;
		
		for (var i = 0;i < 6;i++)
		{
			for (var j = 0;j < 4;j++) {
				self._rangeValues!.append(self.fileBytes!.readShort()) ;
			}
			for (var j = 0;j < 3;j++) {
				self._settingValues!.append(self.fileBytes!.readShort()) ;
			}
		}
	}
}