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