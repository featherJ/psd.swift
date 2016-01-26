//
// PatternFill.swift
// psd.swift
//
// Created by featherJ on 16/1/27.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
public class PatternFill : AdditionalLayerInfoBase{
	public class var key: String {
		get {
			return "PtFl";
		}
	}
	
	var data: NSDictionary?
	override public func parse() {
		// Version
		self.fileBytes!.position += 4;
		self.data = Descriptor.read(fileBytes!) ;
	}
}