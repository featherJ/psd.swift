//
// ColorLookup.swift
// psd.swift
//
// Created by featherJ on 16/1/12.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
public class ColorLookup : AdditionalLayerInfoBase
{
	public class var key: String {
		get {
			return "clrL";
		}
	}
	
	override public func parse() {
		self.fileBytes!.position += 6;
		self.data = Descriptor.read(fileBytes!) ;
	}
}