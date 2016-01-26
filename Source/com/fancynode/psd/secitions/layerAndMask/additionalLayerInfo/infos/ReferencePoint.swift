//
// ReferencePoint.swift
// psd.swift
//
// Created by featherJ on 16/1/27.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
public class ReferencePoint : AdditionalLayerInfoBase {
	public class var key: String {
		get {
			return "fxrp";
		}
	}
	
	private var _x: Double = 0.0;
	public var x: Double {
		get {
			return _x;
		}
	}
	private var _y: Double = 0.0
	public var y: Double {
		get {
			return _y;
		}
	}
	
	override public func parse(){
		self._x = self.fileBytes!.readDouble() ;
		self._y = self.fileBytes!.readDouble() ;
	}
}