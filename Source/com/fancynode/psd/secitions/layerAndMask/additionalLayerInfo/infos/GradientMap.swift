//
// GradientMap.swift
// psd.swift
//
// Created by featherJ on 16/1/12.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
public class GradientMap : AdditionalLayerInfoBase
{
	public class var key: String {
		get {
			return "grdm";
		}
	}
	
	private var _reverse: Bool = false;
	public var reverse: Bool {
		get {
			return _reverse;
		}
	}
	private var _dither: Bool = false;
	public var dither: Bool {
		get {
			return _dither;
		}
	}
	private var _name: String = "";
	public var name: String {
		get {
			return _name;
		}
	}
	private var _colorStops: [AnyObject]? = nil
	public var colorStops: [AnyObject]? {
		get {
			return _colorStops;
		}
	}
	private var _transparencyStops: [AnyObject]? = nil
	public var transparencyStops: [AnyObject]? {
		get {
			return _transparencyStops;
		}
	}
	private var _interpolation: Int = 0;
	public var interpolation: Int {
		get {
			return _interpolation;
		}
	}
	private var _mode: Int = 0;
	public var mode: Int {
		get {
			return _mode;
		}
	}
	private var _randomSeed: Int = 0;
	public var randomSeed: Int {
		get {
			return _randomSeed;
		}
	}
	private var _showingTransparency: Bool = false;
	public var showingTransparency: Bool {
		get {
			return _showingTransparency;
		}
	}
	private var _usingVectorColor: Bool = false;
	public var usingVectorColor: Bool {
		get {
			return _usingVectorColor;
		}
	}
	private var _roughnessFactor: Int = 0;
	public var roughnessFactor: Int {
		get {
			return _roughnessFactor;
		}
	}
	private var _colorModel: Int = 0;
	public var colorModel: Int {
		get {
			return _colorModel;
		}
	}
	private var _minimumColor: [Int]? = nil;
	public var minimumColor: [Int]? {
		get {
			return _minimumColor;
		}
	}
	private var _maximumColor: [Int]? = nil;
	public var maximumColor: [Int]? {
		get {
			return _maximumColor;
		}
	}
	
	override public func parse() {
		// Version
		fileBytes!.position += 2;
		
		self._reverse = fileBytes!.readBoolean() ;
		self._dither = fileBytes!.readBoolean() ;
		
		self._name = fileBytes!.readUnicodeString() ;
		
		var stops = fileBytes!.readShort() ;
		_colorStops = [] ;
		for (var i = 0;i < stops;i++) {
			_colorStops!.append([
					"location": fileBytes!.readInt(),
					"midpoint": fileBytes!.readInt(),
					"color": fileBytes!.readSpaceColor()
				]) ;
			
			// Mystery padding
			fileBytes!.position += 2;
		}
		
		stops = fileBytes!.readShort() ;
		_transparencyStops = [] ;
		for (var i = 0;i < stops;i++) {
			_transparencyStops!.append([
					"location": fileBytes!.readInt(),
					"midpoint": fileBytes!.readInt(),
					"opacity": fileBytes!.readShort()
				]) ;
		}
		
		let expansionCount = fileBytes!.readShort() ;
		if (expansionCount > 0) {
			self._interpolation = fileBytes!.readShort() ;
			let length = fileBytes!.readShort() ;
			if (length >= 32) {
				self._mode = fileBytes!.readShort() ;
				self._randomSeed = fileBytes!.readInt() ;
				self._showingTransparency = fileBytes!.readShort() > 0;
				self._usingVectorColor = fileBytes!.readShort() > 0;
				self._roughnessFactor = fileBytes!.readInt() ;
				
				self._colorModel = fileBytes!.readShort() ;
				self._minimumColor = [] ;
				for (var i = 0;i < 4;i++) {
					self._minimumColor!.append(fileBytes!.readShort() >> 8) ;
				}
				
				self._maximumColor = [] ;
				for (var i = 0;i < 4;i++) {
					self._maximumColor!.append(fileBytes!.readShort() >> 8) ;
				}
			}
		}
		fileBytes!.position += 2;
	}
}