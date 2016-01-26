//
// SolidColor.swift
// psd.swift
//
// Created by featherJ on 16/1/27.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
public class SolidColor : AdditionalLayerInfoBase{
	public class var key: String {
		get {
			return "SoCo";
		}
	}
	
	var data: NSDictionary?
	override public func parse()
	{
		self.fileBytes!.position += 4;
		self.data = Descriptor.read(fileBytes!) ;
	}
	
	public var color: UInt {
		get {
			return ColorUtil.rgb2Hex32(r, g, b) ;
		}
	}
	
	public var r: UInt {
		get {
			return UInt(round(Double(colorData!["Rd  "] as! NSNumber))) ;
		}
	}
	
	public var g: UInt {
		get {
			return UInt(round(Double(colorData!["Grn "] as! NSNumber))) ;
		}
	}
	
	public var b: UInt {
		get {
			return UInt(round(Double(colorData!["Bl  "] as! NSNumber))) ;
		}
	}
	
	private var colorData: NSDictionary? {
		get {
			return data!["Clr "] as? NSDictionary ;
		}
	}
}