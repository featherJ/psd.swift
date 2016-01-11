//
// LayerRecord.swift
// psd.swift
//
// Created by featherJ on 16/1/11.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation

public class LayerRecord {
	
	private var header: Header;
	
	public init(bytes: PSDBytes, _ header: Header)
	{
		self._fileBytes = bytes;
		self.header = header;
	}
	
	private var _fileBytes: PSDBytes
	/** 文件的二进制数据 <br> The bytes of psd file */
	public var fileBytes: PSDBytes {
		get {
			return _fileBytes;
		}
	}
}
