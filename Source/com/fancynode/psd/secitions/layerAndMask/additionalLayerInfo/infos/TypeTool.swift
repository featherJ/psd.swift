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
//public class TypeTool : AdditionalLayerInfoBase
//{
//	public static var key: String {
//		get {
//			return "TySh";
//		}
//	}
//	/**
//	 解析图层中的所有文本数据<br>
//	 Parse all of the text data in the layer.
//	 */
//	override public func parse()
//	{
//		_ = fileBytes!.readShort() ;
//		parseTransformInfo() ;
//		_ = self.fileBytes!.readShort() ;
//		_ = self.fileBytes!.readInt() ;
//		var currenData = [String: AnyObject]() ;
//		
//		currenData["text"] = Descriptor.read(self.fileBytes!) ;
//		_ = self.fileBytes!.readShort() ;
//		_ = self.fileBytes!.readInt() ;
//		currenData["warp"] = Descriptor.read(fileBytes!) ;
//		currenData["left"] = fileBytes!.readInt() ;
//		currenData["top"] = fileBytes!.readInt() ;
//		currenData["right"] = fileBytes!.readInt() ;
//		currenData["bottom"] = fileBytes!.readInt() ;
//		self.data = currenData;
//	}
//	/**
//	 得到文本域中的文本内容。<p>
//	 Extracts the text within the text area. In the event that psd-enginedata fails
//	 for some reason, we attempt to extract the text using some rough regex.
//	 */
//	public var textValue: String {
//		get {
//			return self.data!["text"]!!["Txt "] as! String;
//		}
//	}
//	/**
//	 得到当前文本域的所有字体基本信息。这里假设首选字体才是你想要得到的真正字体。<p>
//	 Gets all of the basic font information for self text area. self assumes that
//	 the first font is the only one you want.
//	 */
//	public var font: AnyObject
//	{
//		get {
//			return ["name": fonts[0],
//				"fonts": fonts,
//				"sizes": sizes,
//				"colors": colors,
//				"alignment": alignment,
//				"leadings": leadings,
//				"css": toCss()
//			] ;
//		}
//	}
//	
//	private var _fonts: [String]?;
//	/**
//	 * 当前图层中所列举的所有字体。|
//	 * Returns all fonts listed for self layer, since fonts are defined on a
//	 * per-character basis.
//	 */
//	public var fonts: [String] {
//		get {
//			if (_fonts == nil)
//			{
//				_fonts = []
//				if (engineData && engineData["ResourceDict"] && engineData["ResourceDict"] ["FontSet"] is Array)
//				{
//					var fontsets: Array = engineData["ResourceDict"] ["FontSet"] as Array;
//					for (var i: int = 0;i < fontsets.length;i++)
//					_fonts.push(fontsets[i] ["Name"]) ;
//				}
//			}
//			return _fonts;
//		}
//	}
//	private var _leadings: Array;
//	/**
//	 * 所有的行间距 | All leadings (line spacing) for self layer.
//	 */
//	public function get leadings(): Array
//	{
//		if (!_leadings)
//		{
//			if (styles && styles.hasOwnProperty("Leading"))
//			_leadings = ArrayUtil.uniq(styles['Leading']) ;
//		}
//		return _leadings;
//	}
//	private var _sizes: Array;
//	/**
//	 * 当前图层的所有字号 | All font sizes for self layer.
//	 */
//	public function get sizes(): Array
//	{
//		if (!_sizes)
//		{
//			if (styles && styles.hasOwnProperty('FontSize'))
//			_sizes = ArrayUtil.uniq(styles['FontSize'])
//		}
//		return ArrayUtil.uniq(styles['FontSize']) ;
//	}
//	private var _alignment: Array;
//	/**
//	 * 所有的对齐 | All alignment for self layer.
//	 */
//	public function get alignment(): Array
//	{
//		if (!_alignment)
//		{
//			_alignment = [] ;
//			if (engineData && engineData["EngineDict"] && engineData["EngineDict"] ["ParagraphRun"] && engineData["EngineDict"] ["ParagraphRun"] ["RunArray"])
//			{
//				var alignments: Array = ['left', 'right', 'center', 'justify'] ;
//				var runArray: Array = engineData["EngineDict"] ["ParagraphRun"] ["RunArray"] as Array;
//				for (var i: int = 0;i < runArray.length;i++)
//				{
//					if (runArray[i] ["ParagraphSheet"] && runArray[i] ["ParagraphSheet"] ["Properties"] && runArray[i] ["ParagraphSheet"] ["Properties"] ["Justification"])
//					_alignment.push(alignments[Math.min(parseInt(runArray[i] ["ParagraphSheet"] ["Properties"] ["Justification"], 10), 3)]) ;
//				}
//			}
//		}
//		return _alignment;
//	}
//	private var _colors: Array;
//	/**
//	 * 当前图层的文本使用的所有颜色, 这些颜色将按照RGBA的形式组成数组。 |
//	 * Return all colors used for text in self layer. The colors are returned in RGBA
//	 * format as an array of arrays: [[255, 0, 0, 255], [0, 0, 255, 255]]
//	 */
//	public function get colors(): Array
//	{
//		if (!_colors)
//		{
//			_colors = [] ;
//			if (styles && styles.hasOwnProperty("FillColor"))
//			{
//				var fillColors: Array = styles['FillColor'] as Array;
//				fillColors = ArrayUtil.uniq(fillColors) ;
//				for (var i: int = 0;i < fillColors.length;i++)
//				{
//					var values: Array = fillColors[i] ["Values"] as Array;
//					var newValues: Array = [] ;
//					for (var j: int = 0;j < values.length;j++)
//					{
//						var value: int = Math.round(Number(values[j]) * 255) ;
//						newValues.push(value) ;
//					}
//					newValues.push(newValues.shift()) ;// 将ARGB变为RGBA | Change ARGB -> RGBA for consistency
//					_colors.push(newValues) ;
//				}
//			}
//			if (_colors.length == 0)
//			_colors.push([0, 0, 0, 255]) ;
//		}
//		return _colors;
//	}
//	private var engineDataParsed: Bool = false;
//	/**
//	 文本数据对象 <br>
//	 Text engine data.
//	 */
//	public var engineData: AnyObject
//	{
//		get {
//			if (!engineDataParsed)
//			{
//				engineDataParsed = true
//				data["engineData"] = EngineData.parse(self.data!["text"]!!["EngineData"]!!) ;
//			}
//			return self.data!["engineData"] ;
//		}
//	}
//	
//	private var _styles: Object;
//	/**
//	 * 当前图层的样式表 | The style map for current layer.
//	 */
//	public function get styles(): Object
//	{
//		if (!_styles)
//		{
//			var datas: Array = [] ;
//			if (engineData && engineData["EngineDict"] && engineData["EngineDict"] ["StyleRun"] && engineData["EngineDict"] ["StyleRun"] ["RunArray"])
//			{
//				var runArray: Array = engineData["EngineDict"] ["StyleRun"] ["RunArray"] ;
//				for (var i: int = 0;i < runArray.length;i++)
//				{
//					if (runArray[i] ["StyleSheet"] && runArray[i] ["StyleSheet"] ["StyleSheetData"])
//					datas.push(runArray[i] ["StyleSheet"] ["StyleSheetData"]) ;
//				}
//			}
//			_styles = ArrayUtil.reduce(function(m: Object, o: Object): Object {
//					for (var k: Object in o)
//					{
//						if (!o.hasOwnProperty(k))
//						continue;
//						var v: Object = o[k] ;
//						if (!m[k]) m[k] = [] ;
//						m[k].push(v) ;
//					}
//					return m;
//				}, {}, datas) ;
//		}
//		return _styles;
//	}
//	/**
//	 * 创建CSS样式。该方法将返回CSS样式的字符串表示。每一个属性将是新的一行，并不是所有的属性都会在该css样式中展现。
//	 * <p>
//	 * Creates the CSS string and returns it. Each property is newline separated
//	 * and not all properties may be present depending on the document.
//	 * Colors are returned in RGBA format and fonts may include some internal
//	 * Photoshop fonts.
//	 */
//	public function toCss(): String
//	{
//		var definition: Object = {
//			'font - family' : fonts.join(', '),
//			'font - size' : sizes[0] + "pt",
//			'color' : "rgba(" + colors[0].join(', ') + ")",
//			'text - align' : alignment[0]
//		} ;
//		var css: Array = [] ;
//		for (var key: String in definition)
//		css.push(key + ": " + definition[key] + ";") ;
//		return css.join("\n") ;
//	}
//	func parseTransformInfo()
//	{
//		self.data["transform"] = {} ;
//		self.data["transform"] ["xx"] = self.fileBytes!.readDouble() ;
//		self.data["transform"] ["xy"] = self.fileBytes!.readDouble() ;
//		self.data["transform"] ["yx"] = self.fileBytes!.readDouble() ;
//		self.data["transform"] ["yy"] = self.fileBytes!.readDouble() ;
//		self.data["transform"] ["tx"] = self.fileBytes!.readDouble() ;
//		self.data["transform"] ["ty"] = self.fileBytes!.readDouble() ;
//	}
//}