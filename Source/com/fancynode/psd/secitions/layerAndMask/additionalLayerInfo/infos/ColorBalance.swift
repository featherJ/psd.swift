//
// ColorBalance.swift
// psd.swift
//
// Created by featherJ on 16/1/12.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation

public class ColorBalance : AdditionalLayerInfoBase
{
	public class var key: String {
		get {
			return "blnc";
		}
	}
	
	private var _shadows: NSDictionary? = nil
	public var shadows: NSDictionary? {
		get {
			return _shadows;
		}
	}
	private var _midtones: NSDictionary? = nil
	public var midtones: NSDictionary? {
		get {
			return _midtones;
		}
	}
	private var _highlights: NSDictionary? = nil
	public var highlights: NSDictionary? {
		get {
			return _highlights;
		}
	}
	private var _preserveLuminosity: Bool = false;
	public var preserveLuminosity: Bool {
		get {
			return _preserveLuminosity;
		}
	}
	
	override public func parse() {
		self._shadows = NSDictionary(dictionary: [
				"cyanRed": self.fileBytes!.readShort(),
				"magentaGreen": self.fileBytes!.readShort(),
				"yellowBlue": self.fileBytes!.readShort()
			]) ;
		self._midtones = NSDictionary(dictionary: [
				"cyanRed": self.fileBytes!.readShort(),
				"magentaGreen": self.fileBytes!.readShort(),
				"yellowBlue": self.fileBytes!.readShort()
			]) ;
		self._highlights = NSDictionary(dictionary: [
				"cyanRed": self.fileBytes!.readShort(),
				"magentaGreen": self.fileBytes!.readShort(),
				"yellowBlue": self.fileBytes!.readShort()
			]) ;
		self._preserveLuminosity = self.fileBytes!.readShort() > 0;
	}
}