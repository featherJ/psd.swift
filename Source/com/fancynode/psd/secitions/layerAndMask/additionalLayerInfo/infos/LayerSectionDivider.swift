//
// LayerSectionDivider.swift
// psd.swift
//
// Created by featherJ on 16/1/12.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
public class LayerSectionDivider : AdditionalLayerInfoBase {
	public class var key: String {
		get {
			return "lsct";
		}
	}
	
	private var _layerType: String = "";
	public var layerType: String {
		get {
			return _layerType;
		}
	}
	private var _isFolder: Bool = false;
	public var isFolder: Bool {
		get {
			return _isFolder;
		}
	}
	private var _isHidden: Bool = false;
	public var isHidden: Bool {
		get {
			return _isHidden;
		}
	}
	private var _blendMode: String = "";
	public var blendMode: String {
		get {
			return _blendMode;
		}
	}
	private var _subType: String = "";
	public var subType: String {
		get {
			return _subType;
		}
	}
	
	private var SECTION_DIVIDER_TYPES: [String] = [
		"other",
		"open folder",
		"closed folder",
		"bounding section divider"
	] ;
	
	override public func initInfo(layer: LayerRecord, _ length: Int) {
		super.initInfo(layer, length) ;
		self._isFolder = false;
		self._isHidden = false;
		self._blendMode = "";
		self._subType = "";
	}
	
	override public func parse()
	{
		let code = self.fileBytes!.readInt() ;
		self._layerType = SECTION_DIVIDER_TYPES[code] ;
		switch (code)
		{
		case 1, 2:
			self._isFolder = true;
			break;
		case 3:
			self._isHidden = true;
			break;
		default:
			break;
		}
		
		if (code > 4) {
			Logger.warn("Section divider is unexpected value: #{code}") ;
		}
		
		if (!(self.length >= 12)) {
			return;
		}
		
		self.fileBytes!.position += 4; // sig;
		self._blendMode = self.fileBytes!.readString(4) ;
		
		if (!(self.length >= 16)) {
			return;
		}
		
		self._subType = fileBytes!.readInt() == 0 ? "normal" : "scene group" ;
	}
}