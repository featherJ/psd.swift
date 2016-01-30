//
// StringExtensions.swift
// psd.swift
//
// Created by featherJ on 16/1/5.
// Copyright © 2016年 fancynode. All rights reserved.
//
import Foundation;
public extension String {
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
	
	
	/**
	 返回由参数 index 指定的位置处的字符。如果 index 不是从 0 到 string.length - 1 之间的数字，则返回一个空字符串。<p>
	 此方法与 String.charCodeAt() 类似，所不同的是它返回的值是一个字符，而不是 16 位整数字符代码。<br><br>
	 Returns the character in the position specified by the index parameter. If index is not a number from 0 to string.length - 1, an empty string is returned.<p>
	 This method is similar to String.charCodeAt() except that the returned value is a character, not a 16-bit integer character code.

	 - parameter index: 一个整数，指定字符在字符串中的位置。第一个字符由 0 表示，最后一个字符由 my_str.length - 1 表示。<br><br>
	 An integer specifying the position of a character in the string. The first character is indicated by 0, and the last character is indicated by my_str.length - 1.

	 - returns: 指定索引处的字符。或者，如果指定的索引不在该字符串的索引范围内，则为一个空字符串。<br><br>
	 The character at the specified index. Or an empty string if the specified index is outside the range of this string's indices.
	 */
	public func charAt(index: Int = 0) -> String {
		if (index < self.length && index >= 0) {
			return String(self[self.startIndex.advancedBy(index)]) ;
		}
		return "";
	}
	
	/**
	 返回指定 index 处的字符的数值 Unicode 字符代码。如果 index 不是从 0 到 string.length - 1 之间的数字，则返回 nil。<p>
	 此方法与 String.charAt() 类似，所不同的是它返回的值是 16 位整型字符代码，而不是实际的字符。<br><br>
	 Returns the numeric Unicode character code of the character at the specified index. If index is not a number from 0 to string.length - 1, nil is returned.<p>
	 This method is similar to String.charAt() except that the returned value is a 16-bit integer character code, not the actual character.

	 - parameter index: 一个整数，指定字符在字符串中的位置。第一个字符由 0 表示，最后一个字符由 my_str.length - 1 表示。<br><br>
	 An integer that specifies the position of a character in the string. The first character is indicated by 0, and the last character is indicated by my_str.length - 1.

	 - returns: 指定索引处的字符的 Unicode 字符代码。或者，如果索引不在此字符串的索引范围内，则为 nil。<br><br>
	 The Unicode character code of the character at the specified index. Or nil if the index is outside the range of this string's indices.
	 */
	public func charCodeAt(index: Int = 0) -> Int? {
		if (index < self.length && index >= 0) {
			let scalars = self.unicodeScalars;
			return Int(scalars[scalars.startIndex.advancedBy(index)].value) ;
		}
		return nil;
	}
	
	/**
	 在 String 对象末尾追加补充参数（如果需要，将它们转换为字符串）并返回结果字符串。
	 源 String 对象的原始值保持不变。<p>
	 Appends the supplied arguments to the end of the String object,
	 converting them to strings if necessary, and returns the resulting string.
	 The original value of the source String object remains unchanged.

	 - parameter args: 0 个或多个要连接的值。<p>
	 Zero or more values to be concatenated.

	 - returns: 由该字符串与指定的参数连接而成的新字符串。<p>
	 A new string consisting of this string concatenated with the specified parameters.
	 */
	public func concat(args: AnyObject...) -> String {
		var str: String = ""
		for (var i = 0;i < args.count;i++) {
			str += String(args[i])
		}
		return str
	}
	
