//
// Curves.swift
// psd.swift
//
// Created by featherJ on 16/1/12.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation

public class Curves : AdditionalLayerInfoBase
{
	public class var key: String {
		get {
			return "curv";
		}
	}
	
	private var _curves: [AnyObject]?;
	public var curves: [AnyObject]? {
		get {
			return _curves;
		}
	}
	
	override public func parse() {
		// Padding, spec is wrong. Maybe Photoshop bug?
		self.fileBytes!.position += 1;
		
		// Version
		self.fileBytes!.position += 2;
		
		let tag = self.fileBytes!.readInt() ;
		var curveCount = 0;
		
		// Legacy data, it looks like there are 32 positions
		// where you can adjust the curve, and there is a chunk
		// of 32 bytes that determine whether that chunk is set.
		for (var i = 0; i < 32; i++)
		{
			if ((tag & (1 << i)) > 0) {
				curveCount += 1;
			}
		}
		
		self._curves = [] ;
		for (var i = 0; i < curveCount; i++)
		{
			// Before each curve is a channel index
			var count = 0;
			var curve = [String: AnyObject]() ;
			for (var j = 0; j < 32; j++)
			{
				if ((tag & (1 << j)) > 0) {
					if (count == i) {
						curve["channel_index"] = j
						break
					}
					count += 1
				}
			}
			
			let pointCount = self.fileBytes!.readShort() ;
			var points: [AnyObject] = []
			
			for (i = 0;i < pointCount;i++) {
				points.append(
					[
						"output_value": self.fileBytes!.readShort(),
						"input_value": self.fileBytes!.readShort()
					]
				)
			}
			curve["points"] = points
			self._curves!.append(curve) ;
		}
		
		if (self.fileBytes!.position < self.infoEnd - 4)
		{
			let tagStr = self.fileBytes!.readString(4) ;
			if (tagStr != "Crv ") {
				// throw new Error("Extra curves key error:" + tagStr) ;
			}
			
			self.fileBytes!.position += 2;
			
			curveCount = self.fileBytes!.readInt() ;
			var curve = [String: AnyObject]() ;
			for (var i = 0;i < curveCount;i++)
			{
				curve = ["channel_index": self.fileBytes!.readShort()] ;
				let pointCount = self.fileBytes!.readShort() ;
				
				var points: [AnyObject] = []
				for (var j = 0;j < pointCount;j++)
				{
					points.append(
						[
							"output_value": self.fileBytes!.readShort(),
							"input_value": self.fileBytes!.readShort()
						]
					) ;
				}
				curve["points"] = points ;
				self._curves!.append(curve) ;
			}
		}
	}
}