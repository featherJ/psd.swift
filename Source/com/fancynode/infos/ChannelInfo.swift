//
// ChannelInfo.swift
// psd.swift
//
// Created by featherJ on 16/1/5.
// Copyright © 2016年 fancynode. All rights reserved.
//

/**
 通道信息<br><br>
 Channel Info
 - author: featherJ
 */

class ChannelInfo {
	/**
	 构造函数
	 <br><br>
	 Constructor
	 - parameter id:通道的ID<br><br>
	 ID of channel
	 - parameter length: 通道数据的长度<br><br>
	 Length of channel data
	 - returns: ChannelInfo
	 */
	init(id: Int, length: Int) {
		self.id = id;
		self.length = length;
	}
	/**
	 通道的ID<br><br>
	 ID of channel
	 */
	var id: Int;
	/**
	 通道数据的长度<br><br>
	 Length of channel data
	 */
	var length: Int;
	
	func toString() -> String{
		return "[ChannelInfo id:" + String(id) + ", length:" + String(length) + "]";
	}
}