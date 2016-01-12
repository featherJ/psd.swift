//
// ColorModeConsts.swift
// psd.swift
//
// Created by featherJ on 16/1/7.
// Copyright © 2016年 fancynode. All rights reserved.
//

/**
 文件头中定义的颜色模式。<br><br>
 The color mode defined in the PSD file header.
 - author: featherJ
 */
public class ColorModeConsts {
	public static let BITMAP: Int = 0;
	public static let GRAY_SCALE: Int = 1;
	public static let INDEXED: Int = 2;
	public static let RGB: Int = 3;
	public static let CMYK: Int = 4;
	public static let HSL: Int = 5;
	public static let HSB: Int = 6;
	public static let MULTICHANNEL: Int = 7;
	public static let DUOTONE: Int = 8;
	public static let LAB: Int = 9;
	public static let GRAY_16: Int = 10;
	public static let RGB_48: Int = 11;
	public static let LAB_48: Int = 12;
	public static let CMYK_64: Int = 13;
	public static let DEEP_MULTICHANNEL: Int = 14;
	public static let DUOTONE_16: Int = 15;
	
	/**
	 所有的颜色模式的定义存储，这个表是为了让输出更加易读用的。<br><br>All of the color modes are stored internally as a short from 0-15. This is a mapping of that value to a human-readable name.
	 */
	public static let MODES: [String] = [
		"Bitmap",
		"Grayscale",
		"Indexed",
		"RGB",
		"CMYK",
		"HSL",
		"HSB",
		"Multichannel",
		"Duotone",
		"Lab",
		"Gray16",
		"RGB48",
		"Lab48",
		"CMYK64",
		"DeepMultichannel",
		"Duotone16"
	] ;
}