	/**
	 返回一个子字符串，该子字符串中的字符是通过从指定的 startIndex 开始，按照 len 指定的长度截取所得的。原始字符串保持不变。<p>
	 Returns a substring consisting of the characters that start at the specified startIndex and with a length specified by len. The original string is unmodified.

	 - parameter startIndex: 一个整数，指定用于创建子字符串的第一个字符的索引。如果 startIndex 是一个负数，则起始索引从字符串的结尾开始确定，其中 -1 表示最后一个字符。<p>
	 An integer that specified the index of the first character to be used to create the substring. If startIndex is a negative number, the starting index is determined from the end of the string, where -1 is the last character.
	 - parameter len:        要创建的子字符串中的字符数。默认值为所允许的最大值。如果未指定 len，则子字符串包括从 startIndex 到字符串结尾的所有字符。<p>
	 The number of characters in the substring being created. The default value is the maximum value allowed. If len is not specified, the substring includes all the characters from startIndex to the end of the string.

	 - returns: 基于指定参数的子字符串。<br>
	 A substring based on the specified parameters.
	 */
	public func substr(startIndex: Int = 0, _ len: Int = Int.max) -> String {
		var start = startIndex;
		if (start < 0) {
			start = self.length + start;
		}
		var end = self.length;
		if (len > 0) {
			end = start + len > self.length ? self.length : start + len;
		} else {
			if (len + start >= 0 || len == 0) {
				end = start;
			} else if (self.length + len >= 0) {
				end = start + self.length + len;
			} else {
				end = start;
			}
		}
		let startElement = self.startIndex.advancedBy(start) ;
		let endElement = self.startIndex.advancedBy(end) ;
		return self.substringWithRange(Range<String.Index>(start: startElement, end: endElement)) ;
	}
	
	/**
	 返回一个字符串，其中包含由 startIndex 指定的字符和一直到 endIndex - 1 的所有字符。如果未指定 endIndex，则使用 String.length。如果 startIndex 的值等于 endIndex 的值，则该方法返回一个空字符串。如果 startIndex 的值大于 endIndex 的值，则在执行函数之前会自动交换参数。原始字符串保持不变。<p>
	 Returns a string consisting of the character specified by startIndex and all characters up to endIndex - 1. If endIndex is not specified, String.length is used. If the value of startIndex equals the value of endIndex, the method returns an empty string. If the value of startIndex is greater than the value of endIndex, the parameters are automatically swapped before the function executes. The original string is unmodified.

	 - parameter startIndex:  一个整数，指定用于创建子字符串的第一个字符的索引。startIndex 的有效值范围为从 0 到 String.length。如果 startIndex 是一个负值，则使用 0 。<p>
	 An integer specifying the index of the first character used to create the substring. Valid values for startIndex are 0 through String.length. If startIndex is a negative value, 0 is used.
	 - parameter endIndex:   一个整数，它比所提取的子字符串中的最后一个字符的索引大 1。endIndex 的有效值范围为从 0 到 String.length。endIndex 处的字符不包括在子字符串中。默认为允许的最大索引值。如果省略此参数，则使用 String.length。如果此参数是一个负值，则使用 0。<p>
	 An integer that is one greater than the index of the last character in the extracted substring. Valid values for endIndex are 0 through String.length. The character at endIndex is not included in the substring. The default is the maximum value allowed for an index. If this parameter is omitted, String.length is used. If this parameter is a negative value, 0 is used.

	 - returns: 基于指定参数的子字符串。<br>
	 A substring based on the specified parameters.
	 */
	public func substring(startIndex: Int = 0, _ endIndex: Int = Int.max) -> String {
		var start = min(startIndex, endIndex) ;
		start = max(0, start) ;
		start = min(self.length, start) ;
		var end = max(startIndex, endIndex) ;
		end = max(0, end) ;
		end = min(self.length, end) ;
		let startElement = self.startIndex.advancedBy(start) ;
		let endElement = self.startIndex.advancedBy(end) ;
		return self.substringWithRange(Range<String.Index>(start: startElement, end: endElement)) ;
	}
	
	/**
	 搜索字符串，并返回在调用字符串内 startIndex 位置上或之后找到的 val 的第一个匹配项的位置。此索引从 0 开始，这意味着字符串的第一个字符位于索引 0，而不是索引 1。如果未找到 val，则该方法返回 -1。<p>
	 Searches the string and returns the position of the first occurrence of val found at or after startIndex within the calling string. This index is zero-based, meaning that the first character in a string is considered to be at index 0--not index 1. If val is not found, the method returns -1.

	 - parameter val:        要搜索的子字符串。<br>
	 The substring for which to search.
	 - parameter startIndex: 一个可选整数，指定搜索的起始索引。<br>
	 An optional integer specifying the starting index of the search.

	 - returns: 指定子字符串的第一个匹配项的索引，或 -1。<br>
	 The index of the first occurrence of the specified substring or -1.
	 */
	public func indexOf(val: String, _ startIndex: Int = 0) -> Int {
		let range = self.rangeOfString(val,
			options: NSStringCompareOptions(rawValue: 0), range: Range(start: self.startIndex.advancedBy(startIndex), end: self.endIndex)
		)
		if let range = range {
			return self.startIndex.distanceTo(range.startIndex)
		} else {
			return -1
		}
	}
	
