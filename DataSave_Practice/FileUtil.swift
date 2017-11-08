//
//  FileUtil.swift
//  DataSave_Practice
//
//  Created by commany_mac on 2017. 11. 5..
//  Copyright © 2017년 CommanyShin. All rights reserved.
//

import Foundation

public class FileUtil {
	// Identifying the document directory
	public static let documentDirectory = NSSearchPathForDirectoriesInDomains(.documentDirectory,
																			  .userDomainMask,
																			  true).first!
	
	// Get the current working directory
	public static let currentDirectory = FileManager.default.currentDirectoryPath
	
	// Creating a New Directory
	public static func createDirectory(atPath: String) -> String {
		do {
			try FileManager.default.createDirectory(atPath: atPath,
													withIntermediateDirectories: false,
													attributes: nil)
			return "New directory path : \(atPath)"
		} catch let error as NSError {
			return "Error: \(error.localizedDescription)"
		}
	}
	
	
}



/*
// MARK:  静的プロパティ -

//ホームディレクトリ:
public static let homeDir: String = NSHomeDirectory()
//iOS の一時ディレクトリ (tmp/) の取得
public static let tempDir: String = NSTemporaryDirectory()
// iOS のドキュメントディレクトリ (Documents/)
public static let documentDir: String =
	NSSearchPathForDirectoriesInDomains(
		.documentDirectory, .userDomainMask, true).first!
//カレントディレクトリ
//(--- Swift3 beta6 ---) update 16/08/19
//public static let currentDir: String = FileManager.default().currentDirectoryPath
public static let currentDir: String = FileManager.default.currentDirectoryPath

// MARK: 静的メソッド -

// 指定パスのディレクトリを作成
public static func createDir(atPath: String) -> String {
	do {
		//(--- Swift3 beta6 ---) update 16/08/19
		//try FileManager.default().createDirectory(
		try FileManager.default.createDirectory(
			atPath: atPath,
			withIntermediateDirectories: false,
			attributes: nil)
		return "ディレクトリ作成成功: \(atPath)"
	} catch let error as NSError {
		return "ディレクトリ作成エラー：　\(error.localizedDescription)"
	}
}

// 指定パスのファイルを作成
public static func createFile(atPath: String, output: String) -> String {
	do {
		try output.write(
			toFile: atPath,
			atomically: true,
			encoding: String.Encoding.utf8)
		return "ファイル作成成功: \(atPath)"
	} catch let error as NSError {
		return "ファイル作成エラー：　\(error.localizedDescription)"
	}
}

//　指定パスのファイルにデータを追加
public static func appendFile(atPath: String, output: String) -> String {
	let append : Bool  = true
	//(--- Swift3 beta6 ---) update 16/08/19
	//let os = NSOutputStream(toFileAtPath: atPath, append: append)!
	let os = OutputStream(toFileAtPath: atPath, append: append)!
	os.open()
	let result = os.write(output,
						  maxLength: output.lengthOfBytes(using: String.Encoding.utf8))
	os.close()
	if (result > 0) {
		return "データ追加成功: \(atPath)"
	} else {
		return "データ追加エラー：　\(atPath)"
	}
}

// 指定パスからデータを読み込む
public static func readFile(fromPath: String) -> (Bool, String) {
	do {
		let input = try NSString( contentsOfFile: fromPath, encoding:
			String.Encoding.utf8.rawValue )
		return (false, input as String)
	} catch let error as NSError {
		return(true, error.localizedDescription)
	}
}

//指定ディレクトリのコンテントを取得
public class func getContents(atPath: String) -> [String] {
	var contents: [String] = []
	//(--- Swift3 beta6 ---) update 16/08/19
	//let fm  = FileManager.default()
	let fm  = FileManager.default
	var isDir: ObjCBool = true
	
	if (fm.fileExists(atPath: atPath, isDirectory: &isDir)) {
		do {
			contents =  try fm.contentsOfDirectory(atPath: atPath)
		} catch let error as NSError {
			print(error.localizedDescription)
		}
	}
	return contents
}

//指定ディレクトリのサブディレクトリを取得
public class func getFiles(atPath: String) -> [String] {
	var files: [String] = []
	//(--- Swift3 beta6 ---) update 16/08/19
	//let fm  = FileManager.default()
	let fm  = FileManager.default
	for content in getContents(atPath: atPath) {
		let path = atPath + "/" + content
		var isDir : ObjCBool = false
		if fm.fileExists(atPath: path, isDirectory:&isDir) {
			//(--- Swift3 beta6 ---) update 16/08/19
			//if isDir {
			if isDir.boolValue {
				files.append(content)
			}
		}
	}
	return files
}

//指定ディレクトリのファイルを取得
public class func getDirs(atPath: String) -> [String] {
	var dirs: [String] = []
	//(--- Swift3 beta6 ---) update 16/08/19
	//let fm  = FileManager.default()
	let fm  = FileManager.default
	for content in getContents(atPath: atPath) {
		let path = atPath + "/" + content
		var isDir : ObjCBool = false
		if fm.fileExists(atPath: path, isDirectory:&isDir)  {
			//(--- Swift3 beta6 ---) update 16/08/19
			//if isDir {
			if isDir.boolValue {
				dirs.append(content)
			}
		}
	}
	return dirs
}

print("##### iOSディレクトリ取得 #####")
print("ホームディレクトリ：　\(FileUtil.homeDir)")
print("ドキュメントディレクトリ：　\(FileUtil.documentDir)")
print("一時ディレクトリ：　\(FileUtil.tempDir)")
print("カレントディレクトリ：　\(FileUtil.currentDir)")

print("##### ディレクトリの作成 #####")
for path in ["/img","/video", "/music"] {
let dirPath = FileUtil.documentDir + path
print(FileUtil.createDir(atPath: dirPath))
}
let makeDirs = FileUtil.getDirs(atPath: FileUtil.documentDir)
print("作成されたディレクトリ：\(makeDirs)")

print("##### ファイル出力(新規） #####")
for pathAndData in [
("/myFile01.txt", "line1001\nline1002\n"),
("/myFile02.txt", "line2001\nline2002\nline2003\n")] {
let filePath = FileUtil.documentDir + pathAndData.0
print(FileUtil.createFile(atPath: filePath, output: pathAndData.1 ))
}


print("##### ファイル出力（追加） #####")
for pathAndData in [
("/myFile02.txt", "line20A1\nline20A2\n"),
("/myFile03.txt", "line3001\nline3002\n")] {
let filePath = FileUtil.documentDir + pathAndData.0
print(FileUtil.appendFile(atPath: filePath, output: pathAndData.1 ))
}


print("##### ファイル入力 #####")
for path in ["/myFile01.txt", "/myFile02.txt", "/myFile03.txt"] {
let filePath = FileUtil.documentDir + path
let result: (err: Bool, input: String) = FileUtil.readFile(fromPath: filePath)
if !result.err {
print("入力データ： \(result.input)")
}
}
view raw


print("##### ファイル属性 #####")
let docPath = FileUtil.documentDir
for path in FileUtil.getFiles(atPath: docPath) {
print("\(path): %%%%%%%%%%")
let apath = docPath + "/"  + path
//(--- Swift3 beta6 ---) update 16/08/19
//let attrs =  try? FileManager.default().attributesOfItem(atPath: apath)
let attrs =  try? FileManager.default.attributesOfItem(atPath: apath)
for attr in attrs! {
//(--- Swift3 beta6 ---) update 16/08/19
//if attr.0 == "NSFileCreationDate" {
if attr.0 == FileAttributeKey.creationDate {
print("作成日: \(attr.1)")
//(--- Swift3 beta6 ---) update 16/08/19
//} else if attr.0 == "NSFileModificationDate" {
} else if attr.0 == FileAttributeKey.modificationDate {
print("更新日: \(attr.1)")
//(--- Swift3 beta6 ---) update 16/08/19
//} else if attr.0 == "NSFileSize" {
} else if attr.0 == FileAttributeKey.size {
print("サイズ: \(attr.1)")
}
}
}





*/
