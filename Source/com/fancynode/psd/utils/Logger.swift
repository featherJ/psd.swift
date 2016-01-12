//
//  Logger.swift
//  psd.swift
//
//  Created by featherJ on 16/1/11.
//  Copyright © 2016年 fancynode. All rights reserved.
//

import Foundation
class Logger{
	static func warn(str:Any){
		print("[PSD warning]:\n",str);
	}
	static func error(str:Any){
		print("[PSD error]:\n",str);
	}
	static func debug(str:Any){
		print("[PSD debug]:\n",str);
	}
	static func put(str:Any){
		print(str);
	}
}