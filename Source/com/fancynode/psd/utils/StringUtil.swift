//
// StringUtil.swift
// psd.swift
//
// Created by featherJ on 16/1/12.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
/**
 字符串工具<br>
 String util
 - author: featherJ
 */
public class StringUtil
{
	/**
	 去掉字符串两端所有连续的不可见字符。<br>
	 注意：若目标字符串为 <code>null</code> 或不含有任何可见字符,将输出空字符串""。<p>
	 Removes all whitespace characters from the beginning and end of the specified string.<br>
	 Notice: Return "" if the specified string is <code>null<code>.

	 - parameter str: 要格式化的字符串 <br>
	 The String whose whitespace should be trimmed.

	 - returns: 格式化之后的字符串 <br>
	 Updated String where whitespace was removed from the beginning and end.
	 */
	public static func trim(str: String?) -> String {
		return trimLeft(trimRight(str)) ;
	}
	/**
	 去除字符串左边所有连续的不可见字符。<br>
	 注意：若目标字符串为 <code>null</code> 或不含有任何可见字符,将输出空字符串""。<p>
	 Removes all whitespace characters from the beginning of the specified string.<br>
	 Notice: Return "" if the specified string is <code>null<code>.

	 - parameter str: 要格式化的字符串 <br>
	 The String whose whitespace should be trimmed.

	 - returns: 格式化之后的字符串 <br>
	 Updated String where whitespace was removed from the beginning and end.
	 */
	public static func trimLeft(str: String?) -> String {
		if (str == nil || str == "") {
			return "";
		}
		var currentStr = str!;
		var char: String = currentStr.charAt(0) ;
		while (currentStr.length > 0 && (char == " " || char == "\t" || char == "\n" || char == "\r" || char.charCodeAt(0)! == 12)) {
			currentStr = currentStr.substr(1) ;
			char = currentStr.charAt(0) ;
		}
		return currentStr;
	}
	
	/**
	 去除字符串右边所有连续的不可见字符。<br>
	 注意：若目标字符串为 <code>null</code> 或不含有任何可见字符,将输出空字符串""。<p>
	 Removes all whitespace characters from the end of the specified string.<br>
	 Notice: Return "" if the specified string is <code>null<code>.

	 - parameter str: 要格式化的字符串 <br>
	 The String whose whitespace should be trimmed.

	 - returns: 格式化之后的字符串 <br>
	 Updated String where whitespace was removed from the beginning and end.
	 */
	public static func trimRight(str: String?) -> String
	{
		if (str == nil || str == "") {
			return "";
		}
		var currentStr = str!;
		var char: String = currentStr.charAt(currentStr.length - 1) ;
		while (currentStr.length > 0 && (char == " " || char == "\t" || char == "\n" || char == "\r" || char.charCodeAt(0)! == 12))
		{
			currentStr = currentStr.substr(0, currentStr.length - 1) ;
			char = currentStr.charAt(currentStr.length - 1) ;
		}
		return currentStr;
	}
}
