//
// LayerNameSource.swift
// psd.swift
//
// Created by featherJ on 16/1/12.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation

public class LayerNameSource : AdditionalLayerInfoBase {
	public class var key: String {
		get {
			return "lnsr";
		}
	}
	
	private var _id: String = "";
	public var id: String {
		get {
			return _id;
		}
	}
	
	override public func parse() {
		self._id = self.fileBytes!.readString(4) ;
	}
}
