//
// BlendClippingElements.swift
// psd.swift
//
// Created by featherJ on 16/1/12.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation

public class BlendClippingElements : AdditionalLayerInfoBase
{
	public class var key: String {
		get {
			return "clbl";
		}
	}

	private var _enabled: Bool = false;
	public var enabled: Bool {
		get {
			return _enabled;
		}
	}
	override public func parse() {
		self._enabled = self.fileBytes!.readBoolean() ;
		self.fileBytes!.position += 3;
	}
}