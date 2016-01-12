//
// PsdUtil.swift
// psd.swift
//
// Created by featherJ on 16/1/11.
// Copyright © 2016年 fancynode. All rights reserved.
//

/**
 PSD解析常用工具类。<br>
 Common Bytes util for psd parsing.
 - author: featherJ
 */
class PsdUtil {
	@warn_unused_result
	static func pad2<T: IntegerType>(i: T) -> T {
		return (i + 1) & ~0x01;
	}
	@warn_unused_result
	static func pad4<T: IntegerType>(i: T) -> T {
		return ((i + 4) & ~0x03) - 1;
	}
	@warn_unused_result
	static func clamp<T : Comparable>(num: T, _ min: T, _ max: T) -> T {
		return Swift.min(Swift.max(num, min), max) ;
	}
}