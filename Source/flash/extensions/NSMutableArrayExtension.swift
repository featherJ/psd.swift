//
// NSArrayExtension.swift
// InstanceTest
//
// Created by featherJ on 16/1/26.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
public extension NSMutableArray {
	
	/**
	 将一个或多个元素添加到数组的结尾，并返回该数组的新长度。<p>
	 Adds one or more elements to the end of an array and returns the new length of the ar

	 - parameter args: 要追加到数组中的一个或多个值。<p>
	 One or more values to append to the array.

	 - returns: 一个表示新数组长度的整数。<p>
	 An integer representing the length of the new array.
	 */
	public func push(args: AnyObject...) -> Int {
		self.addObjectsFromArray(args)
		return length
	}
	
	/**
	 将一个或多个元素添加到数组的开头，并返回该数组的新长度。数组中的其他元素从其原始位置 i 移到 i+1。<p>
	 Adds one or more elements to the beginning of an array and returns the new length of the array.
	 The other elements in the array are moved from their original position, i, to i+1.

	 - parameter args: 一个或多个要插入到数组开头的数字、元素或变量。<p>
	 One or more numbers, elements, or variables to be inserted at the beginning of the array.

	 - returns: 一个整数，表示该数组的新长度。<p>
	 An integer representing the new length of the array.
	 */
	public func unshift(args: AnyObject...) -> Int {
		for (var i = args.count - 1;i >= 0;i--) {
			self.insertObject(args[i], atIndex: 0)
		}
		return length;
	}
	/**
	 删除数组中最后一个元素，并返回该元素的值。<p>
	 Removes the last element from an array and returns the value of that element.

	 - returns: 指定的数组中最后一个元素（可以为任意数据类型）的值。<p>
	 The value of the last element (of any data type) in the specified array.
	 */
	public func pop() -> AnyObject? {
		let lastObject = self.lastObject
		if (lastObject != nil) {
			self.removeObjectAtIndex(length - 1)
		}
		return lastObject
	}
	
	/**
	 删除数组中第一个元素，并返回该元素。其余数组元素将从其原始位置 i 移至 i-1。<p>
	 Removes the first element from an array and returns that element.
	 The remaining array elements are moved from their original position, i, to i-1.

	 - returns: 数组中的第一个元素（可以是任意数据类型）。<p>
	 The first element (of any data type) in an array.
	 */
	public func shift() -> AnyObject? {
		let firstObject = self.firstObject
		if (firstObject != nil) {
			self.removeObjectAtIndex(0)
		}
		return firstObject
	}
	
	/**
	 指定数组中元素数量的非负整数。在向数组中添加新元素时，此属性会自动更新。
	 当您给数组元素赋值（例如，my_array[index] = value）时，如果 index 是数字，
	 而且 index+1 大于 length 属性，则 length 属性会更新为 index+1。<p>
	 <b>注意：</b>如果您为 length 属性所赋的值小于现有长度，会将数组截断。<br><br>
	 A non-negative integer specifying the number of elements in the array.
	 This property is automatically updated when new elements are added to the array.
	 When you assign a value to an array element (for example, my_array[index] = value),
	 if index is a number, and index+1 is greater than the length property, the length property is updated to index+1.<p>
	 <b>Note:</b> If you assign a value to the length property that is shorter than the existing length,
	 the array will be truncated.
	 */
	override public var length: Int {
		get {
			return super.length;
		}
		set {
			var value = newValue;
			if (value < 0) {
				value = 0;
			}
			if (value < self.count) {
				self.removeObjectsInRange(NSRange(location: value, length: self.count - value)) ;
			} else if (value > self.count) {
				for (var i = 0;i < value - self.count;i++) {
					self.addObject(NSNull) ;
				}
			}
		}
	}
}