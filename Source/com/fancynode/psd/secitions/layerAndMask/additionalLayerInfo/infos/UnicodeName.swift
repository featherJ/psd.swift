//
// UnicodeName.swift
// psd.swift
//
// Created by featherJ on 16/1/27.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
/**
 - author: featherJ
 */
public class UnicodeName : AdditionalLayerInfoBase {
	public class var key: String {
		get {
			return "luni";
		}
	}
	
	private var _layerName: String = "";
	/** 图层的名称 <p> The name of self layer. */
	public var layerName: String {
		get {
			return _layerName;
		}
	}
	
	override public func parse(){
		let pos = self.fileBytes!.position;
		self._layerName = self.fileBytes!.readUnicodeString() ;
		
		// The name seems to be padded with null bytes. self is the easiest solution.
		self.fileBytes!.position = pos + self.length;
	}
}