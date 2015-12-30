//
// ByteArray.swift
// ByteArray
//
// Created by featherJ on 15/12/28.
// Copyright © 2015年 Test. All rights reserved.
//

import Foundation
import Compression
import zlib
/**
 ByteArray 类提供用于优化读取、写入以及处理二进制数据的方法和属性。<br><br>
 The ByteArray class provides methods and properties to optimize reading, writing, and working with binary data.
 - author: featherJ
 */
class ByteArray {
	var data: NSMutableData;
	/**s
	 更改或读取数据的字节顺序；Endian.BIG_ENDIAN 或 Endian.LITTLE_ENDIAN。默认值为 BIG_ENDIAN。<br><br>
	 Changes or reads the byte order for the data; either Endian.BIG_ENDIAN or Endian.LITTLE_ENDIAN. The default value is BIG_ENDIAN.
	 */
	var endian: String;
	/**
	 将文件指针的当前位置（以字节为单位）移动或返回到 ByteArray 对象中。下一次调用读取方法时将在此位置开始读取，或者下一次调用写入方法时将在此位置开始写入。<br><br>
	 Moves, or returns the current position, in bytes, of the file pointer into the ByteArray object. This is the point at which the next call to a read method starts reading or a write method starts writing.
	 */
	var position: Int;
	/**
	 [只读]可从字节数组的当前位置到数组末尾读取的数据的字节数。每次访问 ByteArray 对象时，将 bytesAvailable 属性与读取方法结合使用，以确保读取有效的数据。<br><br>
	 [read-only] The number of bytes of data available for reading from the current position in the byte array to the end of the array. Use the bytesAvailable property in conjunction with the read methods each time you access a ByteArray object to ensure that you are reading valid data.*/
	var bytesAvailable: Int {
		get {
			return self.length - self.position;
		}
	}
	/**
	 ByteArray 对象的长度（以字节为单位）。<p>
	 如果将长度设置为大于当前长度的值，则用零填充字节数组的右侧。<p>
	 如果将长度设置为小于当前长度的值，将会截断该字节数组。<br><br>
	 The length of the ByteArray object, in bytes.<p>
	 If the length is set to a value that is larger than the current length, the right side of the byte array is filled with zeros.<p>
	 If the length is set to a value that is smaller than the current length, the byte array is truncated.
	 */
	var length: Int {
		get {
			return self.data.length;
		}
		set {
			self.data.length = newValue;
			if (position > newValue) {
				position = newValue;
			}
		}
	}
	
