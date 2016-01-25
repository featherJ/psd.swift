//
// NSArrayExtension.swift
// InstanceTest
//
// Created by featherJ on 16/1/26.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
public extension NSArray {
	/**
	 将数组中的元素转换为字符串、在元素间插入指定的分隔符、连接这些元素然后返回结果字符串。
	 嵌套数组总是以逗号 (,) 分隔，而不使用传递给 join() 方法的分隔符分隔。<p>
	 Converts the elements in an array to strings, inserts the specified separator between the elements,
	 concatenates them, and returns the resulting string.
	 A nested array is always separated by a comma (,), not by the separator passed to the join() method.

	 - parameter sep: 在返回字符串中分隔数组元素的字符或字符串。如果省略此参数，则使用逗号作为默认分隔符。<p>
	 A character or string that separates array elements in the returned string.
	 If you omit this parameter, a comma is used as the default separator.

	 - returns: 一个字符串，由转换为字符串并由指定参数分隔的数组元素组成。<p>
	 A string consisting of the elements of an array converted to strings and separated by the specified parameter.
	 */
	public func join(sep: Any? = nil) -> String
	{
		let sepStr = sep != nil ? String(sep!) : ",";
		var str = "";
		for (var i = 0;i < self.length;i++) {
			if (i == self.length - 1) {
				str += String(self[i]) ;
			} else {
				str += String(self[i]) + sepStr;
			}
		}
		return str;
	}
	
	/**
	 指定数组中元素数量的非负整数。<p>
	 A non-negative integer specifying the number of elements in the array.
	 */
	public var length: Int {
		get {
			return self.count;
		}
	}
}