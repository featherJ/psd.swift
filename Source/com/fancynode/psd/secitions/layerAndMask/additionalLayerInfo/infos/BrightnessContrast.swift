//
// BrightnessContrast.swift
// psd.swift
//
// Created by featherJ on 16/1/12.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
/**
 NOTE: self only has the correct values when the "Use Legacy"
 checkbox is checked. If the 'CgEd' info key is present, these
 values will all be 0. Use that info block instead.
 - author: featherJ
 */
public class BrightnessContrast : AdditionalLayerInfoBase
{
	public static var key: String {
		get {
			return "brit";
		}
	}
	
	private var _brightness: Int = 0;
	public var brightness: Int {
		get {
			return _brightness;
		}
	}
	private var _contrast: Int = 0;
	public var contrast: Int {
		get {
			return _contrast;
		}
	}
	private var _meanValue: Int = 0;
	public var meanValue: Int {
		get {
			return _meanValue;
		}
	}
	private var _labColor: Bool = false;
	public var labColor: Bool {
		get {
			return _labColor;
		}
	}
	
	override public func parse(){
		self._brightness = self.fileBytes!.readShort() ;
		self._contrast = self.fileBytes!.readShort() ;
		self._meanValue = self.fileBytes!.readShort() ;
		self._labColor = self.fileBytes!.readBoolean() ;
	}
}