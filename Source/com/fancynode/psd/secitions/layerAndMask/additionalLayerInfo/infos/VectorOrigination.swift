//
// VectorOrigination.swift
// psd.swift
//
// Created by featherJ on 16/1/27.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
public class VectorOrigination : AdditionalLayerInfoBase {
	public class var key: String {
		get {
			return "vogk";
		}
	}
	
	var data: NSDictionary?
	override public func parse() {
		self.fileBytes!.position += 8;
		self.data = Descriptor.read(fileBytes!) ;
	}
}