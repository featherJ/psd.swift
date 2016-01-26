//
// SelectiveColor.swift
// psd.swift
//
// Created by featherJ on 16/1/27.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
public class SelectiveColor : AdditionalLayerInfoBase {
	public class var key: String {
		get {
			return "selc";
		}
	}
	
	private var _correctionMode: String = ""
	public var correctionMode: String {
		get {
			return _correctionMode;
		}
	}
	private var _cyanCorrection: [Int] = [] ;
	public var cyanCorrection: [Int] {
		get {
			return _cyanCorrection;
		}
	}
	private var _magentaCorrection: [Int] = [] ;
	public var magentaCorrection: [Int] {
		get {
			return _magentaCorrection;
		}
	}
	private var _yellowCorrection: [Int] = [] ;
	public var yellowCorrection: [Int] {
		get {
			return _yellowCorrection;
		}
	}
	private var _blackCorrection: [Int] = [] ;
	public var blackCorrection: [Int] {
		get {
			return _blackCorrection;
		}
	}
	
	override public func parse(){
		fileBytes!.position += 2;
		
		self._correctionMode = fileBytes!.readShort() == 0 ? "relative" : "absolute";
		
		for (var i = 0; i < 10; i++) {
			// First record is all 0 and is ignored by Photoshop
			fileBytes!.position += 8;
			if (i == 0){
				continue
			}
			self._cyanCorrection.append(fileBytes!.readShort()) ;
			self._magentaCorrection.append(fileBytes!.readShort()) ;
			self._yellowCorrection.append(fileBytes!.readShort()) ;
			self._blackCorrection.append(fileBytes!.readShort()) ;
		}
	}
}