	private var range: NSRange
	init() {
		data = NSMutableData() ;
		endian = Endian.BIG_ENDIAN;
		range = NSRange(location: 0, length: 0)
		position = 0;
	}
	convenience init(_ data: NSData) {
		self.init() ;
		self.data.appendData(data) ;
	}
	convenience init(_ data: [UInt8]) {
		self.init() ;
		self.data.appendBytes(data, length: data.count)
	}
	/**
	 从字节流中读取布尔值。读取单个字节，如果字节非零，则返回 true，否则返回 false。<br><br>
	 Reads a Boolean value from the byte stream. A single byte is read, and true is returned if the byte is nonzero, false otherwise.
	 - returns: 如果字节不为零，则返回 true，否则返回 false。<br><br>
	 Returns true if the byte is nonzero, false otherwise.
	 */
	func readBoolean() -> Bool {
		range.location = position
		range.length = 1
		var flag = false
		data.getBytes(&flag, range: range)
		position += range.length
		return flag;
	}
	/**
	 从字节流中读取带符号的字节。<p>
	 返回值的范围是从 -128 到 127。<br><br>
	 Reads a signed byte from the byte stream.<p>
	 The returned value is in the range -128 to 127.
	 - returns: 介于 -128 和 127 之间的 8 位带符号整数。<br><br>
	 An 8-bit signed integer between -128 and 127.
	 */
	func readByte() -> Int {
		range.location = position
		range.length = 1
		var value: Int8 = 0
		data.getBytes(&value, range: range)
		position += range.length
		return Int(value)
	}
	/**
	 从字节流中读取无符号的字节。<p>
	 返回值的范围是从 0 到 255。<br><br>
	 Reads an unsigned byte from the byte stream.<p>
	 The returned value is in the range 0 to 255.
	 - returns: 介于 0 和 255 之间的 8 位无符号整数。<br><br>
	 A 8-bit unsigned integer between 0 and 255.
	 */
	func readUnsignedByte() -> UInt {
		range.location = position
		range.length = 1
		var value: UInt8 = 0
		data.getBytes(&value, range: range)
		position += range.length
		return UInt(value)
	}
	/**
	 从字节流中读取一个带符号的 16 位整数。<p>
	 返回值的范围是从 -32768 到 32767。<br><br>
	 Reads a signed 16-bit integer from the byte stream.<p>
	 The returned value is in the range -32768 to 32767.
	 - returns: 介于 -32768 和 32767 之间的 16 位带符号整数。<br><br>
	 A 16-bit signed integer between -32768 and 32767.
	 */
	func readShort() -> Int {
		range.location = position
		range.length = 2
		var value: Int16 = 0
		data.getBytes(&value, range: range)
		position += range.length
		return endian == Endian.BIG_ENDIAN ? Int(value.bigEndian) : Int(value)
	}
	/**
	 从字节流中读取一个无符号的 16 位整数。<p>
	 返回值的范围是从 0 到 65535。<br><br>
	 Reads an unsigned 16-bit integer from the byte stream.<p>
	 The returned value is in the range 0 to 65535.
	 - returns: 介于 0 和 65535 之间的 16 位无符号整数。<br><br>
	 A 16-bit unsigned integer between 0 and 65535.
	 */
	func readUnsignedShort() -> UInt {
		range.location = position
		range.length = 2
		var value: UInt16 = 0
		data.getBytes(&value, range: range)
		position += range.length
		return endian == Endian.BIG_ENDIAN ? UInt(value.bigEndian) : UInt(value)
	}
	/**
	 从字节流中读取一个带符号的 32 位整数。<p>
	 返回值的范围是从 -2147483648 到 2147483647。<br><br>
	 Reads a signed 32-bit integer from the byte stream.<p>
	 The returned value is in the range -2147483648 to 2147483647.
	 - returns: 介于 -2147483648 和 2147483647 之间的 32 位带符号整数。<br><br>
	 A 32-bit signed integer between -2147483648 and 2147483647.
	 */
	func readInt() -> Int {
		range.location = position
		range.length = 4
		var value: Int32 = 0
		data.getBytes(&value, range: range)
		position += range.length
		return endian == Endian.BIG_ENDIAN ? Int(value.bigEndian) : Int(value)
	}
	/**
	 从字节流中读取一个无符号的 32 位整数。<p>
	 返回值的范围是从 0 到 4294967295。<br><br>
	 Reads an unsigned 32-bit integer from the byte stream.<p>
	 The returned value is in the range 0 to 4294967295.
	 - returns: 介于 0 和 4294967295 之间的 32 位无符号整数。<br><br>
	 A 32-bit unsigned integer between 0 and 4294967295.
	 */
	func readUnsignedInt() -> UInt {
		range.location = position
		range.length = 4
		var value: UInt32 = 0
		data.getBytes(&value, range: range)
		position += range.length
		return endian == Endian.BIG_ENDIAN ? UInt(value.bigEndian) : UInt(value)
	}
	/**
	 从字节流中读取一个带符号的 64 位整数。<p>
	 返回值的范围是从 -2^63 到 2^63-1。<br><br>
	 Reads a signed 64-bit integer from the byte stream.<p>
	 The returned value is in the range -2^63 to 2^63-1.
	 - returns: 介于 -2^63 和 2^63-1 之间的 64 位带符号整数。<br><br>
	 A 64-bit signed integer between -2^63 and 2^63-1.
	 */
	func readInt64() -> Int64 {
		range.location = position
		range.length = 8
		var value: Int64 = 0
		data.getBytes(&value, range: range)
		position += range.length
		return endian == Endian.BIG_ENDIAN ? value.bigEndian : value
	}
	/**
	 从字节流中读取一个无符号的 64 位整数。<p>
	 返回值的范围是从 0 到 2^64。<br><br>
	 Reads an unsigned 64-bit integer from the byte stream.<p>
	 The returned value is in the range 0 to 2^64.
	 - returns: 介于 0 和 2^64 之间的 64 位无符号整数。<br><br>
	 A 64-bit unsigned integer between 0 and 2^64.
	 */
	func readUnsignedInt64() -> UInt64 {
		range.location = position
		range.length = 8
		var value: UInt64 = 0
		self.data.getBytes(&value, range: range)
		position += range.length
		return endian == Endian.BIG_ENDIAN ? value.bigEndian : value
		
	}
	
	
	/**
	 写入布尔值。根据 value 参数写入单个字节。如果为 true，则写入 1，如果为 false，则写入 0。<br><br>
	 Writes a Boolean value. A single byte is written according to the value parameter, either 1 if true or 0 if false.
	 - parameter value: 确定写入哪个字节的布尔值。如果该参数为 true，则该方法写入 1；如果该参数为 false，则该方法写入 0。<br><br>
	 A Boolean value determining which byte is written. If the parameter is true, the method writes a 1; if false, the method writes a 0.
	 */
	func writeBoolean(var value: Bool) {
		range.location = position
		range.length = 1
		self.data.replaceBytesInRange(range, withBytes: &value)
		position += range.length
		
	}
	/**
	 在字节流中写入一个字节。<p>
	 使用参数的低 8 位。忽略高 24 位。<br><br>
	 Writes a byte to the byte stream.<p>
	 The low 8 bits of the parameter are used. The high 24 bits are ignored.
	 - parameter value: 一个 32 位整数。低 8 位将被写入字节流。<br><br>
	 A 32-bit integer. The low 8 bits are written to the byte stream.
	 */
	func writeByte(value: Int) {
		var realValue: UInt8 = UInt8(value&0xff) ;
		range.location = position
		range.length = 1
		self.data.replaceBytesInRange(range, withBytes: &realValue)
		position += range.length
	}
	/**
	 在字节流中写入一个 16 位整数。使用参数的低 16 位。忽略高 16 位。<br><br>
	 Writes a 16-bit integer to the byte stream. The low 16 bits of the parameter are used. The high 16 bits are ignored.
	 - parameter value: 32 位整数，该整数的低 16 位将被写入字节流。<br><br>
	 32-bit integer, whose low 16 bits are written to the byte stream.
	 */
	func writeShort(value: Int) {
		var realValue: UInt16 = UInt16(value&0xffff)
		if (endian == Endian.BIG_ENDIAN) {
			realValue = realValue.bigEndian
		}
		range.location = position
		range.length = 2
		self.data.replaceBytesInRange(range, withBytes: &realValue)
		position += range.length
	}
	/**
	 在字节流中写入一个带符号的 32 位整数。<br><br>
	 Writes a 32-bit signed integer to the byte stream.
	 - parameter value: 要写入字节流的整数。<br><br>
	 An integer to write to the byte stream.
	 */
	func writeInt(var value: Int) {
		if (endian == Endian.BIG_ENDIAN) {
			value = value.bigEndian
		}
		range.location = position
		range.length = 4
		self.data.replaceBytesInRange(range, withBytes: &value)
		position += range.length
	}
	/**
	 在字节流中写入一个无符号的 32 位整数。<br><br>
	 Writes a 32-bit unsigned integer to the byte stream.
	 - parameter value: 要写入字节流的无符号整数。<br><br>
	 An unsigned integer to write to the byte stream.
	 */
	func writeUnsignedInt(var value: UInt) {
		if (endian == Endian.BIG_ENDIAN) {
			value = value.bigEndian
		}
		range.location = position
		range.length = 4
		self.data.replaceBytesInRange(range, withBytes: &value)
		position += range.length
	}
	/**
	 在字节流中写入一个带符号的 64 位整数。<br><br>
	 Writes a 64-bit signed integer to the byte stream.
	 - parameter value: 要写入字节流的整数。<br><br>
	 An integer to write to the byte stream.
	 */
	func writeInt64(var value: Int64) {
		if (endian == Endian.BIG_ENDIAN) {
			value = value.bigEndian
		}
		range.location = position
		range.length = 8
		self.data.replaceBytesInRange(range, withBytes: &value)
		position += range.length
	}
	/**
	 在字节流中写入一个无符号的 64 位整数。<br><br>
	 Writes a 64-bit unsigned integer to the byte stream.
	 - parameter value: 要写入字节流的无符号整数。<br><br>
	 An unsigned integer to write to the byte stream.
	 */
	func writeUnsignedInt64(var value: UInt64) {
		if (endian == Endian.BIG_ENDIAN) {
			value = value.bigEndian
		}
		range.location = position
		range.length = 8
		self.data.replaceBytesInRange(range, withBytes: &value)
		position += range.length
	}
	
	
	/**
	 从字节流中读取一个 IEEE 754 双精度（64 位）浮点数。<br><br>
	 Reads an IEEE 754 double-precision (64-bit) floating-point number from the byte stream.
	 - returns: 双精度（64 位）浮点数。<br><br>
	 A double-precision (64-bit) floating-point number.
	 */
	func readDouble() -> Double {
		range.location = position
		range.length = 8
		var value: Double = 0.0
		if (endian == Endian.BIG_ENDIAN) {
			var bytes = [UInt8](count: range.length, repeatedValue: 0)
			self.data.getBytes(&bytes, range: range)
			bytes = Array(bytes.reverse())
			value = UnsafePointer<Double>(bytes).memory
		} else {
			self.data.getBytes(&value, range: range)
		}
		position += range.length
		return value
	}
	/**
	 从字节流中读取一个 IEEE 754 单精度（32 位）浮点数。<br><br>
	 Reads an IEEE 754 single-precision (32-bit) floating-point number from the byte stream.
	 - returns: 单精度（32 位）浮点数。<br><br>
	 A single-precision (32-bit) floating-point number.
	 */
	func readFloat() -> Float32 {
		range.location = position
		range.length = 4
		var value: Float32 = 0.0
		if (endian == Endian.BIG_ENDIAN) {
			var bytes = [UInt8](count: range.length, repeatedValue: 0)
			self.data.getBytes(&bytes, range: range)
			bytes = Array(bytes.reverse())
			value = UnsafePointer<Float32>(bytes).memory
		} else {
			self.data.getBytes(&value, range: range)
		}
		position += range.length
		return value
	}
	/**
	 在字节流中写入一个 IEEE 754 双精度（64 位）浮点数。<br><br>
	 Writes an IEEE 754 double-precision (64-bit) floating-point number to the byte stream.
	 - parameter value: 双精度（64 位）浮点数。<br><br>
	 A double-precision (64-bit) floating-point number.
	 */
	func writeDouble(var value: Double) {
		range.location = position
		range.length = 8
		if (endian == Endian.BIG_ENDIAN) {
			var bytes = withUnsafePointer(&value) {(v) -> [UInt8] in
				let p = UnsafeBufferPointer(start: UnsafePointer<UInt8>(v), count: 8)
				return [UInt8](p)
			}
			bytes = Array(bytes.reverse())
			self.data.replaceBytesInRange(range, withBytes: &bytes)
		} else {
			self.data.replaceBytesInRange(range, withBytes: &value)
		}
		position += range.length
	}
	/**
	 在字节流中写入一个 IEEE 754 单精度（32 位）浮点数。<br><br>
	 Writes an IEEE 754 single-precision (32-bit) floating-point number to the byte stream.
	 - parameter value: 单精度（32 位）浮点数。<br><br>
	 A single-precision (32-bit) floating-point number.
	 */
	func writeFloat(var value: Float32) {
		range.location = position
		range.length = 4
		if (endian == Endian.BIG_ENDIAN) {
			var bytes = withUnsafePointer(&value) {(v) -> [UInt8] in
				let p = UnsafeBufferPointer(start: UnsafePointer<UInt8>(v), count: 4)
				return [UInt8](p)
			}
			bytes = Array(bytes.reverse())
			self.data.replaceBytesInRange(range, withBytes: &bytes)
		} else {
			self.data.replaceBytesInRange(range, withBytes: &value)
		}
		position += range.length
	}
	
	
	/**
	 从字节流中读取 length 参数指定的数据字节数。从 offset 指定的位置开始，将字节读入 bytes 参数指定的 ByteArray 对象中，并将字节写入目标 ByteArray 中。<br><br>
	 Reads the number of data bytes, specified by the length parameter, from the byte stream. The bytes are read into the ByteArray object specified by the bytes parameter, and the bytes are written into the destination ByteArray starting at the position specified by offset.
	 - parameter bytes:  要将数据读入的 ByteArray 对象。<br><br>
	 The ByteArray object to read data into.
	 - parameter offset: bytes 中的偏移（位置），应从该位置写入读取的数据。<br><br>
	 The offset (position) in bytes at which the read data should be written.
	 - parameter length: 要读取的字节数。默认值 0 导致读取所有可用的数据。<br><br>
	 The number of bytes to read. The default value of 0 causes all available data to be read.
	 */
	func readBytes(bytes: ByteArray, _ offset: Int = 0, var _ length: Int = 0) {
		length = (length == 0) ? bytesAvailable : min(length, bytesAvailable)
		if (length <= 0) {
			return
		}
		range.location = position
		range.length = length
		var list = [UInt8](count: range.length, repeatedValue: 0)
		self.data.getBytes(&list, range: range)
		position += range.length
		let data = bytes.self.data
		if (offset > bytes.length) {
			var zeros = [UInt8](count: offset - bytes.length, repeatedValue: 0)
			data.replaceBytesInRange(NSRange(location: bytes.length, length: zeros.count), withBytes: &zeros)
		}
		data.replaceBytesInRange(NSRange(location: offset, length: length), withBytes: &list)
	}
	/**
	 将指定字节数组 bytes（起始偏移量为 offset，从零开始的索引）中包含 length 个字节的字节序列写入字节流。<p>
	 如果省略 length 参数，则使用默认长度 0；该方法将从 offset 开始写入整个缓冲区。如果还省略了 offset 参数，则写入整个缓冲区。<p>
	 如果 offset 或 length 超出范围，它们将被锁定到 bytes 数组的开头和结尾。<br><br>
	 Writes a sequence of length bytes from the specified byte array, bytes, starting offset(zero-based index) bytes into the byte stream.<p>
	 If the length parameter is omitted, the default length of 0 is used; the method writes the entire buffer starting at offset. If the offset parameter is also omitted, the entire buffer is written.<p>
	 If offset or length is out of range, they are clamped to the beginning and end of the bytes array.
	 - parameter bytes:  ByteArray 对象。<br><br>
	 The ByteArray object.
	 - parameter offset: 从 0 开始的索引，表示在数组中开始写入的位置。<br><br>
	 A zero-based index indicating the position into the array to begin writing.
	 - parameter length: 一个无符号整数，表示在缓冲区中的写入范围。<br><br>
	 An unsigned integer indicating how far into the buffer to write.
	 */
	func writeBytes(bytes: ByteArray, _ offset: Int = 0, var _ length: Int = 0) {
		length = length == 0 ? bytesAvailable : min(length, bytesAvailable)
		if (length > 0) {
			let data = bytes.self.data.subdataWithRange(NSRange(location: offset, length: length))
			var bytes = [UInt8](count: data.length, repeatedValue: 0)
			data.getBytes(&bytes, length: bytes.count)
			range.location = position
			range.length = data.length
			self.data.replaceBytesInRange(range, withBytes: &bytes)
			position += range.length
		}
		
	}
	
	
	/**
	 使用指定的字符集从字节流中读取指定长度的多字节字符串。<br><br>
	 Reads a multibyte string of specified length from the byte stream using the specified character set.
	 - parameter length:  要从字节流中读取的字节数。<br><br>
	 The number of bytes from the byte stream to read.
	 - parameter charSet: 表示用于解释字节的字符集的字符串。<br><br>
	 The string denoting the character set to use to interpret the bytes.
	 - returns: UTF-8 编码的字符串。<br><br>
	 UTF-8 encoded string.
	 */
	func readMultiByte(length: Int, _ charSet: CFStringEncoding) -> String {
		range.location = position
		range.length = length
		let encoding = CFStringConvertEncodingToNSStringEncoding(charSet)
		let value = NSString(data: self.data.subdataWithRange(range), encoding: encoding) as! String
		position += range.length
		return value
	}
	/**
	 从字节流中读取一个 UTF-8 字符串。假定字符串的前缀是无符号的短整型（以字节表示长度）。<br><br>
	 Reads a UTF-8 string from the byte stream. The string is assumed to be prefixed with an unsigned short indicating the length in bytes.
	 - returns: UTF-8 编码的字符串。<br><br>
	 UTF-8 encoded string.
	 */
	func readUTF() -> String {
		return readUTFBytes(Int(readShort()))
	}
	/**
	 从字节流中读取一个由 length 参数指定的 UTF-8 字节序列，并返回一个字符串。<br><br>
	 Reads a sequence of UTF-8 bytes specified by the length parameter from the byte stream and returns a string.
	 - parameter length: 指明 UTF-8 字节长度的无符号短整型数。<br><br>
	 An unsigned short indicating the length of the UTF-8 bytes.
	 - returns: 由指定长度的 UTF-8 字节组成的字符串。<br><br>
	 A string composed of the UTF-8 bytes of the specified length.
	 */
	func readUTFBytes(length: Int) -> String {
		range.location = position
		range.length = length
		let value = NSString(data: self.data.subdataWithRange(range), encoding: NSUTF8StringEncoding) as! String
		position += range.length
		return value
	}
	/**
	 使用指定的字符集将多字节字符串写入字节流。<br><br>
	 Writes a multibyte string to the byte stream using the specified character set.
	 - parameter value:   要写入的字符串值。<br><br>
	 The string value to be written.
	 - parameter charSet: 表示要使用的字符集的字符串。<br><br>
	 The string denoting the character set to use.
	 */
	func writeMultiByte(value: String, _ charSet: CFStringEncoding) {
		let encoding = CFStringConvertEncodingToNSStringEncoding(charSet)
		let data = NSString(string: value).dataUsingEncoding(encoding)!
		var bytes = [UInt8](count: data.length, repeatedValue: 0)
		data.getBytes(&bytes, length: bytes.count)
		range.location = position
		range.length = data.length
		self.data.replaceBytesInRange(range, withBytes: &bytes)
		position += range.length
	}
	/**
	 将 UTF-8 字符串写入字节流。先写入以字节表示的 UTF-8 字符串长度（作为 16 位整数），然后写入表示字符串字符的字节。<br><br>
	 Writes a UTF-8 string to the byte stream. The length of the UTF-8 string in bytes is written first, as a 16-bit integer, followed by the bytes representing the characters of the string.
	 - parameter value: 要写入的字符串值。<br><br>
	 The string value to be written.
	 */
	func writeUTF(value: String) {
		var num = UInt16(value.utf8.count)
		if (endian == Endian.BIG_ENDIAN) {
			num = num.bigEndian
		}
		range.location = position
		range.length = 2
		self.data.replaceBytesInRange(range, withBytes: &num)
		position += range.length
		writeUTFBytes(value)
	}
	/**
	 将 UTF-8 字符串写入字节流。类似于 writeUTF() 方法，但 writeUTFBytes() 不使用 16 位长度的词为字符串添加前缀。<br><br>
	 Writes a UTF-8 string to the byte stream. Similar to the writeUTF() method, but writeUTFBytes() does not prefix the string with a 16-bit length word.
	 - parameter value: 要写入的字符串值。<br><br>
	 The string value to be written.
	 */
	func writeUTFBytes(value: String) {
		var bytes = [UInt8](value.utf8)
		range.location = position
		range.length = bytes.count
		self.data.replaceBytesInRange(range, withBytes: &bytes)
		position += range.length
	}
	
	
	
