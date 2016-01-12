//
// Header.swift
// psd.swift
//
// Created by featherJ on 16/1/7.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
/**
 PSD文件的头信息，保存着该图像文件的基本属性信息。<br><br>
 The file header contains the basic properties of the image.
 - author:featherJ
 */
public class Header {
	private var _sig: String = "";
	/**
	 这个值是标记此文件为PSD格式文件用的，此值永远为"8BPS"。当这个值不为"8BPS"的时候，不要试图读取这个文件。 <br><br>
	 Signature: always equal to '8BPS' . Do not try to read the file if the signature does not match this value.
	 */
	public var sig: String {
		get {
			return _sig;
		}
	}
	private var _version: UInt = 1;
	/**
	 文件版本类型只有两个值，1为PSD或PDD，2为PSB。如果词值为其他的数值，请不要试图读取文件。如果设置的值不为1或2的话，会抛出异常。<br><br>
	 Version: always equal to 1. Do not try to read the file if the version does not match this value. (**PSB** version is 2.)
	 */
	public var version: UInt {
		get {
			return _version;
		}
	}
	private var _numChannels: UInt = 1;
	/**
	 图片中的通道数量，包含任何的透明通道，值域为1-56<br><br>
	 The number of channels in the image, including any alpha channels. Supported range is 1 to 56.
	 */
	public var numChannels: UInt {
		get {
			return _numChannels;
		}
	}
	private var _height: UInt = 0;
	/**
	 图片的高度，psd/pdd文件格式支持的高度范围为1到30,000。psb文件支持的高度范围为1到300,000。<br><br>
	 The height of the image in pixels. Supported range is 1 to 30,000.(**PSB** max of 300,000.)
	 */
	public var height: UInt {
		get {
			return _height;
		}
	}
	private var _width: UInt = 0;
	/**
	 图片的宽度，psd/pdd文件格式支持的宽度范围为1到30,000。psb文件支持的宽度范围为1到300,000。<br><br>
	 The width of the image in pixels. Supported range is 1 to 30,000.(**PSB** max of 300,000)
	 */
	public var width: UInt {
		get {
			return _width;
		}
	}
	private var _depth: UInt = 0;
	/**
	 深度，每个通道的字节数，支持的值为1,8,16和32。<br><br>
	 Depth: the number of bits per channel. Supported values are 1, 8, 16 and 32.
	 */
	public var depth: UInt {
		get {
			return _depth;
		}
	}
	private var _mode: UInt = 0;
	/**
	 颜色模式<br><br>
	 The color mode of the file.
	 */
	public var mode: UInt {
		get {
			return _mode;
		}
	}
	/**
	 色彩模式名<br><br>
	 Color mode name
	 */
	public var modeName: String {
		get {
			return ColorModeConsts.MODES[Int(self._mode)] ;
		}
	}
	/**
	 是否是PSB文件格式<br><br>
	 If is PSB file format
	 */
	public var isPSB: Bool {
		get {
			return version == 2;
		}
	}
	private var fileBytes: PSDBytes;
	/**
	 构造函数<br><br>
	 Constructor
	 - parameter bytes: 文件的二进制数据<br><br>
	 The bytes of psd file
	 */
	public init(bytes: PSDBytes) {
		self.fileBytes = bytes;
	}
	/**
	 解析<br><br>
	 Parse
	 */
	public func parse() {
		self._sig = fileBytes.readString(4) ;
		self._version = fileBytes.readUnsignedShort() ;
		
		// 保留字节，必须是0 | Reserved bytes, must be 0
		fileBytes.position += 6;
		
		self._numChannels = fileBytes.readUnsignedShort() ;
		self._height = fileBytes.readUnsignedInt() ;
		self._width = fileBytes.readUnsignedInt() ;
		self._depth = fileBytes.readUnsignedShort() ;
		self._mode = fileBytes.readUnsignedShort() ;
		
		// todo
		let colorDataLen: UInt = fileBytes.readUnsignedInt() ;
		fileBytes.position += Int(colorDataLen) ;
	}
	
	public func toString() -> String
	{
		var str: String = "[Header sig:" + sig;
		str += ", version:" + FileVersionConsts.VERSIONS[Int(version)] ;
		str += ", numChannels:" + String(self.numChannels) ;
		str += ", width:" + String(self.width) ;
		str += ", height:" + String(self.height) ;
		str += ", depth:" + String(self.depth) ;
		str += ", mode:" + String(self.modeName) ;
		str += "]";
		return str;
	}
}