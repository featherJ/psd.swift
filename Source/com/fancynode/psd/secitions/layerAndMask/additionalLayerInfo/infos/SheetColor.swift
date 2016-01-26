//
// SheetColor.swift
// psd.swift
//
// Created by featherJ on 16/1/27.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
/**
 * self is the color label for a group/layer. Not sure why Adobe
 * refers to it as the "Sheet Color".
 *
 * @author featherJ
 *
 */
public class SheetColor : AdditionalLayerInfoBase {
	public class var key: String {
		get {
			return "lclr";
		}
	}
	
	private static let COLORS: [String] = [
		"no color",
		"red",
		"orange",
		"yellow",
		"green",
		"blue",
		"violet",
		"gray"
	] ;
	
	var data: [Int] = []
	override public func parse(){
		// Only the first entry is used, the rest are always 0.
		data = [
			self.fileBytes!.readShort(),
			self.fileBytes!.readShort(),
			self.fileBytes!.readShort(),
			self.fileBytes!.readShort()
		] ;
	}
	
	public var color: String {
		get {
			return SheetColor.COLORS[self.data[0]] ;
		}
	}
}