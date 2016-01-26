//
// VectorStrokeContent.swift
// psd.swift
//
// Created by featherJ on 16/1/27.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
public class VectorStrokeContent : AdditionalLayerInfoBase {
	public class var key: String {
		get {
			return "vscg";
		}
	}
	
	private var _key: String = ""
	public var key: String {
		get {
			return _key;
		}
	}
	
	var data: NSDictionary?
	override public func parse() {
		self._key = self.fileBytes!.readString(4) ;
		// version
		self.fileBytes!.readInt() ;
		self.data = Descriptor.read(fileBytes!) ;
	}
}