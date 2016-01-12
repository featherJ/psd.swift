//
// Invert.swift
// psd.swift
//
// Created by featherJ on 16/1/12.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation

public class Invert : AdditionalLayerInfoBase {
	public static var key: String {
		get {
			return "nvrt";
		}
	}
	
	private var _inverted: Bool = false;
	public var inverted: Bool{
		get {
			return _inverted;
		}
	}
	
	override public func parse(){
		// There is no data. The presence of this info block is
		// all that's provided.
		self._inverted = true;
	}
}