//
// AbstractLazyParser.swift
// psd.swift
//
// Created by featherJ on 16/1/5.
// Copyright © 2016年 fancynode. All rights reserved.
//

/**
 懒解析抽象底层。<br><br>Lazily parser abstract class.
 - author: featherJ
 */
public class AbstractLazyParser {
	
	/**
	 文件的二进制数据<br><br>
	 The bytes of psd file
	 */
	internal var fileBytes: PSDBytes;
	/**
	 总长度<br><br>
	 Total length
	 */
	internal var length: Int = 0;
	/**
	 起始位置<br><br>
	 The start position
	 */
	internal var startPos: Int = 0;
	/**
	 启动懒加载<br><br>
	 Enalbed lazy parse
	 */
	internal var lazyEnabled: Bool = true;
	public init(_ bytes: PSDBytes) {
		self.fileBytes = bytes;
	}
	/**
	 伪解析，实际为跳过该数据块。<br><br>
	 Pseudo parse, the actual to skip the data block.
	 */
	final public func parse() {
		if (lazyEnabled) {
			fileBytes.position += length;
		}
		else {
			doParse() ;
		}
	}
	/**
	 子类重写该方法做真正的解析过程。<br><br>
	 override this method to implement the real parse process
	 */
	internal func doParse() {
		
	}
	/**
	 已解析完成<br><br>
	 Has parsed
	 */
	private var parsed: Bool = false;
	/**
	 确保已经进行过了真正的解析。<br><br>
	 Ensure the real parse process has been completed.
	 */
	final internal func ensureParsed()
	{
		if (!lazyEnabled) {
			return;
		}
		if (parsed) {
			return;
		}
		parsed = true;
		let currentPos: Int = fileBytes.position;
		fileBytes.position = startPos;
		doParse() ;
		fileBytes.position = currentPos;
	}
}