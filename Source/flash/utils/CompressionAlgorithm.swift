//
// CompressionAlgorithm.swift
// ByteArray
//
// Created by featherJ on 15/12/28.
// Copyright © 2015年 Test. All rights reserved.
//

/**
 CompressionAlgorithm 类为压缩和解压缩选项的名称定义字符串常量。这些常量是 ByteArray.compress() 和 ByteArray.uncompress() 方法的 algorithm 参数所使用的值。<br><br>
 The CompressionAlgorithm class defines string constants for the names of compress and uncompress options. These constants are used as values of the algorithm parameter of the ByteArray.compress() and ByteArray.uncompress() methods.
 - author: featherJ
 */
public class CompressionAlgorithm
{
	/**
	 定义用于 deflate 压缩算法的字符串。<br><br>
	 Defines the string to use for the deflate compression algorithm.
	 */
	public static let DEFLATE : String = "deflate";
	/**
	 定义用于 zlib 压缩算法的字符串。<br><br>
	 Defines the string to use for the zlib compression algorithm.
	 */
	public static let ZLIB: String = "zlib";
}