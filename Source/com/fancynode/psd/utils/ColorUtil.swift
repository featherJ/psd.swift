//
// ColorUtil.swift
// psd.swift
//
// Created by featherJ on 16/1/27.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
/**
 颜色转换工具<p>
 Color convert util.

 - author: featherJ
 */
public class ColorUtil
{
	/**
	 颜色空间列表<p>Color space map
	 */
	public static let COLOR_SPACE = [0: "rgb", 1: "hsb", 2: "cmyk", 7: "lab", 8: "grayscale"] ;
	/**
	 将灰色级(0-255)颜色转换为32位的16进制颜色值(argb)。<p>
	 Convert a greyscale tenit(0-255) to a hex32(argb)

	 - parameter teint: 灰度颜色值(0-255) <p> The greyscale teint (0-255)

	 - returns: 32位16进制颜色值(argb) <p> hex32 (argb)
	 */
	public static func g2Hex32(teint: UInt) -> UInt {
		return 0xff << 24 | teint << 16 | teint << 8 | teint;
	}
	/**
	 将灰色级(0-255)颜色值和Alpha值转换为32位的16进制颜色值(argb)。<p>
	 Convert a greyscale tenit (0-255) and alpha value to a hex32(argb)

	 - parameter teint: 灰度颜色值(0-255) <p> The greyscale teint (0-255)
	 - parameter alpha: 不透明度 <p> alpha value.

	 - returns: 32位16进制颜色值(argb) <p> hex32 (argb)
	 */
	public static func ag2Hex32(teint: UInt, _ alpha: UInt) -> UInt {
		return alpha << 24 | teint << 16 | teint << 8 | teint;
	}
	/**
	 将一个32位十六进制颜色值(argb)转换为ARGB颜色。<p>
	 Convert a hex32(argb) to ARGB

	 - parameter hex32: 32位16进制颜色值 <p> hex32(argb)

	 - returns: ARGB颜色 [0-255,0-255,0-255,0-255] <p> ARGB color [0-255,0-255,0-255,0-255]
	 */
	public static func hex32toArgb(hex32: UInt) -> [UInt] {
		return [hex32 >> 24, (hex32 & 0x00FF0000) >> 16, (hex32 & 0x0000FF00) >> 8, hex32 & 0x000000FF]
	}
	/**
	 将RGB颜色值转换为32位十六进制颜色值(argb)<p>
	 Convert a RGB color to hex32(argb).

	 - parameter red:   红色(0-255) <p> Red(0-255)
	 - parameter green: 绿色(0-255) <p> Green(0-255)
	 - parameter blue:  蓝色(0-255) <p> Blue(0-255)

	 - returns: 32位16进制颜色值(argb) <p> hex32 (argb)
	 */
	public static func rgb2Hex32(red: UInt, _ green: UInt, _ blue: UInt) -> UInt {
		return argb2Hex32(255, red, green, blue) ;
	}
	/**
	 将ARGB颜色值转换为32位十六进制颜色值(argb)<p>
	 Convert a ARGB color to hex32(argb).

	 - parameter alpha: 不透明度(0-255) <p> Alpha(0-255)
	 - parameter red:   红色(0-255) <p> Red(0-255)
	 - parameter green: 绿色(0-255) <p> Green(0-255)
	 - parameter blue:  蓝色(0-255) <p> Blue(0-255)

	 - returns: 32位16进制颜色值(argb) <p> hex32 (argb)
	 */
	public static func argb2Hex32(alpha: UInt, _ red: UInt, _ green: UInt, _ blue: UInt) -> UInt {
		return (alpha << 24) | (red << 16) | (green << 8) | blue;
	}
	/**
	 将32位颜色16进制颜色值(argb)转换为24位16进制颜色值(rgb)<p>
	 Convert a Hex32(argb) to Hex24(rgb).

	 - parameter hex32: 32位颜色16进制颜色值(argb) <p> Hex32(argb)

	 - returns: 24位16进制颜色值(rgb) <p> Hex24(rgb)
	 */
	public static func hex32to24(hex32: UInt) -> UInt {
		return hex32 & 0x00ffffff;
	}
	/**
	 将HSB颜色值转换为32位十六进制颜色值(argb)<p>
	 Convert a HSB color to Hex32(argb).

	 - parameter hue:        色调(0-359) <p> Hue(0-359)
	 - parameter saturation: 饱和度(0-1) <p> Saturation(0-1)
	 - parameter brightness: 明度(0-1) <p> Brightness(0-1)

	 - returns: 32位16进制颜色值(argb) <p> hex32 (argb)
	 */
	public static func hsb2Hex32(hue: UInt, _ saturation: Double, _ brightness: Double) -> UInt {
		return ahsb2Hex32(255, hue, saturation, brightness) ;
	}
	/**
	 将AHSB颜色值转换为32位十六进制颜色值(argb)<p>
	 Convert a AHSB color to Hex32(argb).

	 - parameter alpha:      不透明度(0-255) | Alpha(0-255)
	 - parameter hue:        色调(0-359) | Hue(0-359)
	 - parameter saturation: 饱和度(0-1) | Saturation(0-1)
	 - parameter brightness: 明度(0-1) | Brightness(0-1)

	 - returns: 32位16进制颜色值(argb) | hex32 (argb)
	 */
	public static func ahsb2Hex32(alpha: UInt, _ hue: UInt, _ saturation: Double, _ brightness: Double) -> UInt
	{
		var r: UInt = 0;
		var g: UInt = 0;
		var b: UInt = 0;
		var m1: Double = 0.0;
		var m2: Double = 0.0;
		if (saturation == 0) {
			let value = 255.0 * brightness
			b = UInt(value) ;
			g = UInt(value) ;
			r = UInt(value) ;
		} else
		{
			if (brightness <= 0.5) {
				m2 = brightness * (1 + saturation)
			} else {
				m2 = brightness + saturation - brightness * saturation
			}
		}
		m1 = 2 * brightness - m2
		r = parseHue(hue + 120, m1, m2)
		g = parseHue(hue, m1, m2)
		b = parseHue(hue - 120, m1, m2)
		return argb2Hex32(alpha, r, g, b) ;
	}
	
	
	private static func parseHue(var hue: UInt, _ m1: Double, _ m2: Double) -> UInt
	{
		hue = UInt(hue % 360) ;
		var v: Double;
		if (hue < 60) {
			v = m1 + (m2 - m1) * Double(hue) / 60
		} else if (hue < 180) {
			v = m2
		} else if (hue < 240) {
			v = m1 + (m2 - m1) * (240 - Double(hue)) / 60
		} else {
			v = m1
		}
		return UInt(v * 255)
	}
	/**
	 将CMYK颜色值转换为32位十六进制颜色值(argb)<p>
	 Convert a CMYK color to Hex32(argb).

	 - parameter cyan:    青色(0-255) <p> Cyan(0-255)
	 - parameter magenta: 品红色(0-255) <p> Magenta(0-255)
	 - parameter yellow:  黄色(0-255) <p> Yellow(0-255)
	 - parameter key:     黑色(0-255) <p> Key(0-255)

	 - returns: 32位16进制颜色值(argb) <p> hex32 (argb)
	 */
	public static func cmyk2Hex32(cyan: UInt, _ magenta: UInt, _ yellow: UInt, _ key: UInt) -> UInt {
		var r: Int = (65535 - (Int(cyan) * (255 - Int(key)) + (Int(key) << 8))) >> 8;
		var g: Int = (65535 - (Int(magenta) * (255 - Int(key)) + (Int(key) << 8))) >> 8;
		var b: Int = (65535 - (Int(yellow) * (255 - Int(key)) + (Int(key) << 8))) >> 8;
		r = PsdUtil.clamp(r, 0, 255) ;
		g = PsdUtil.clamp(g, 0, 255) ;
		b = PsdUtil.clamp(b, 0, 255) ;
		return argb2Hex32(255, UInt(r), UInt(g), UInt(b)) ;
	}
	
