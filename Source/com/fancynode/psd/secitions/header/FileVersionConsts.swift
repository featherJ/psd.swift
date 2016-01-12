//
// ColorModeConsts.swift
// psd.swift
//
// Created by featherJ on 16/1/7.
// Copyright © 2016年 fancynode. All rights reserved.
//

/**
 文件版本类型，只有两个值，1为PSD或PDD，2为PSB。
 - author: featherJ
 */
public class FileVersionConsts {
	/**
	 版本1，Photoshop文档格式，文件类型为PSD或PDD
	 */
	public static let PSD_PDD: Int = 1;
	/**
	 版本2，大型文档格式，文件类型为PSB
	 */
	public static let PSB: Int = 2;
	/**
	 版本列表,这个列表是为了方便阅读用的。<br><br>
	 Version list, this is a mapping of that value to a human-readable name.
	 */
	public static var VERSIONS: [String] = [
		"",
		"psd/pdd",
		"psb"
	]
}