	func readObject() -> Any {
		return {}
	}
	func writeObject(object: Any) {
		
	}
	
	/**
	 压缩字节数组。将压缩整个字节数组。在调用后，ByteArray 的 length 属性将设置为新长度。position 属性将设置为字节数组末尾。<p>
	 通过传递一个值（在 CompressionAlgorithm 类中定义）作为 algorithm 参数，可指定压缩算法。<br><br>
	 Compresses the byte array. The entire byte array is compressed. After the call, the length property of the ByteArray is set to the new length. The position property is set to the end of the byte array.<p>
	 You specify a compression algorithm by passing a value (defined in the CompressionAlgorithm class) as the algorithm parameter.
	 - parameter algorithm: 压缩时所用的压缩算法。有效值定义为 CompressionAlgorithm 类中的常量。默认情况下使用 zlib 格式。调用 compress( CompressionAlgorithm.DEFLATE) 与调用 deflate() 方法效果相同。<br><br>
	 The compression algorithm to use when compressing. Valid values are defined as constants in the CompressionAlgorithm class. The default is to use zlib format. Calling compress(CompressionAlgorithm.DEFLATE) has the same effect as calling the deflate() method.
	 */
	func compress(algorithm: String = "zlib") {
		if (algorithm == CompressionAlgorithm.DEFLATE) {
			doDeflate(true)
		} else if (algorithm == CompressionAlgorithm.ZLIB) {
			dozlib(true)
		} else {
			dozlib(true)
		}
		position = length
	}
	/**
	 解压缩字节数组。在调用后，ByteArray 的 length 属性将设置为新长度。position 属性将设置为 0。<p>
	 字节数组必须已经使用与解压相同的算法进行压缩。通过传递一个值（在 CompressionAlgorithm 类中定义）作为 algorithm 参数，可指定解压算法。<br><br>
	 Decompresses the byte array. After the call, the length property of the ByteArray is set to the new length. The position property is set to 0.<p>
	 The byte array must have been compressed using the same algorithm as the uncompress. You specify an uncompression algorithm by passing a value (defined in the CompressionAlgorithm class) as the algorithm parameter.
	 - parameter algorithm: 解压缩时要使用的压缩算法。它必须是用于压缩该数据的相同的压缩算法。有效值定义为 CompressionAlgorithm 类中的常量。默认情况下使用 zlib 格式。<br><br>
	 The compression algorithm to use when decompressing. This must be the same compression algorithm used to compress the data. Valid values are defined as constants in the CompressionAlgorithm class. The default is to use zlib format.
	 */
	func uncompress(algorithm: String = "zlib") {
		if (algorithm == CompressionAlgorithm.DEFLATE) {
			doDeflate(false)
		} else if (algorithm == CompressionAlgorithm.ZLIB) {
			dozlib(false)
		} else {
			dozlib(false)
		}
		position = 0
	}
	/**
	 使用 deflate 压缩算法压缩字节数组。将压缩整个字节数组。<p>
	 在调用后，ByteArray 的 length 属性将设置为新长度。position 属性将设置为字节数组末尾。<br><br>
	 Compresses the byte array using the deflate compression algorithm. The entire byte array is compressed.<p>
	 After the call, the length property of the ByteArray is set to the new length. The position property is set to the end of the byte array.
	 */
	func deflate() {
		doDeflate(true)
		position = length
	}
	/**
	 使用 deflate 压缩算法将字节数组解压缩。字节数组必须已经使用相同的算法进行压缩。<p>
	 在调用后，ByteArray 的 length 属性将设置为新长度。position 属性将设置为 0。<br><br>
	 Decompresses the byte array using the deflate compression algorithm. The byte array must have been compressed using the same algorithm.<p>
	 After the call, the length property of the ByteArray is set to the new length. The position property is set to 0.
	 */
	func inflate() {
		doDeflate(false)
		position = 0
	}
	
