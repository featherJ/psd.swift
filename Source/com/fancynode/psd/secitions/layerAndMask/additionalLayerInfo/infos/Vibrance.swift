//
// Vibrance.swift
// psd.swift
//
// Created by featherJ on 16/1/27.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
public class Vibrance : AdditionalLayerInfoBase {
	public class var key: String {
		get {
			return "vibA";
		}
	}
	
	var data: NSDictionary?
	override public func parse()
	{
		self.fileBytes!.position += 4;
		self.data = Descriptor.read(fileBytes!) ;
	}
	
	public var vibrance: AnyObject {
		get {
			return self.data!["vibrance"]!;
		}
	}
	
	public var saturation: AnyObject {
		get {
			return self.data!["Strt"]! ;
		}
	}
}