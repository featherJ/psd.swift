//
// Levels.swift
// psd.swift
//
// Created by featherJ on 16/1/26.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
public class Levels : AdditionalLayerInfoBase
{
	public class var key: String {
		get {
			return "levl";
		}
	}
	
	private var _records = NSMutableArray() ;
	public var records: NSArray {
		get {
			return _records;
		}
	}
	
	override public func parse() {
		self.fileBytes!.position += 2;
		
		for (var i = 0;i < 29;i++) {
			self._records.push(NSDictionary(dictionary: [
						"inputFloor": self.fileBytes!.readShort(),
						"inputCeiling": self.fileBytes!.readShort(),
						"outputFloor": self.fileBytes!.readShort(),
						"outputCeiling": self.fileBytes!.readShort(),
						"gamma": Double(self.fileBytes!.readShort()) / 100.0
					]))
		}
		
		// Photoshop CS (8.0) additional information
		if (self.fileBytes!.position < self.infoEnd - 4) {
			let tag = self.fileBytes!.readString(4) ;
			if (tag != "Lvls") {
				// throw new Error("Extra levels key error") ;
			}
			
			self.fileBytes!.position += 2;
			
			// Count of total level record structures. Subtract the legacy number of
			// level record structures, 29, to determine how many are remaining in
			// the file for reading.
			let extraLevels = self.fileBytes!.readShort() - 29;
			
			for (var i = 0;i < extraLevels;i++) {
				self._records.push(NSDictionary(dictionary: [
							"inputFloor": self.fileBytes!.readShort(),
							"inputCeiling": self.fileBytes!.readShort(),
							"outputFloor": self.fileBytes!.readShort(),
							"outputCeiling": self.fileBytes!.readShort(),
							"gamma": Double(self.fileBytes!.readShort()) / 100.0
						])) ;
			}
		}
	}
}