	private func dozlib(encode: Bool)
	{
		guard (self.data.length > 0) else {return}
		var stream = z_stream(next_in: UnsafeMutablePointer<Bytef>(self.data.bytes), avail_in: uint(self.length), total_in: 0, next_out: nil, avail_out: 0, total_out: 0, msg: nil, state: nil, zalloc: nil, zfree: nil, opaque: nil, data_type: 0, adler: 0, reserved: 0
		)
		var status: Int32
		if (encode) {
			status = deflateInit2_(&stream, Z_BEST_COMPRESSION, Z_DEFLATED, MAX_WBITS, MAX_MEM_LEVEL, Z_DEFAULT_STRATEGY, ZLIB_VERSION, Int32(sizeof(z_stream)))
		} else {
			status = inflateInit2_(&stream, MAX_WBITS + 32, ZLIB_VERSION, Int32(sizeof(z_stream)))
		}
		guard (status == Z_OK) else {return}
		var data: NSMutableData;
		if (encode) {
			data = NSMutableData(length: 2 ^ 14)!
			while stream.avail_out == 0 {
				if (Int(stream.total_out) >= data.length) {
					data.length += 2 ^ 14
				}
				stream.next_out = UnsafeMutablePointer<Bytef>(data.mutableBytes).advancedBy(Int(stream.total_out))
				stream.avail_out = uInt(data.length) - uInt(stream.total_out)
				zlib.deflate(&stream, Z_FINISH)
			}
			deflateEnd(&stream)
		} else {
			data = NSMutableData(length: self.data.length * 2)!
			repeat {
				if Int(stream.total_out) >= data.length {
					data.length += self.length / 2;
				}
				stream.next_out = UnsafeMutablePointer<Bytef>(data.mutableBytes).advancedBy(Int(stream.total_out))
				stream.avail_out = uInt(data.length) - uInt(stream.total_out)
				status = zlib.inflate(&stream, Z_SYNC_FLUSH)
			} while status == Z_OK
			
			guard (inflateEnd(&stream) == Z_OK && status == Z_STREAM_END) else {return}
		}
		data.length = Int(stream.total_out)
		self.data = data;
	}
	