	public static func lab2hex32(l: Double, _ a: Double, _ b: Double) -> UInt {
		return alab2Hex32(255, l, a, b) ;
	}
	
	public static func alab2Hex32(alpha: UInt, _ l: Double, _ a: Double, _ b: Double) -> UInt {
		var xyz: [Double] = lab2xyz(l, a, b) ;
		return axyz2Hex32(alpha, xyz[0], xyz[1], xyz[2]) ;
	}
	private static let XYZ_INV_M = [
		3.134051341, -1.617027711, -0.4906522098,
			-0.9787627299, 1.916142228, 0.03344962851,
		0.07194257712, -0.2289711796, 1.405218305
	]
	private static func axyz2Hex32(alpha: UInt, _ x: Double, _ y: Double, _ z: Double) -> UInt {
		// sRGB
		var r: Double = x * XYZ_INV_M[0] + y * XYZ_INV_M[1] + z * XYZ_INV_M[2] ;
		var g: Double = x * XYZ_INV_M[3] + y * XYZ_INV_M[4] + z * XYZ_INV_M[5] ;
		var b: Double = x * XYZ_INV_M[6] + y * XYZ_INV_M[7] + z * XYZ_INV_M[8] ;
		// gamma 2.2
		r = invGamma(r) * 0xff;
		g = invGamma(g) * 0xff;
		b = invGamma(b) * 0xff;
		return argb2Hex32(alpha, UInt(r), UInt(g), UInt(b)) ;
	}
	/** gamma2.2 */
	private static func invGamma(value: Double) -> Double {
		if (value > 0.0031308) {
			return 1.055 * pow(value, 0.4167) - 0.055
		}
		return (12.92 * value) ;
	}
	private static func lab2xyz(l: Double, _ a: Double, _ b: Double) -> [Double] {
		// Lab->XYZ
		var x: Double = (l + 16) / 116;
		var y: Double = (l + 16) / 116 + a / 500;
		var z: Double = y - b / 200;
		x = x > 0.2069 ? (pow(x, 3)) : (0.1284 * (x - 0.1379)) ;
		y = y > 0.2069 ? (pow(y, 3)) : (0.1284 * (y - 0.1379)) ;
		z = z > 0.2069 ? (pow(z, 3)) : (0.1284 * (z - 0.1379)) ;
		// Reference White Point
		x = x * (96.4221 / 100) ;
		z = z * (82.5211 / 100) ;
		return [x, y, z] ;
	}
}