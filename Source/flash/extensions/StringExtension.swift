//
// StringExtensions.swift
// psd.swift
//
// Created by featherJ on 16/1/5.
// Copyright © 2016年 fancynode. All rights reserved.
//

extension String {
	/**
	 返回一个字符串，该字符串由参数中的 Unicode 字符代码所表示的字符组成。<br><br>
	 Returns a string comprising the characters represented by the Unicode character codes in the parameters.
	 - parameter charCodes: 一系列表示 Unicode 值的十进制整数。<br><br>
	 A series of decimal integers that represent Unicode values.
	 - returns: 指定的 Unicode 字符代码的字符串值。<br><br>
	 The string value of the specified Unicode character codes.
	 */
	 public static func fromCharCode(charCodes: UInt...) -> String {
		var str: String = "";
		for (var i: Int = 0;i < charCodes.count;i++) {
			str += String(UnicodeScalar(UInt32(charCodes[i]))) ;
		}
		return str;
	}
}