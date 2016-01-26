//
// PlacedLayer.swift
// psd.swift
//
// Created by featherJ on 16/1/27.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
public class PlacedLayer : AdditionalLayerInfoBase{
	public class var key: String {
		get {
			return "SoLd";
		}
	}
	
	var data:NSDictionary?
	override public func parse()
	{
		// Useless id/version info
		self.fileBytes!.position += 12;
		self.data = Descriptor.read(fileBytes!) ;
	}
}