//
// VectorMask.swift
// psd.swift
//
// Created by featherJ on 16/1/27.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
public class VectorMask : AdditionalLayerInfoBase {
	public class var key: String {
		get {
			return "vmsk,vsms";
		}
	}
	
	private var _invert: Int = 0;
	public var invert: Int {
		get {
			return _invert;
		}
	}
	private var _notLink: Bool = false;
	public var notLink: Bool {
		get {
			return _notLink;
		}
	}
	private var _disable: Bool = false;
	public var disable: Bool {
		get {
			return _disable;
		}
	}
	private var _paths: [PathRecord] = [] ;
	public var paths: [PathRecord] {
		get {
			return _paths;
		}
	}
	
	override public func parse() {
		//version
		self.fileBytes!.readInt() ;
		let tag = self.fileBytes!.readInt() ;
		
		self._invert = tag & 0x01;
		self._notLink = (tag & (0x01 << 1)) > 0;
		self._disable = (tag & (0x01 << 2)) > 0;
		
		// I haven't figured out yet why self is 10 and not 8.
		let numRecords = (self.length - 10) / 26;
		for (var i = 0;i < numRecords;i++) {
			self._paths.append(PathRecord.read(fileBytes!)) ;
		}
	}
}