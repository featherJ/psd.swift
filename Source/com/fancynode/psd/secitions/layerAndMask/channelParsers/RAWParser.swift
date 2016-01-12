//
// RAWParser.swift
// psd.swift
//
// Created by featherJ on 16/1/11.
// Copyright © 2016年 fancynode. All rights reserved.
//


/**
 Raw数据解析器。<br>Raw data parser.
 - author: featherJ
 */
class RAWParser{
	private static var parser: RAWParser = RAWParser() ;
	/**
	 解析RAW数据为一个通道渲染数据<code>ChannelRenderData</code>。<br>
	 Parse RAW data to a <code>ChannelRenderData</code>
	 - parameter bytes:         PSD文件数据流 <br> The bytes of a psd file.
	 - parameter numChannels:   通道数量 <br> The number of channels.
	 - parameter channelLength: 每个通道的长度 <br> the length per a singel channel.
	 - parameter width:         画布宽度 <br> The width of canvas
	 - parameter height:        画布高度 <br> The height of canvas
	 - returns: 通道渲染数据 <br> The data for channel rendering <code>ChannelRenderData</code>.
	 */
	static func parse(bytes: ByteArray, _ numChannels: UInt, _ channelLength: UInt, _ width: UInt, _ height: UInt) -> ChannelRenderData{
		return parser.parseRAW(bytes, numChannels, channelLength, width, height) ;
	}
	/**
	 解析RAW数据为一个通道渲染数据<code>ChannelRenderData</code>。<br>
	 Parse RAW data to a <code>ChannelRenderData</code>
	 - parameter bytes:         PSD文件数据流 <br> The bytes of a psd file.
	 - parameter numChannels:   通道数量 <br> The number of channels.
	 - parameter channelLength: 每个通道的长度 <br> the length per a singel channel.
	 - parameter width:         画布宽度 <br> The width of canvas
	 - parameter height:        画布高度 <br> The height of canvas
	 - returns: 通道渲染数据 <br> The data for channel rendering <code>ChannelRenderData</code>.
	 */
	func parseRAW(bytes: ByteArray, _ numChannels: UInt, _ channelLength: UInt, _ width: UInt, _ height: UInt) -> ChannelRenderData{
		let crd: ChannelRenderData = ChannelRenderData() ;
		crd.numChannels = numChannels;
		crd.width = width;
		crd.height = height;
		for (var channel: UInt = 0; channel < numChannels; channel++){
			bytes.readBytes(crd.channelBytes, crd.channelBytes.length, Int(channelLength)) ;
			if (channel + 1 < crd.numChannels) {
				crd.startPostions[Int(channel + 1)] = UInt(crd.channelBytes.length) // 一个通道读取完成 | one channel finish
			}
		}
		return crd;
	}
}