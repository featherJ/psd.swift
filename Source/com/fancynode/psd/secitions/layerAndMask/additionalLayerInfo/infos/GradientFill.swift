//
// GradientFill.swift
// psd.swift
//
// Created by featherJ on 16/1/12.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
public class GradientFill : AdditionalLayerInfoBase
{
	public class var key: String {
		get {
			return "GdFl";
		}
	}
	
	var data:NSDictionary?;
	override public func parse() {
		self.fileBytes!.position += 4;
		self.data = Descriptor.read(fileBytes!) ;
	}
}