	private func doDeflate(encode: Bool)
	{
		guard (self.length > 0) else {return}
		let streamPtr = UnsafeMutablePointer<compression_stream>.alloc(1)
		var stream = streamPtr.memory
		var status : compression_status
		var op : compression_stream_operation
		var flags : Int32
		if (encode) {
			op = COMPRESSION_STREAM_ENCODE
			flags = Int32(COMPRESSION_STREAM_FINALIZE.rawValue)
		} else {
			op = COMPRESSION_STREAM_DECODE
			flags = 0
		}
		status = compression_stream_init(&stream, op, COMPRESSION_ZLIB)
		guard status != COMPRESSION_STATUS_ERROR else {return}
		stream.src_ptr = UnsafePointer<UInt8>(self.data.bytes)
		stream.src_size = length
		let dstBufferSize : size_t = 4096
		let dstBufferPtr = UnsafeMutablePointer<UInt8>.alloc(dstBufferSize)
		stream.dst_ptr = dstBufferPtr
		stream.dst_size = dstBufferSize
		let outputData = NSMutableData()
		repeat {
			status = compression_stream_process(&stream, flags)
			switch status.rawValue {
			case COMPRESSION_STATUS_OK.rawValue:
				if (stream.dst_size == 0) {
					outputData.appendBytes(dstBufferPtr, length: dstBufferSize)
					stream.dst_ptr = dstBufferPtr
					stream.dst_size = dstBufferSize
				}
			case COMPRESSION_STATUS_END.rawValue:
				if stream.dst_ptr > dstBufferPtr {
					outputData.appendBytes(dstBufferPtr, length: stream.dst_ptr - dstBufferPtr)
				}
			case COMPRESSION_STATUS_ERROR.rawValue:
				return
			default:
				break
			}
		} while status == COMPRESSION_STATUS_OK
		compression_stream_destroy(&stream)
		self.data = outputData;
	}
	
	
	
