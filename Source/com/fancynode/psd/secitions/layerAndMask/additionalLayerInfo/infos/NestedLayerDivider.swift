//
// NestedLayerDivider.swift
// psd.swift
//
// Created by featherJ on 16/1/27.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
/**
 * Not 100% sure what the purpose of this key is, but it seems to exist
 * whenever the lsct key doesn't. Parsing this like a layer section
 * divider seems to solve a lot of parsing issues with folders.
 *
 * See https://github.com/layervault/psd.rb/issues/38
 *
 * @author featherJ
 *
 */
public class NestedLayerDivider : AdditionalLayerInfoBase{
	public class var key: String {
		get {
			return "lsdk";
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
	
	override public func parse()
	{
		let code = self.fileBytes!.readInt() ;
		
		switch (code){
		case 1, 2:
			self._isFolder = true;
			break;
		case 3:
			self._isHidden = true;
			break;
		default:
			break;
		}
	}
}