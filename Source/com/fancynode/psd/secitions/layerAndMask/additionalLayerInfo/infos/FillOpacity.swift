//
// FillOpacity.swift
// psd.swift
//
// Created by featherJ on 16/1/12.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
public class FillOpacity : AdditionalLayerInfoBase{
	public static var key: String {
		get {
			return "iOpa";
		}
	}
	
	private var _value: UInt = 0;
	public var value: UInt {
		get {
			return _value;
		}
	}
	
	override public func parse() {
		self._value = self.fileBytes!.readUnsignedByte() ;
	}
}