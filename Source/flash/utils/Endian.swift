//
// Endian.swift
// ByteArray
//
// Created by featherJ on 15/12/22.
// Copyright © 2015年 Test. All rights reserved.
//

/**
 Endian 类中包含一些值，它们表示用于表示多字节数字的字节顺序。字节顺序为 bigEndian（最高有效字节位于最前）或 littleEndian（最低有效字节位于最前）。<br><br>
 The Endian class contains values that denote the byte order used to represent multibyte numbers. The byte order is either bigEndian (most significant byte first) or littleEndian (least significant byte first).
 - author: featherJ
 */
class Endian
{
	/**
	 表示多字节数字的最高有效字节位于字节序列的最前面。<p>
	 十六进制数字 0x12345678 包含 4 个字节（每个字节包含 2 个十六进制数字）。最高有效字节为 0x12。最低有效字节为 0x78。（对于等效的十进制数字 305419896，最高有效数字是 3，最低有效数字是 6）。<br><br>
	 Indicates the most significant byte of the multibyte number appears first in the sequence of bytes.<p>
	 The hexadecimal number 0x12345678 has 4 bytes (2 hexadecimal digits per byte). The most significant byte is 0x12. The least significant byte is 0x78. (For the equivalent decimal number, 305419896, the most significant digit is 3, and the least significant digit is 6).
	 */
	static let BIG_ENDIAN: String = "bigEndian";
	/**
	 表示多字节数字的最低有效字节位于字节序列的最前面。<p>
	 十六进制数字 0x12345678 包含 4 个字节（每个字节包含 2 个十六进制数字）。最高有效字节为 0x12。最低有效字节为 0x78。（对于等效的十进制数字 305419896，最高有效数字是 3，最低有效数字是 6）。<br><br>
	 Indicates the least significant byte of the multibyte number appears first in the sequence of bytes.<p>
	 The hexadecimal number 0x12345678 has 4 bytes (2 hexadecimal digits per byte). The most significant byte is 0x12. The least significant byte is 0x78. (For the equivalent decimal number, 305419896, the most significant digit is 3, and the least significant digit is 6).
	 */
	static let LITTLE_ENDIAN: String = "littleEndian";
}