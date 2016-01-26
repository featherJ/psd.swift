//
// Locked.swift
// psd.swift
//
// Created by featherJ on 16/1/27.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
public class Locked : AdditionalLayerInfoBase {
	public class var key: String {
		get {
			return "lspf";
		}
	}
	
	private var _allLocked: Bool = false;
	public var allLocked: Bool {
		get {
			return _allLocked;
		}
	}
	private var _transparencyLocked: Bool = false;
	public var transparencyLocked: Bool{
		get {
			return _transparencyLocked;
		}
	}
	private var _compositeLocked: Bool = false;
	public var compositeLocked: Bool{
		get {
			return _compositeLocked;
		}
	}
	private var _positionLocked: Bool = false;
	public var positionLocked: Bool{
		get {
			return _positionLocked;
		}
	}
	
	override public func parse()
	{
		let locked = self.fileBytes!.readInt() ;
		
		self._transparencyLocked = (locked & (0x01 << 0)) > 0 || locked == -2147483648;
		self._compositeLocked = (locked & (0x01 << 1)) > 0 || locked == -2147483648;
		self._positionLocked = (locked & (0x01 << 2)) > 0 || locked == -2147483648;
		
		self._allLocked = self._transparencyLocked && self._compositeLocked && self._positionLocked;
	}
}