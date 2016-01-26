//
// Threshold.swift
// psd.swift
//
// Created by featherJ on 16/1/27.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
public class Threshold : AdditionalLayerInfoBase {
	public class var key: String {
		get {
			return "thrs";
		}
	}
	
	private var _levels: Int = 0;
	public var levels: Int {
		get {
			return _levels;
		}
	}
	override public func parse(){
		self._levels = fileBytes!.readShort() ;
		fileBytes!.position += 2;// Padding?
	}
}