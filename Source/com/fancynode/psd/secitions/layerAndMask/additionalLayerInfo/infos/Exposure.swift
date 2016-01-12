//
// Exposure.swift
// psd.swift
//
// Created by featherJ on 16/1/12.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
public class Exposure : AdditionalLayerInfoBase {
	public static var key: String {
		get {
			return "expA";}
	}
	private var _exposure: Float = 0;
	public var exposure: Float{
		get{
		return _exposure;
		}
	}
	private var _offset: Float = 0;
	public var offset: Float{
		get{
		return _offset;
		}
	}
	private var _gamma: Float = 0;
	public var gamma: Float{
		get{
		return _gamma;
		}
	}
	
	override public func parse(){
		self.fileBytes!.position += 2;
		
		// Why self shit is big endian is beyond me. Thanks Adobe.
		self._exposure = self.fileBytes!.readFloat() ;
		self._offset = self.fileBytes!.readFloat() ;
		self._gamma = self.fileBytes!.readFloat() ;
	}
}
