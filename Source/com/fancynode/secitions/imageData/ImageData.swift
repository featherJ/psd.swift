//
// ImageData.swift
// psd.swift
//
// Created by featherJ on 16/1/8.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation

/**
 Psd文档最后的完整预览图。<br><br>The full preview image at the end of the PSD document.
 - author:featherJ
 */
public class ImageData : AbstractLazyParser
{
	static let COMPRESSIONS: [String] = ["Raw", "RLE", "ZIP", "ZIPPrediction"] ;
	static let COMP_RAW: UInt = 0; // Raw数据 | Raw Data
	static let COMP_RLE: UInt = 1; // RLE数据 | RLE compressed
	static let COMP_ZIP: UInt = 2; // ZIP无预期 | ZIP without prediction
	static let COMP_ZIP_PREDICTION: UInt = 3; // ZIP有预期 | ZIP with prediction
	
	/** 图像宽度 <br><br> Image width */
	public var width: UInt {
		get {
			return self.header.width;
		}
	}
	
	/** 图像高度 <br><br> Image height */
	public var height: UInt {
		get {
			return self.header.height;
		}
	}
	/** 图像深度 <br><br> Image depth */
	public var depth: UInt {
		get {
			return self.header.depth;
		}
	}
	/** 图像色彩模型 <br><br> Image color mode */
	public var mode: UInt {
		get {
			return self.header.mode;
		}
	}
	/** 通道数量 <br><br> The number of channels */
	public var numChannels: UInt {
		get {
			return self.header.numChannels;
		}
	}
	
	internal var _channelRenderData: ChannelRenderData? = nil;
	/** 可供渲染的通道数据 <br><br> Channel data for rendering */
	public var channelRenderData: ChannelRenderData? {
		get {
			ensureParsed() ;
			return _channelRenderData;
		}
	}
	internal var _opacity: Double;
	/** 不透明度 <br><br> Opacity */
	public var opacity: Double {
		get {
			return _opacity;
		}
	}
	internal var _hasMask: Bool;
	/** 是否有遮罩 <br><br> If has mask */
	public var hasMask: Bool {
		get {
			return _hasMask;
		}
	}
	
	/** 文件头 <br><br> Psd header */
	internal var header: Header;
	/** 单通道长度 <br><br> Channel length*/
	private var channelLength: UInt = 0;
	/** 结束位置 <br><br> The end position */
	internal var endPos: Int = 0;
	/** 图像数据压缩类型 <br><br> The compression type of image data*/
	private var compression: UInt = 0;;
	/**
	 构造函数 <br><br> Constructor
	 - parameter bytes:  文件的二进制数据 <br><br> The bytes of psd file
	 - parameter header: 文件头 <br><br> Psd header
	 */
	public init(_ bytes: PSDBytes, _ header: Header)
	{
		self._opacity = 1.0;
		self._hasMask = false;
		self.header = header;
		super.init(bytes) ;
		calculateLength() ;
		self.startPos = self.fileBytes.position;
		self.endPos = self.startPos + self.length;
	}
	/**
	 解析 <br><br>
	 Parse
	 */
	override internal func doParse()
	{
		self.compression = parseCompression() ;
		Logger.debug("Compression: id = " + String(self.compression) + ", name = " + ImageData.COMPRESSIONS[Int(self.compression)]) ;
		parseChannelData() ;
	}
	/**
	 计算通道长度和总长度 <br><br>
	 Calculate the channel length and the total length
	 */
	internal func calculateLength() {
		switch (depth) {
		case 1:
			self.channelLength = (width + 7) / 8 * height
			break;
		case 16:
			self.channelLength = width * height * 2
			break;
		default:
			self.channelLength = width * height
			break;
		}
		self.length = Int(self.channelLength * numChannels) ;
	}
	/**
	 解析压缩类型 <br><br>
	 Parse the compression type of image data
	 */
	internal func parseCompression() -> UInt {
		return self.fileBytes.readUnsignedShort() ;
	}
	/**
	 解析通道数据 <br><br>
	 Parse the channel data
	 */
	private func parseChannelData()
	{
		switch (self.compression)
		{
		case ImageData.COMP_RAW: // Raw
			self._channelRenderData = RAWParser.parse(fileBytes, self.numChannels, self.channelLength, width, height) ;
			break;
		case ImageData.COMP_RLE: // RLE
			self._channelRenderData = RLEParser.parse(fileBytes, self.numChannels, width, height) ;
			break;
//		case ImageData.COMP_ZIP:
//		case ImageData.COMP_ZIP_PREDICTION: // 我不认为这里会有ZIP压缩，因为压缩后通道长度无法确定.
			// I don't think there will be a ZIP compression, because the length per channel can not be determined after compression.
		default:
			fileBytes.position = self.endPos;
			break;
		}
		if (self._channelRenderData != nil)
		{
			self._channelRenderData!.mode = self.mode;
			self._channelRenderData!.depth = self.depth;
		}
	}
}