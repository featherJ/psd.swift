//
// TypeTool.swift
// psd.swift
//
// Created by featherJ on 16/1/12.
// Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
/**
 解析文档图层中的文本信息。<br>
 Parses and provides information about text areas within layers in the document.
 - author: featherJ
 */
public class TypeTool : AdditionalLayerInfoBase
{
	public static var key: String {
		get {
			return "TySh";
		}
	}
	
	/**
	 解析图层中的所有文本数据<br>
	 Parse all of the text data in the layer.
	 */
	override public func parse()
	{
		_ = fileBytes!.readShort() ;
		parseTransformInfo() ;
		_ = self.fileBytes!.readShort() ;
		_ = self.fileBytes!.readInt() ;
		let currenData = NSMutableDictionary() ;
		
		currenData["text"] = Descriptor.read(self.fileBytes!) ;
		_ = self.fileBytes!.readShort() ;
		_ = self.fileBytes!.readInt() ;
		currenData["warp"] = Descriptor.read(fileBytes!) ;
		currenData["left"] = fileBytes!.readInt() ;
		currenData["top"] = fileBytes!.readInt() ;
		currenData["right"] = fileBytes!.readInt() ;
		currenData["bottom"] = fileBytes!.readInt() ;
		self.data = currenData;
	}
	/**
	 得到文本域中的文本内容。<p>
	 Extracts the text within the text area. In the event that psd-enginedata fails
	 for some reason, we attempt to extract the text using some rough regex.
	 */
	public var textValue: String {
		get {
			let currentData = data as! NSMutableDictionary;
			return currentData["text"]!["Txt "] as! String;
		}
	}
	/**
	 得到当前文本域的所有字体基本信息。这里假设首选字体才是你想要得到的真正字体。<p>
	 Gets all of the basic font information for self text area. self assumes that
	 the first font is the only one you want.
	 */
	public var font: Dictionary<String, AnyObject>
	{
		get {
			return ["name": fonts[0],
				"fonts": fonts,
				"sizes": sizes,
				"colors": colors,
				"alignment": alignment,
				"leadings": leadings,
				"css": toCss()
			] ;
		}
	}
	//
	private var _fonts: NSMutableArray?;
	/**
	 * 当前图层中所列举的所有字体。|
	 * Returns all fonts listed for self layer, since fonts are defined on a
	 * per-character basis.
	 */
	public var fonts: NSArray {
		get {
			if (_fonts == nil) {
				_fonts = NSMutableArray()
				if (engineData["ResourceDict"] != nil && engineData["ResourceDict"]!["FontSet"] is NSArray)
				{
					let fontsets: NSArray = engineData["ResourceDict"]!["FontSet"] as! NSArray;
					for (var i = 0;i < fontsets.count;i++) {
						_fonts!.push(fontsets[i] ["Name"]!!) ;
					}
				}
			}
			return _fonts!;
		}
	}
	private var _leadings: NSMutableArray?;
	/**
	 * 所有的行间距 | All leadings (line spacing) for self layer.
	 */
	public var leadings: NSArray {
		get {
			if (_leadings == nil) {
				if (styles["Leading"] != nil)
				{
					_leadings = TypeTool.uniq(styles["Leading"] as! NSArray) ;
				}
			}
			return _leadings!;
		}
	}
	private var _sizes: NSMutableArray?;
	/**
	 * 当前图层的所有字号 | All font sizes for self layer.
	 */
	public var sizes: NSArray {
		get {
			if (_sizes == nil) {
				if (styles["FontSize"] != nil) {
					_sizes = TypeTool.uniq(styles["FontSize"] as! NSArray)
				}
			}
			return _sizes!;
		}
	}
	private var _alignment: NSMutableArray?;
	/**
	 * 所有的对齐 | All alignment for self layer.
	 */
	public var alignment: NSArray
	{
		get {
			if (_alignment == nil)
			{
				_alignment = NSMutableArray() ;
				let engineDict = engineData["EngineDict"] as? NSDictionary;
				if (engineDict != nil && engineDict!["ParagraphRun"] != nil && engineDict!["ParagraphRun"]!["RunArray"] != nil)
				{
					let alignments: [String] = ["left", "right", "center", "justify"] ;
					let runArray: NSArray = engineDict!["ParagraphRun"]!["RunArray"] as! NSArray;
					for (var i = 0;i < runArray.count;i++)
					{
						let paragraphSheet = runArray[i] ["ParagraphSheet"] as? NSDictionary
						if (paragraphSheet != nil && paragraphSheet!["Properties"] != nil && paragraphSheet!["Properties"]!["Justification"] != nil) {
							_alignment!.push(alignments[min(paragraphSheet!["Properties"]!["Justification"] as! Int, 3)]) ;
						}
					}
				}
			}
			return _alignment!;
		}
	}
	private var _colors: NSMutableArray?;
	/**
	 * 当前图层的文本使用的所有颜色, 这些颜色将按照RGBA的形式组成数组。 |
	 * Return all colors used for text in self layer. The colors are returned in RGBA
	 * format as an array of arrays: [[255, 0, 0, 255], [0, 0, 255, 255]]
	 */
	public var colors: NSArray {
		get {
			if (_colors == nil)
			{
				_colors = NSMutableArray() ;
				if (styles["FillColor"] != nil)
				{
					var fillColors: NSMutableArray = styles["FillColor"] as! NSMutableArray;
					fillColors = TypeTool.uniq(fillColors) ;
					for (var i = 0;i < fillColors.count;i++)
					{
						let values: NSMutableArray = fillColors[i] ["Values"]! as! NSMutableArray;
						let newValues = NSMutableArray() ;
						for (var j = 0;j < values.count;j++)
						{
							let value = round((values[j] as! Double) * 255.0) ;
							newValues.push(value) ;
						}
						newValues.push(newValues.firstObject!) ;// 将ARGB变为RGBA | Change ARGB -> RGBA for consistency
						newValues.removeObjectAtIndex(0) ;
						_colors!.push(newValues) ;
					}
				}
				if (_colors!.count == 0) {
					_colors!.push([0, 0, 0, 255]) ;
				}
			}
			return _colors!;
		}
	}
	private var engineDataParsed: Bool = false;
	/**
	 文本数据对象 <br>
	 Text engine data.
	 */
	public var engineData: NSDictionary
	{
		get {
			if (!engineDataParsed)
			{
				engineDataParsed = true
				let currentData = data as! NSMutableDictionary;
				currentData["engineData"] = EngineData.parse(self.data["text"]!!["EngineData"]! as! ByteArray) ;
			}
			return self.data["engineData"]! as! NSDictionary;
		}
	}
	
