//
// RLEParser.swift
// psd.swift
//
// Created by featherJ on 16/1/11.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation

/**
 RLE数据解析器。<br>RLE data parser.
 - author: featherJ
 */
class RLEParser {
	private static var parser: RLEParser = RLEParser() ;
	/**
	 解析RLE数据为一个通道渲染数据<code>ChannelRenderData</code>。<br>
	 Parse RLE data to a <code>ChannelRenderData</code>
	 - parameter bytes:       PSD文件数据流 <br> The bytes of a psd file.
	 - parameter numChannels: 通道数量 <br> The number of channels.
	 - parameter width:       图像宽度 <br> The width of image
	 - parameter height:      图像高度 <br> The height of image
	 - returns: 通道渲染数据 <br> The data for channel rendering <code>ChannelRenderData</code>.
	 */
	static func parse(bytes: ByteArray, _ numChannels: UInt, _ width: UInt, _ height: UInt) -> ChannelRenderData {
		return parser.parseRLE(bytes, numChannels, width, height) ;
	}
	/**
	 解析RLE数据为一个通道渲染数据<code>ChannelRenderData</code>。<br>
	 Parse RLE data to a <code>ChannelRenderData</code>
	 - parameter bytes:       PSD文件数据流 <br> The bytes of a psd file.
	 - parameter numChannels: 通道数量 <br> The number of channels.
	 - parameter width:       图像宽度 <br> The width of image
	 - parameter height:      图像高度 <br> The height of image
	 - returns: 通道渲染数据 <br> The data for channel rendering <code>ChannelRenderData</code>.
	 */
	func parseRLE(bytes: ByteArray, _ numChannels: UInt, _ width: UInt, _ height: UInt) -> ChannelRenderData {
		let byteCounts: [UInt] = parseByteCounts(bytes, numChannels, height) ;
		return parseChannelData(bytes, byteCounts, numChannels, width, height) ;
	}
	
	/**
	 解析每一行的长度。<br>
	 Parse the length of each line.
	 - parameter bytes:       PSD文件数据流 <br> The bytes of a psd file.
	 - parameter numChannels: 通道数量 <br> The number of channels.
	 - parameter height:      图像高度 <br> The height of image.
	 - returns: 行长度信息 <br> The lenght infomation of lines.
	 */
	private func parseByteCounts(bytes: ByteArray, _ numChannels: UInt, _ height: UInt) -> [UInt] {
		var byteCounts: [UInt] = [] ;
		let numLines: UInt = numChannels * height;
		for (var i: UInt = 0; i < numLines; i++) {
			byteCounts.append(bytes.readUnsignedShort()) ;
		}
		return byteCounts;
	}
	/**
	 解析通道数据。<br>
	 Parse the data of channels.
	 - parameter bytes:       PSD文件数据流 <br> The bytes of a psd file.
	 - parameter byteCounts:  行长度信息 <br> The lenght infomation of lines
	 - parameter numChannels: 通道数量 <br> The number of channels.
	 - parameter width:       图像宽度 <br> The width of image
	 - parameter height:      图像高度 <br> The height of image
	 - returns: 通道渲染数据 <br> The data for channel rendering <code>ChannelRenderData</code>.
	 */
	private func parseChannelData(bytes: ByteArray, _ byteCounts: [UInt], _ numChannels: UInt, _ width: UInt, _ height: UInt) -> ChannelRenderData {
		let unpackLen: UInt = width;
		let crd: ChannelRenderData = ChannelRenderData() ;
		crd.numChannels = numChannels;
		crd.width = width;
		crd.height = height;
		for (var channel: UInt = 0; channel < numChannels; ++channel) {
			decodeRleChannel(bytes, crd, byteCounts, channel, height, unpackLen) ;
		}
		return crd;
	}
	/**
	 解析RLE的单个通道。<br>
	 Parse the data of a RLE channel.
	 - parameter bytes:      PSD文件数据流 <br> The bytes of a psd file.
	 - parameter crd:        通道渲染数据 <br> The data for channel rendering <code>ChannelRenderData</code>.
	 - parameter byteCounts: 行长度信息 <br> The lenght infomation of lines
	 - parameter channel:    当前通道索引 <br> Current channel index
	 - parameter height:     画布高度 <br> The height of canvas
	 - parameter unpackLen:  解包后的长度 <br> The length of unpacked data
	 */
	private func decodeRleChannel(bytes: ByteArray, _ crd: ChannelRenderData, _ byteCounts: [UInt], _ channel: UInt, _ height: UInt, _ unpackLen: UInt) {
		let line: ByteArray = ByteArray() ;
		for (var i: UInt = 0; i < height; ++i) {
			line.clear() ;
			bytes.readBytes(line, 0, Int(byteCounts[Int(channel * height + i)])) ;
			let unpacked: ByteArray = RLEParser.unpackFast(line) ;
			crd.channelBytes.writeBytes(unpacked, 0, Int(unpackLen)) ;
		}
		if (channel + 1 < crd.numChannels) {
			crd.startPostions[Int(channel + 1)] = UInt(crd.channelBytes.length) // 一个通道读取完成 | one channel finish
		}
	}
	
	/**
	 利用内存快速进行行数据解包.<br>
	 Unpack the line data use memory
	 - parameter packed: 要解包的行数据 <br> The line data need to unpack.
	 - returns: 解包之后的数据 <br> Data after unpacked.
	 */
	static func unpackFast(packed: ByteArray) -> ByteArray{
		let unpacked: ByteArray = ByteArray() ;
		var q: Int;
		var n: Int;
		var byte: Int;
		var count: Int;
		while (packed.bytesAvailable > 0) {
			n = packed.readByte() ;
			if (n >= 0) {
				count = n + 1;
				for (q = 0; q < count; ++q) {
					unpacked.writeByte(packed.readByte())
				}
			}
			else {
				byte = packed.readByte() ;
				count = 1 - n;
				for (q = 0; q < count; ++q) {
					unpacked.writeByte(byte)
				}
			}
		}
		return unpacked;
	}
}