	subscript(index: Int) -> UInt8 {
		get {
			var value: UInt8 = 0
			self.data.getBytes(&value, range: NSRange(location: index, length: 1))
			return value
		}
		set(newValue) {
			var value: UInt8 = newValue;
			self.data.replaceBytesInRange(NSRange(location: index, length: 1), withBytes: &value)
		}
	}
	/**
	 清除字节数组的内容，并将 length 和 position 属性重置为 0。明确调用此方法将释放 ByteArray 实例占用的内存。<br><br>
	 Clears the contents of the byte array and resets the length and position properties to 0. Calling this method explicitly frees up the memory used by the ByteArray instance.
	 */
	func clear() {
		length = 0;
	}
	
	/**
	 将字节数组转换为字符串。如果数组中的数据以 Unicode 字节顺序标记开头，应用程序在将其转换为字符串时将保持该标记。如果 System.useCodePage 设置为 true，应用程序在转换时会将数组中的数据视为处于当前系统代码页中。<br><br>
	 Converts the byte array to a string. If the data in the array begins with a Unicode byte order mark, the application will honor that mark when converting to a string. If System.useCodePage is set to true, the application will treat the data in the array as being in the current system code page when converting.
	 - returns:  字节数组的字符串表示形式。<br><br>
	 The string representation of the byte array.
	 */
	func toString() -> String {
		return "";
	}
}