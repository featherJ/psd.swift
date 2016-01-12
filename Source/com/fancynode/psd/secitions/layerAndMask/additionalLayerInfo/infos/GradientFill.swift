//
// GradientFill.swift
// psd.swift
//
// Created by featherJ on 16/1/12.
// Copyright © 2016年 fancynode. All rights reserved.
//

public class GradientFill : AdditionalLayerInfoBase
{
	public static var key: String {
		get {
			return "GdFl";
		}
	}
	
	override public func parse(){
		self.fileBytes!.position += 4;
		self.data = Descriptor.read(fileBytes!) ;
	}
}