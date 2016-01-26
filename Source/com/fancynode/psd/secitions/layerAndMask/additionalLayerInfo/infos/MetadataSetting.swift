//
// MetadataSetting.swift
// psd.swift
//
// Created by featherJ on 16/1/27.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
public class MetadataSetting : AdditionalLayerInfoBase
{
	public class var key: String {
		get {
			return "shmd";
		}
	}
	
	var data = NSMutableDictionary();
	override public func parse(){
		let count = self.fileBytes!.readInt() ;
		for (var i = 0;i < count;i++)
		{
			self.fileBytes!.position += 4; // signature, always 8BIM;
			
			let key: String = self.fileBytes!.readString(4) ;
			//copyOnSheetDup
			self.fileBytes!.readUnsignedByte() ;
			self.fileBytes!.position += 3; // Padding;
			
			let len = self.fileBytes!.readInt() ;
			let dataEnd = self.fileBytes!.position + len;
			
			Logger.debug("Layer metadata: key = #{key}, length = " + String(len)) ;
			if (key == "cmls") {
				parseLayerCompSetting() ;
			}
			self.fileBytes!.position = dataEnd;
		}
	}
	
	private func parseLayerCompSetting(){
		self.fileBytes!.position += 4; // Version;
		self.data["layerComp"] = Descriptor.read(fileBytes!) ;
	}
}