	/**
	 从右向左搜索字符串，并返回在 startIndex 之前找到的最后一个 val 匹配项的索引。
	 此索引从零开始，这意味着第一个字符位于索引 0 处，最后一个字符位于 string.length - 1 处。
	 如果未找到 val，则该方法返回 -1。<p>
	 Searches the string from right to left and returns the index of the last
	 occurrence of val found before startIndex. The index is zero-based,
	 meaning that the first character is at index 0, and the last is at string.length - 1.
	 If val is not found, the method returns -1.

	 - parameter val:        要搜索的字符串。<p>
	 The string for which to search.

	 - parameter startIndex: 一个可选整数，指定开始搜索 val 的起始索引。
	 默认为允许的最大索引值。如果未指定 startIndex，则从字符串中的最后一项开始搜索。<p>
	 An optional integer specifying the starting index from which to search for val.
	 The default is the maximum value allowed for an index.
	 If startIndex is not specified, the search starts at the last item in the string.

	 - returns: 指定子字符串的最后一个匹配项的位置，或 -1（如果未找到）。<p>
	 The position of the last occurrence of the specified substring or -1 if not found.
	 */
	public func lastIndexOf(val: String, _ startIndex: Int = Int.max) -> Int {
		let range = self.rangeOfString(val,
			options: .BackwardsSearch,
			range: Range(start: self.startIndex, end: self.startIndex.advancedBy(startIndex))
		)
		if let range = range {
			return self.startIndex.distanceTo(range.startIndex)
		} else {
			return -1
		}
	}
	
	/**
	 返回一个字符串，该字符串包括从 startIndex 字符一直到 endIndex 字符（但不包括该字符）之间的所有字符。
	 不修改原始 String 对象。如果未指定 endIndex 参数，此子字符串的结尾就是该字符串的结尾。
	 如果按 startIndex 索引到的字符与按 endIndex 索引到的字符相同或位于后者的右侧，则该方法返回一个空字符串。<p>
	 Returns a string that includes the startIndex character and all characters up to,
	 but not including, the endIndex character. The original String object is not modified.
	 If the endIndex parameter is not specified,
	 then the end of the substring is the end of the string.
	 If the character indexed by startIndex is the same as or to the right of
	 the character indexed by endIndex, the method returns an empty string.

	 - parameter startIndex: 片段起始点的从 0 开始的索引。如果 startIndex 是一个负数，则从右到左创建片段，
	 其中 -1 是最后一个字符。<p>
	 The zero-based index of the starting point for the slice.
	 If startIndex is a negative number, the slice is created from right-to-left,
	 where -1 is the last character.

	 - parameter endIndex:   一个比片段终点的索引大 1 的整数。由 endIndex 参数索引的字符未包括在已提取的字符串中。
	 如果 endIndex 是一个负数，则终点根据从字符串的结尾向后数确定，其中 -1 表示最后一个字符。
	 默认为允许的最大索引值。如果省略此参数，则使用 String.length。<p>
	 An integer that is one greater than the index of the ending point for the slice.
	 The character indexed by the endIndex parameter is not included in the extracted string.
	 If endIndex is a negative number,
	 the ending point is determined by counting back from the end of the string,
	 where -1 is the last character. The default is the maximum value allowed for an index.
	 If this parameter is omitted, String.length is used.

	 - returns: 基于指定索引的子字符串。<p>
	 A substring based on the specified indices.
	 */
	public func slice(startIndex: Int = 0, endIndex: Int = Int.max) -> String {
		var start = startIndex;
		var end = endIndex;
		if (start < 0) {start = length + start}
		if (end < 0) {end = length + end}
		if (start > length) {start = length}
		if (end > length) {end = length}
		return substring(start, end) ;
	}
	/**
	 一个整数，它指定在所指定的 String 对象中的字符数。<p>
	 因为所有字符串索引都是从零开始的，所以任何字符串 x 的最后一个字符的索引都是 x.length - 1。<br><br>
	 An integer specifying the number of characters in the specified String object.<p>
	 Because all string indexes are zero-based, the index of the last character for any string x is x.length - 1.
	 */
	public var length: Int {
		get {
			return self.characters.count;
		}
	}
}