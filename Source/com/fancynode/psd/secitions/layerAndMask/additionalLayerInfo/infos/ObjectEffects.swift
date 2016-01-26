//
// ObjectEffects.swift
// psd.swift
//
// Created by featherJ on 16/1/27.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
public class ObjectEffects : AdditionalLayerInfoBase{
	public class var key: String {
		get {
			return "lfx2";
		}
	}
	
	var data: NSDictionary?
	override public func parse(){
		//version
		self.fileBytes!.readInt() ;
		//descriptorVersion
		self.fileBytes!.readInt() ;
		data = Descriptor.read(self.fileBytes!) ;
	}
}