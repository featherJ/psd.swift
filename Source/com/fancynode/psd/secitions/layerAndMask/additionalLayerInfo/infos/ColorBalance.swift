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

	private var _shadows: AnyObject? = nil
	public var shadows: AnyObject? {
		get {
			return _shadows;
		}
	}
	private var _midtones: AnyObject? = nil
	public var midtones: AnyObject? {
		get {
			return _midtones;
		}
	}
	private var _highlights: AnyObject? = nil
	public var highlights: AnyObject? {
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
	
	override public func parse(){
		self._shadows = [
			"cyanRed": self.fileBytes!.readShort(),
			"magentaGreen": self.fileBytes!.readShort(),
			"yellowBlue": self.fileBytes!.readShort()
		] ;
		self._midtones = [
			"cyanRed": self.fileBytes!.readShort(),
			"magentaGreen": self.fileBytes!.readShort(),
			"yellowBlue": self.fileBytes!.readShort()
		] ;
		self._highlights = [
			"cyanRed": self.fileBytes!.readShort(),
			"magentaGreen": self.fileBytes!.readShort(),
			"yellowBlue": self.fileBytes!.readShort()
		] ;
		self._preserveLuminosity = self.fileBytes!.readShort() > 0;
	}
}