//
// ChannelRenderData.swift
// psd.swift
//
// Created by featherJ on 16/1/5.
// Copyright © 2016年 fancynode. All rights reserved.
//

/**
 用于渲染通道的数据。<code>channelBytes</code>。<br><br>
 The data for channel rendering. The <code>channelBytes</code> contents
 - author: featherJ
 */
public class ChannelRenderData {
	public init() {
		channelBytes = ByteArray() ;
		channelBytes.endian = Endian.LITTLE_ENDIAN;
	}
	/**
	 多个通道的数据。<br><br>
	 Multiple channel data
	 */
	public var channelBytes: ByteArray;
	/**
	 通道的起始位置。<br><br>
	 The start position of channels.
	 */
	public var startPostions: [UInt] = [] ;
	
	private var _numChannels: UInt = 0;
	/**
	 通道的数量<br><br>
	 The number of channels.
	 */
	public var numChannels: UInt {
		get {
			return self._numChannels;
		}
		set {
			self._numChannels = newValue;
			for (var i:UInt = 0;i < self._numChannels;i++) {
				startPostions.append(0) ;
			}
		}
	}
	/**
	 颜色模式<br><br>
	 Color mode
	 <li>1: greyscale
	 <li>3: rgb
	 <li>4: cmyk
	 */
	public var mode: UInt = 3;
	/**
	 图像宽度<br><br>
	 The width of iamge
	 */
	public var width: UInt = 0;
	/**
	 图像高度<br><br>
	 The height of iamge
	 */
	public var height: UInt = 0;;
	/**
	 图像深度<br><br>
	 The depth of iamge
	 */
	public var depth: UInt = 0;
	/**
	 像素扫描间隔<br><br>
	 The step to scan the pixels.
	 */
	public var pixelStep: UInt {
		get {
			return depth == 8 ? 1 : 2;
		}
	}
}