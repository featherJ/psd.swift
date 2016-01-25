//
// ContentGenerator.swift
// psd.swift
//
// Created by featherJ on 16/1/12.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
/**
 This is the new way that Photoshop stores the brightness/contrast
 data. If this data is present, DO NOT use the legacy BrightnessContrast
 info block.
 - author: featherJ
 */
public class ContentGenerator : AdditionalLayerInfoBase
{
	public static var key: String {
		get {
			return "CgEd";
		}
	}

	override public func parse() {
		// Version
		self.fileBytes!.position += 4;
		self.data = Descriptor.read(fileBytes!) ;
	}
	
	public var brightness: AnyObject {
		get {
			return self.data["Brgh"]!!;
		}
	}
	
	public var contrast: AnyObject {
		get {
			return self.data["Cntr"]!!;
		}
	}
	
	public var mean: AnyObject {
		get {
			return self.data["means"]!!;
		}
	}
	
	public var lab: AnyObject {
		get {
			return self.data["Lab "]!!;
		}
	}
	
	public var useLegacy: AnyObject {
		get {
			return self.data["useLegacy"]!!;
		}
	}
	
	public var auto: AnyObject {
		get {
			return self.data["Auto"]!!;
		}
	}
}