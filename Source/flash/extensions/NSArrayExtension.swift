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
	 将参数中指定的元素与数组中的元素连接，并创建新的数组。
	 如果这些参数指定了一个数组，将连接该数组中的元素。
	 如果不传递任何参数，则新数组是原始数组的副本（浅表克隆）<p>
	 Concatenates the elements specified in the parameters
	 with the elements in an array and creates a new array.
	 If the parameters specify an array, the elements of
	 that array are concatenated. If you don't pass any
	 parameters, the new array is a duplicate (shallow clone)
	 of the original array.

	 - parameter args: 要连接到新数组中的任意数据类型的值（如数字、元素或字符串）。<p>
	 A value of any data type (such as numbers, elements, or strings)
	 to be concatenated in a new array.

	 - returns: 一个数组，其中包含此数组中的元素，后跟参数中的元素。<p>
	 An array that contains the elements from this array followed by
	 elements from the parameters.
	 */
	public func concat(args: AnyObject...) -> NSMutableArray {
		let newArray: NSMutableArray = NSMutableArray()
		for (var i = 0;i < self.count;i++) {
			newArray.addObject(self[i]) ;
		}
		for (var i = 0;i < args.count;i++) {
			if (args[i] is NSArray) {
				let currentArray = args[i] as! NSArray;
				for (var j = 0;j < currentArray.count;j++) {
					newArray.addObject(currentArray[j]) ;
				}
			} else if (args[i] is [AnyObject]) {
				newArray.addObjectsFromArray(args[i] as! [AnyObject])
			} else {
				newArray.addObject(args[i]) ;
			}
		}
		return newArray;
	}
	
	/**
	 使用 strict equality (===) 运算符搜索数组中的项，并返回项的索引位置。<p>
	 Searches for an item in an array by using strict equality (===)
	 and returns the index position of the item.

	 - parameter searchElement: 要在数组中查找的项<p>
	 The item to find in the array.

	 - parameter fromIndex:     数组中的位置，从该位置开始搜索项。<p>
	 The location in the array from which to start searching for the item.

	 - returns: 数组中的位置，从该位置开始搜索项。<p>
	 A zero-based index position of the item in the array.
	 If the searchElement argument is not found, the return value is -1.
	 */
	public func indexOf(searchElement: AnyObject, fromIndex: Int = 0) -> Int {
		var index: Int = -1
		if (fromIndex < length) {
			index = self.indexOfObject(searchElement, inRange: NSRange(location: fromIndex, length: length))
		}
		return index
	}
	
	/**
	 搜索数组中的项（从最后一项开始向前搜索），并使用 strict equality (===) 运算符返回匹配项的索引位置。<p>
	 Searches for an item in an array, working backward from the last item, and returns the index position of the matching item using strict equality (===).

	 - parameter searchElement: 要在数组中查找的项。<p>
	 The item to find in the array.

	 - parameter fromIndex:     数组中的位置，从该位置开始搜索项。默认为允许的最大索引值。
	 如果不指定 fromIndex，将从数组中的最后一项开始进行搜索。<p>
	 The location in the array from which to start searching for the item.
	 The default is the maximum value allowed for an index.
	 If you do not specify fromIndex, the search starts at the last item in the array.

	 - returns: 数组项的索引位置（从 0 开始）。如果未找到 searchElement 参数，则返回值为 -1。<p>
	 A zero-based index position of the item in the array.
	 If the searchElement argument is not found, the return value is -1.
	 */
	public func lastIndexOf(searchElement: AnyObject, fromIndex: Int = 0x7fffffff) -> Int {
		let _fromIndex = min(fromIndex, length - 1)
		var index = -1
		for (var i = _fromIndex;i >= 0;i--) {
			if (self[i] === searchElement) {
				index = i
				break
			}
		}
		return index;
	}
	
	/**
	 在当前位置倒转数组。<p>
	 Reverses the array in place.

	 - returns: 新数组。<p>
	 The new array.
	 */
	public func reverse() -> NSMutableArray {
		let newArray = NSMutableArray()
		for (var i = length - 1;i >= 0;i--) {
			newArray.addObject(self[i])
		}
		return newArray
	}
	
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