	private var _styles: NSMutableDictionary?;
	/**
	 * 当前图层的样式表 | The style map for current layer.
	 */
	public var styles: NSDictionary {
		get {
			if (_styles == nil)
			{
				let datas: NSMutableArray = [] ;
				if (engineData["EngineDict"] != nil && engineData["EngineDict"]!["StyleRun"] != nil && engineData["EngineDict"]!["StyleRun"]!!["RunArray"] != nil)
				{
					let runArray: NSMutableArray = engineData["EngineDict"]!["StyleRun"]!!["RunArray"] as! NSMutableArray;
					for (var i = 0;i < runArray.count;i++)
					{
						let StyleSheet: NSMutableDictionary? = runArray[i] ["StyleSheet"] as? NSMutableDictionary;
						if (StyleSheet != nil && StyleSheet!["StyleSheetData"] != nil) {
							datas.push(StyleSheet!["StyleSheetData"]!) ;
						}
					}
				}
				_styles = TypeTool.reduce(
					{(m: NSMutableDictionary, o: AnyObject) -> NSMutableDictionary in
						for (key, value) in(o as! NSMutableDictionary) {
							if (m[key as! String] == nil) {
								m[key as! String] = NSMutableArray()
							}
							let arr: NSMutableArray = m[key as! String] as! NSMutableArray
							arr.push(value) ;
						}
						return m;
					}, initial: NSMutableDictionary(), arr: datas) ;
			}
			return _styles!;
		}
	}
	
	private static func uniq(arr: NSArray) -> NSMutableArray {
		let newArr = NSMutableArray() ;
		for (var i = 0;i < arr.count;i++) {
			if (newArr.count == 0) {
				newArr.push(arr[i]) ;
			} else {
				newArr.push(arr[i]) ;
			}
		}
		return newArr;
	}
	
	private static func reduce(f: (m: NSMutableDictionary, o: AnyObject) -> NSMutableDictionary, initial: NSMutableDictionary, arr: NSArray) -> NSMutableDictionary
	{
		if (arr.count == 0)
		{
			return initial;
		} else
		{
			var acc: NSMutableDictionary = initial;
			for (var i = 0; i < arr.count; ++i)
			{
				acc = f(m: acc, o: arr[i]) ;
			}
			return acc;
		}
	}
	
	/**
	 * 创建CSS样式。该方法将返回CSS样式的字符串表示。每一个属性将是新的一行，并不是所有的属性都会在该css样式中展现。
	 * <p>
	 * Creates the CSS string and returns it. Each property is newline separated
	 * and not all properties may be present depending on the document.
	 * Colors are returned in RGBA format and fonts may include some internal
	 * Photoshop fonts.
	 */
	public func toCss() -> String{
		let definition = [
			"font - family" : fonts.join(", "),
			"font - size" : String(sizes[0]) + "pt",
			"color" : "rgba(" + (colors[0] as! NSArray).join(", ") + ")",
			"text - align" : String(alignment[0])
		] ;
		let css = NSMutableArray() ;
		for (key,value) in definition{
			css.push(String(key) + ": " + String(value) + ";") ;
		}
		return  css.join("\n");
	}
	
	internal func parseTransformInfo()
	{
		let currentData: NSMutableDictionary = data as! NSMutableDictionary;
		currentData["transform"] = NSMutableDictionary(dictionary: [
				"xx": self.fileBytes!.readDouble(),
				"xy": self.fileBytes!.readDouble(),
				"yx": self.fileBytes!.readDouble(),
				"yy": self.fileBytes!.readDouble(),
				"tx": self.fileBytes!.readDouble(),
				"ty": self.fileBytes!.readDouble()
			]) ;
	}
}