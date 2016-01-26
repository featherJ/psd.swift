//
// VectorStroke.swift
// psd.swift
//
// Created by featherJ on 16/1/27.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
public class VectorStroke : AdditionalLayerInfoBase {
	public class var key: String {
		get {
			return "vstk";
		}
	}
	
	var data: NSDictionary?
	override public func parse() {
		// version
		self.fileBytes!.readInt() ;
		self.data = Descriptor.read(fileBytes!) ;
	}
}