//
// BlackWhite.swift
// psd.swift
//
// Created by featherJ on 16/1/12.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
public class BlackWhite: AdditionalLayerInfoBase {
	public class var key: String {
		get {
			return "blwh";
		}
	}
	
	private var _red: Int = 0;
	public var red: Int {
		get {
			return _red;
		}
	}
	private var _yellow: Int = 0;
	public var yellow: Int {
		get {
			return _yellow;
		}
	}
	private var _green: Int = 0;
	public var green: Int {
		get {
			return _green;
		}
	}
	private var _cyan: Int = 0;
	public var cyan: Int {
		get {
			return _cyan;
		}
	}
	private var _blue: Int = 0;
	public var blue: Int {
		get {
			return _blue;
		}
	}
	private var _magenta: Int = 0;
	public var magenta: Int {
		get {
			return _magenta;
		}
	}
	private var _tint: Int = 0;
	public var tint: Int {
		get {
			return _tint;
		}
	}
	private var _tintColor: NSDictionary? = nil
	public var tintColor: NSDictionary? {
		get {
			return _tintColor;
		}
	}
	private var _presetId: Int = 0;
	public var presetId: Int {
		get {
			return _presetId;
		}
	}
	private var _presetName: Int = 0;
	public var presetName: Int {
		get {
			return _presetName;
		}
	}
	
	var data: NSDictionary?;
	override public func parse()
	{
		self.fileBytes!.position += 4;
		self.data = Descriptor.read(fileBytes!) ;
		
		self._red = self.data!["Rd "] != nil ? Int(self.data!["Rd "] as! NSNumber) : 0;
		self._yellow = self.data!["Yllw"] != nil ? Int(self.data!["Yllw"] as! NSNumber) : 0;
		self._green = self.data!["Grn "] != nil ? Int(self.data!["Grn "] as! NSNumber) : 0
		self._cyan = self.data!["Cyn "] != nil ? Int(self.data!["Cyn "] as! NSNumber) : 0;
		self._blue = self.data!["Bl "] != nil ? Int(self.data!["Bl "] as! NSNumber) : 0;
		self._magenta = self.data!["Mgnt"] != nil ? Int(self.data!["Mgnt"] as! NSNumber): 0;
		self._tint = self.data!["useTint"] != nil ? Int(self.data!["useTint"] as! NSNumber) : 0;
		if let tintColor = self.data!["tintColor"] as? NSDictionary {
			self._tintColor = NSDictionary(dictionary: [
					"red": tintColor["Rd "] != nil ? Int(tintColor["Rd "] as! NSNumber) : 0,
					"green": tintColor["Grn "] != nil ? Int(tintColor["Grn "] as! NSNumber) : 0,
					"blue": tintColor["Bl "] != nil ? Int(tintColor["Bl "] as! NSNumber) : 0
				]) ;
		}
		self._presetId = self.data!["bwPresetKind"] != nil ? Int(self.data!["bwPresetKind"] as! NSNumber) : 0;
		self._presetName = self.data!["blackAndWhitePresetFileName"] != nil ? Int(self.data!["blackAndWhitePresetFileName"] as! NSNumber) : 0;
	}
}