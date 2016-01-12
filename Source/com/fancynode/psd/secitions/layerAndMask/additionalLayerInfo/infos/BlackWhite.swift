//
// BlackWhite.swift
// psd.swift
//
// Created by featherJ on 16/1/12.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
public class BlackWhite: AdditionalLayerInfoBase {
	public static var key: String {
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
	private var _tintColor: [String:Int]? = nil
	public var tintColor: [String:Int]? {
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
	
	override public func parse()
	{
		self.fileBytes!.position += 4;
		self.data = Descriptor.read(fileBytes!) ;

		self._red = self.data!["Rd "] as! Int;
		self._yellow = self.data!["Yllw"] as! Int
		self._green = self.data!["Grn "] as! Int
		self._cyan = self.data!["Cyn "] as! Int
		self._blue = self.data!["Bl "] as! Int
		self._magenta = self.data!["Mgnt"] as! Int
		self._tint = self.data!["useTint"] as! Int
		self._tintColor = [
			"red": self.data!["tintColor"]!!["Rd "] as! Int,
			"green": self.data!["tintColor"]!!["Grn "] as! Int,
			"blue": self.data!["tintColor"]!!["Bl "] as! Int
		]
		self._presetId = self.data!["bwPresetKind"] as! Int
		self._presetName = self.data!["blackAndWhitePresetFileName"] as! Int
	}
}