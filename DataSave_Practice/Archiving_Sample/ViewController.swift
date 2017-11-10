//
//  ViewController.swift
//  DataSave_Practice
//
//  Created by commany_mac on 2017. 10. 28..
//  Copyright © 2017년 CommanyShin. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

	@IBOutlet weak var nameTextField: UITextField!
	@IBOutlet weak var addressTextField: UITextField!
	@IBOutlet weak var phoneTextField: UITextField!
	
	@IBOutlet weak var saveButton: UIButton!

	var dataFilePath: String!
	
	override func viewDidLoad() {
		super.viewDidLoad()
		
		
		
		/*
		let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
		let documentDirectory = dirPaths[0]
		let folder = documentDirectory.appending("/templates")
		
		var fileListArray: [String]
		
		do
		{
			let fileList = try FileManager.default.contentsOfDirectory(atPath: folder)
			for file in fileList
			{
				fileListArray.append(file)
			}
		}
		catch
		{
			debugPrint(error.localizedDescription)
		}
		*/
		
	
		/*
		// 애플리케이션의 Document 디렉토리 경로를 추출, 이 경로와 아카이브 데이터 파일 이름을 가지고 전체 경로를 만든후 dataFilePath를 생성
		let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
		let docsDir = dirPaths[0] as String
		//dataFilePath = docsDir.stringByAppendingString("/data.archive")
		print("[1] DataFilePath => \(dataFilePath)")
		*/
		
		
		// File 작업
		//createFile()
		
		//fileMgr()
		
		// FileHandle 작업
		fileHandle()
		
		
		// / saveButton.addTarget(self, action: #selector(self.saveButtonTapped(sender:)), for: .touchUpInside)
	}
	
	@objc func saveButtonTapped(sender: UIButton) {
		// 호출시 새로운 배열을 만들고 필드의 내용을 배열의 각 항목에 할당한다.
		let contactArray = [nameTextField.text!, addressTextField.text!, phoneTextField.text!]
		NSKeyedArchiver.archiveRootObject(contactArray, toFile: dataFilePath!)
		print("[3] Archiving 저장이 완료되었습니다.")
	}
	
	// 현재 애플리케이션의 Documents 디렉토리 얻기
	func getDocumentsDirectory() -> URL {
		let dirPaths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
		let documentsDirectory = dirPaths[0]
		
		print("[a] \(dirPaths[0])")
		print("[b] \(dirPaths[0].path)")
		
		/*
		[a] file:///Users/commany_mac/Library/Developer/CoreSimulator/Devices/ADA4C640-3D55-4B52-AF51-3773E31765E6/data/Containers/Data/Application/6EF0C9EA-D49B-4E69-ACB7-441DE9A8B191/Documents/
		[b] /Users/commany_mac/Library/Developer/CoreSimulator/Devices/ADA4C640-3D55-4B52-AF51-3773E31765E6/data/Containers/Data/Application/6EF0C9EA-D49B-4E69-ACB7-441DE9A8B191/Documents
		*/
		
		return documentsDirectory
	}
	
	// 디렉토리 변경
	func changeDirectory() {
		let filemgr = FileManager.default
		let dirPaths = filemgr.urls(for: .documentDirectory,
									in: .userDomainMask)
		let docsDir = dirPaths[0].path
		
		// 디렉토리 변경
		if filemgr.changeCurrentDirectoryPath(docsDir) {
			// Success
			print("[4] 작업중인 디렉토리 변경을 성공하였습니다.!!!")
			print("[4] 변경 디렉토리 Path : \(docsDir)")
		} else {
			// Failure
			print("[4] 작업중인 디렉토리 변경을 실패하였습니다.!!!")
		}
	}
	
	// Directory 작업 모음
	func directoryMgr() {
		// FileManger 인스턴스 생성
		let fileManager = FileManager.default
		
		// 현재 작업 디렉토리 확인
		let currentPath = fileManager.currentDirectoryPath
		print("[1] Current Directory : \(currentPath)")
		
		// 현재 애플리케이션의 Documents 디렉토리 얻기
		let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
		let docsDir = dirPaths[0]
		print("[2-1] Documents Directory : \(docsDir)")
		print()
		print("[2-2] \(getDocumentsDirectory())")
		
		// 현재 애플리케이션의 Tmp 디렉토리 얻기
		let tmpDir = NSTemporaryDirectory()
		print("[3] Temporary Directory : \(tmpDir)")
		
		// 현재 작업 디렉토리로 변경
		if fileManager.changeCurrentDirectoryPath(docsDir) {
			// Success
			print("[4] 작업중인 디렉토리 변경을 성공하였습니다.!!!")
			print("[4] 변경 디렉토리 Path : \(docsDir)")
			
			let currentPath = fileManager.currentDirectoryPath
			print("[1] Current Directory : \(currentPath)")
		} else {
			// Failure
			print("[4] 작업중인 디렉토리 변경을 실패하였습니다.!!!")
		}
		
		// 새 디렉토리 생성.
		// createDirectory()
		
		// [1] FileManager 인스턴스 생성.
		let filemgrCreate = FileManager.default
		
		// [2-1] documents 디렉토리의 경로 저장.
		let dirPathsCreate = NSSearchPathForDirectoriesInDomains(.documentationDirectory,
																 .userDomainMask, true)
		let docsDirCreate = dirPathsCreate[0]
		
		// [3-1] 생성할 디렉토리 이름 지정.
		let newDirCreate = docsDirCreate.appending("/data")
		
		// [2-2] documents 디렉토리의 경로 저장.
		//
		// urls(for:in:) 메소드를 통해 특정 경로에 접근.
		//
		// domainMask는 존재하는 상위 URL을 숨기는 것을 의미하며,
		// userDomainMask로 설정하면 /User 보다 위에 있는 디렉토리는 접근할 수 없게 된다.
		let documentsDirectory = filemgrCreate.urls(for: .documentDirectory,
													in: .userDomainMask).first!
		
		// [3-2] 해당 디렉토리 이름 지정.
		// 해당 경로에 추가 경로를 지정하는 방식으로 디렉토리 명 추가.
		let dataPath = documentsDirectory.appendingPathComponent("FileManger Directory")
		
		do {
			// [4-1] 디렉토리 생성.
			try filemgrCreate.createDirectory(atPath: newDirCreate,
											  withIntermediateDirectories: true,
											  attributes: nil)
			
			print("[5] 디렉토리 생성전 DirectoryPath : \(docsDirCreate)")
			print("[5] New directory path : \(newDirCreate)")
			
			// [4-2] 디렉토리 생성.
			try filemgrCreate.createDirectory(atPath: dataPath.path,
											  withIntermediateDirectories: false,
											  attributes: nil)
		} catch {
			print("[5] Failed to create dir!!")
			print(error)
		}
		
		// [6] 디렉토리 삭제
		if FileManager.default.fileExists(atPath: newDirCreate) {
			do {
				print("[6] 삭제할 디렉토리명 : \(newDirCreate)")
				
				try fileManager.removeItem(atPath: newDirCreate)
				try fileManager.removeItem(at: dataPath)
				
				print("[6] Delete Success!!")
			} catch let error {
				print("[6] 디렉토리 삭제 실패")
				print("[6] Error : \(error.localizedDescription)")
			}
		}
		
		// [7] 디렉토리 내용 나열
		do {
			let fileList = try fileManager.contentsOfDirectory(atPath: "/")
			
			for (index, filename) in fileList.enumerated() {
				print("[7-\(index)] \(filename)")
			}
		} catch let error {
			print("[7] 디렉토리 리스팅 실패")
			print("Error: \(error.localizedDescription)")
		}
		
		// [8] 파일 또는 디렉토리의 속성
		do {
			let attributes: NSDictionary = try fileManager.attributesOfItem(atPath: "/Applications") as NSDictionary
			let type = attributes["NSFileType"] as! String
			print("[8] File type \(type)")
		} catch let error {
			print("[8] 파일 및 디렉토리 속성 출력 실패")
			print("Error: \(error.localizedDescription)")
		}
	}
	
	// File 작업 모음
	func fileMgr() {
		print("========================================================")
		
		let fileManager = FileManager.default
		
		// [F1] 파일 존재 확인
		if FileManager.default.fileExists(atPath: "/Applications") {
			print("[F1] File exists")
		} else {
			print("[F1] File not found")
		}
		
		
		// [2] 2개의 파일 내용 비교
		let filePath1 = "/tmp/testfile1.txt"
		let filePath2 = "/tmp/testfile2.txt"
		
		if fileManager.createFile(atPath: filePath1, contents: nil, attributes: nil) {
			print("[2] filePath1 파일 생성 완료!!")
		} else {
			print("[2] filePath1 파일 생성 실패!!")
		}
		
		if fileManager.createFile(atPath: filePath2, contents: nil, attributes: nil) {
			print("[2] filePath2 파일 생성 완료!!")
		} else {
			print("[2] filePath2 파일 생성 실패!!")
		}
		
		
		// 디렉토리 내용 나열
		do {
			let fileList = try fileManager.contentsOfDirectory(atPath: "/tmp")
			for fileName in fileList {
				print("[2] \(fileName)")
			}
		} catch let error {
			print("[2] 디렉토리 리스팅 실패!!")
			print("Error : \(error.localizedDescription)")
		}
		
		
		// 2개의 파일 내용 비교
		if fileManager.contentsEqual(atPath: filePath1, andPath: filePath2) {
			print("[F2] File contents match !!")
		} else {
			print("[F2] File contents do not match !!")
		}
		
		
		// [3] 파일의 읽기가능/쓰기가능/실행가능/삭제가능 상태 확인
		// isReadableFile
		// isWritableFile
		// isExecutableFile
		// isDeletableFile
		if fileManager.isWritableFile(atPath: filePath1) {
			print("[F3] File is writable")
		} else {
			print("[F3] File is read-only")
		}
		
		/*
		// [4] 파일 옮기기 및 이름 바꾸기
		let tmpDir: URL = fileManager.temporaryDirectory
		let moveFilePath: URL = tmpDir.appendingPathComponent("newMove")
		
		
		print("Temporary directory path : \(tmpDir)")
		print("Create directory path : \(moveFilePath)")
		
		do {
			if fileManager.fileExists(atPath: moveFilePath.path) {
				print("[F4] 새 디렉토리 생성 시작 !!")
				try fileManager.createDirectory(atPath: moveFilePath.path,
												withIntermediateDirectories: true,
												attributes: nil)
				
				// try fileManager.changeCurrentDirectoryPath(moveFilePath)
			} else {
				print("[F4] 생성할 디렉토리 있음 !!")
			}
		} catch let error as NSError {
			print("[F4] 새 디렉토리 생성 안됨 !!")
			print("Error: \(error.localizedDescription)")
		}
		
		do {
			// 기존 파일 삭제 처리
			let checkFile = moveFilePath.appendingPathComponent("/testfile1.txt")
			print("[F4] 기존 파일 존재 여부 체크 -> \(checkFile)")
			print("current : \(fileManager.currentDirectoryPath)")
			
			
			if fileManager.fileExists(atPath: checkFile.path) {
				print("[F4] 기존 파일 존재 !!")
				try fileManager.removeItem(atPath: checkFile.path)
			} else {
				print("[F4] 기존 파일 없음 !!")
			}
			
			// 파일 옮기기
			try fileManager.moveItem(atPath: filePath1, toPath: moveFilePath.path)
			
			// 디렉토리의 내용 나열
			do {
				let fileList = try FileManager.default.contentsOfDirectory(atPath: moveFilePath.path)
				for fileName in fileList {
					print("[F4] \(fileName)")
				}
			} catch {
				print("[F4] 디렉토리 리스팅 실패 !!")
			}
			
			print("[F4] File movement is successful !!")
		} catch {
			print("[F4] File movement is failed !! -> \(error)")
		}
		*/
		
		
		print("========================================================")
	}
	
	// 파일 관련 작업만 모아놓은 함수
	func createFile() {
		
		let fileManager = FileManager.default
		
		// [1] 현재 작업 디렉토리 변경
		var currentPath = fileManager.currentDirectoryPath
		print("[1-Before path] Current Directory : \(currentPath)")
		
		let tmpPath = fileManager.temporaryDirectory
		if fileManager.changeCurrentDirectoryPath(tmpPath.path) {
			// Success
			print("작업중인 디렉토리 변경이 성공하였습니다.!!!")
			
			currentPath = fileManager.currentDirectoryPath
			print("[1-Current path] Current Directory : \(currentPath)")
		} else {
			// Failure
			print("작업중인 디렉토리 변경이 실패하였습니다.!!!")
		}
		
		// [2] 새 디렉토리 생성
		// 생성할 디렉토리 이름 지정
		let newDirCreate = tmpPath.appendingPathComponent("newDir")
		
		do {
			// 지정된 이름으로 디렉토리 생성
			try fileManager.createDirectory(atPath: newDirCreate.path,
											withIntermediateDirectories: true,
											attributes: nil)
			
			print("[2-Create Directory] New directory path : \(newDirCreate)")
		} catch {
			print("[2-Create Directory] Failed to create dir -> \(error)")
		}
		
		// [3] 파일 생성
		// 파일 이름을 기존의 경로에 추가
		let filePath1 = tmpPath.appendingPathComponent("testfile1.txt")
		if fileManager.createFile(atPath: filePath1.path, contents: nil,
								  attributes: nil) {
			print ("[3-Create File] \"testfile1.txt\" 파일을 생성되었습니다.")
			
			// 파일에 쓸 내용
			let writingText = "Hello File From Swift\nHi~~~"
			do {
				// 쓰기 작업
				try writingText.write(toFile: filePath1.path, atomically: true,
									  encoding: .utf8)
			} catch {
				print("[3-Writing] Error Writing File : \(error.localizedDescription)")
			}
		} else {
			print ("[3-Create File] 파일을 생성할 수 없습니다.")
		}
		
		do {
			// 파일 속 내용 읽기
			let fileContent = try String(contentsOfFile: filePath1.path, encoding: String.Encoding.utf8)
			print("[3-Reading] \(fileContent)")
		} catch let error {
			print("[3-Reading] Error Reading File : \(error.localizedDescription)")
		}
		
		
		
		let filePath2 = newDirCreate.appendingPathComponent("testfile2.txt")
		if fileManager.createFile(atPath: filePath2.path, contents: nil,
								  attributes: nil) {
			print ("[3-Create File] \"testfile2.txt\" 파일을 생성되었습니다.")
		} else {
			print ("[3-Create File] 파일을 생성할 수 없습니다.")
		}
		
		// 파일 옮기기
		let moveFilePath = newDirCreate.appendingPathComponent("testfile1.txt")
		
		/*
		do {
			print("\(fileManager.currentDirectoryPath)")
			try fileManager.moveItem(atPath: filePath1.path, toPath: moveFilePath.path)
			print("[F4] 파일을 성공적으로 옮겼습니다.")
		} catch let error {
			print("[F4] 파일을 옮기지 못 했습니다. \n -> \(error.localizedDescription)")
		}
		*/
		
		do {
			try fileManager.copyItem(at: filePath1, to: moveFilePath)
			print("[F4] 파일을 성공적으로 복사했습니다..")
		} catch let error {
			print("[F4] 파일을 복사하지 못 했습니다. \n -> \(error.localizedDescription)")
		}
		
		// 파일 삭제
		if fileManager.fileExists(atPath: moveFilePath.path) {
			do {
				try fileManager.removeItem(at: moveFilePath)
				print("[5] 기존 파일 삭제 성공!!")
			} catch let error {
				print("[5] 기존 파일 삭제 실패!!/nError : \(error.localizedDescription)")
			}
		} else {
			print("[5] 해당 파일 존재하지 않음!!")
		}
		
		do {
			try fileManager.createSymbolicLink(at: filePath2, withDestinationURL: moveFilePath)
			print("[6] Link successful!!")
		} catch {
			print("[6] Link failed!! Error => \(error)")
		}
		
		
		
		/*
		let file = "nameOfFile.txt" // use .html instead of .txt to create html files
		let writingText = "some text"
		if let dir = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first {
			let path = dir.appending(file)
			//writing
			do {
				try writingText.write(toFile: path, atomically: false, encoding: String.Encoding.utf8)
			} catch {
				/* error handling here */
			}
			//reading
			do {
				let readingText = try NSString(contentsOfFile: path, encoding: String.Encoding.utf8.rawValue)
			}
			catch {
				/* error handling here */
			}
		}
		*/
	}
	
	// 파일 핸들을 사용한 작업 만 모아놓은 함수
	func fileHandle() {
		
		// FileHandle 객체 생성
		let filePath1 = FileManager.default.temporaryDirectory.appendingPathComponent("testfile1.txt")
		print("Tem Dir : \(filePath1)")
		let fileHandle: FileHandle? = FileHandle(forReadingAtPath: filePath1.path)
		
		if fileHandle == nil {
			print("File open failed")
		} else {
			// File Offset and Seeking
			/*
			print("[7] Offset = \(String(describing: file?.offsetInFile))")
			file?.seekToEndOfFile()
			print("[7] Offset = \(String(describing: file?.offsetInFile))")
			file?.seek(toFileOffset: 30)
			print("[7] Offset = \(String(describing: file?.offsetInFile))")
			*/
			
			// Writing Data to File
			// let dataString = "The quick brown fox jumped over the lazy dog"
			// fileHandle?.write(dataString.data(using: .utf8)!)
			
			if fileHandle != nil {
				// Read data from the file
				//let data = fileHandle?.readDataToEndOfFile()
				let data = fileHandle?.readData(ofLength: 27)
				
				// data to string conversion
				let text = String(data: data!, encoding: String.Encoding.utf8) as String!
				print(text ?? "")
				
				// Close the file
				// fileHandle?.closeFile()
			} else {
				print("Ooops! Something went wrong!!")
			}
		}
		
		if fileHandle != nil {
			
			// You can make the data
			let data = ("Some Text to write" as String).data(using: String.Encoding.utf8)
			
			// Write it to the file
			fileHandle?.seekToEndOfFile()
			fileHandle?.write(data!)
		}
		else {
			print("Ooops! Something went wrong!")
		}
		
		// Close the file
		fileHandle?.closeFile()
	}
}


























