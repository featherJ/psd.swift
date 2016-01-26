//
// LayerID.swift
// psd.swift
//
// Created by featherJ on 16/1/12.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation

public class LayerID : AdditionalLayerInfoBase {
	public class var key: String {
		get {
			return "lyid";
		}
	}
	
	private var _id: Int = 0;
	public var id: Int {
		get {
			return _id;
		}
	}
	
	override public func parse() {
		self._id = self.fileBytes!.readInt() ;
	}
}
