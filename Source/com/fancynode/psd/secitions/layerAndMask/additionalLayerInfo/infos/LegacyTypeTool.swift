//
// LegacyTypeTool.swift
// psd.swift
//
// Created by featherJ on 16/1/26.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation

public class LegacyTypeTool : TypeTool{
	override public class var key: String {
		get {
			return "tySh";
		}
	}
	
	override public func parse()
	{
		//version
		self.fileBytes!.readShort() ;
		parseTransformInfo() ;
		
		// Font Information
		self.fileBytes!.readShort() ;
		
		let facesCount = self.fileBytes!.readShort() ;
		
		let currentData =  NSMutableDictionary();
		self.data = currentData
		let faces = NSMutableArray() ;
		currentData["face"] = faces ;
		for (var i = 0; i < facesCount; i++){
			let face = NSMutableDictionary() ;
			face["mark"] = self.fileBytes!.readShort() ;
			face["fontType"] = self.fileBytes!.readInt() ;
			face["fontName"] = self.fileBytes!.readString() ;
			face["fontFamilyName"] = self.fileBytes!.readString() ;
			face["fontStyleName"] = self.fileBytes!.readString() ;
			face["script"] = self.fileBytes!.readShort() ;
			face["numberAxesVector"] = self.fileBytes!.readInt() ;
			let vector = NSMutableArray() ;
			face["vector"] = vector;
			for (var j = 0; j < Int(face["numberAxesVector"] as! NSNumber) ; j++) {
				vector.push(self.fileBytes!.readInt())
			}
			faces.push(face) ;
		}
		
		// Style Information
		let stylesCount = self.fileBytes!.readShort() ;
		let styles = NSMutableArray()
		currentData["style"] = styles ;
		for (var i = 0; i < stylesCount; i++){
			let style = NSMutableDictionary() ;
			style["mark"] = self.fileBytes!.readShort() ;
			style["faceMark"] = self.fileBytes!.readShort() ;
			style["size"] = self.fileBytes!.readInt() ;
			style["tracking"] = self.fileBytes!.readInt() ;
			style["kerning"] = self.fileBytes!.readInt() ;
			style["leading"] = self.fileBytes!.readInt() ;
			style["baseShift"] = self.fileBytes!.readInt() ;
			style["autoKern"] = self.fileBytes!.readBoolean() ;
			// Bleh
			self.fileBytes!.readUnsignedByte() ;
			style["rotate"] = self.fileBytes!.readBoolean() ;
			styles.push(style) ;
		}
		
		// Text information
		currentData["type"] = self.fileBytes!.readShort() ;
		currentData["scalingFactor"] = self.fileBytes!.readInt() ;
		currentData["characterCount"] = self.fileBytes!.readInt() ;
		currentData["horzPlace"] = self.fileBytes!.readInt() ;
		currentData["vertPlace"] = self.fileBytes!.readInt() ;
		currentData["selectStart"] = self.fileBytes!.readInt() ;
		currentData["selectEnd"] = self.fileBytes!.readInt() ;
		
		let linesCount = self.fileBytes!.readShort() ;
		let lines = NSMutableArray();
		currentData["line"] = lines ;
		for (var i = 0; i < linesCount; i++){
			let line = NSMutableDictionary();
			line["charCount"] = self.fileBytes!.readInt() ;
			line["orientation"] = self.fileBytes!.readShort() ;
			line["alignment"] = self.fileBytes!.readShort() ;
			line["actualChar"] = self.fileBytes!.readShort() ;
			line["style"] = self.fileBytes!.readShort() ;
			lines.push(line);
		}
		
		// Color information
		currentData["color"] = self.fileBytes!.readSpaceColor() ;
		currentData["antialias"] = self.fileBytes!.readBoolean() ;
	}
	
	/**
	 * Not sure where self is stored right now
	 *
	 */
	override public var textValue: String {
		get {
			return "";
		}
	}
}