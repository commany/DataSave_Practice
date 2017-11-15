//
//  ArchivingViewController.swift
//  DataSave_Practice
//
//  Created by commany_mac on 2017. 11. 12..
//  Copyright © 2017년 CommanyShin. All rights reserved.
//

import UIKit

class ArchivingViewController: UIViewController {

	var dataFilePath: String?

	@IBOutlet weak var name: UITextField!
	@IBOutlet weak var address: UITextField!
	@IBOutlet weak var phone: UITextField!
	
	@IBOutlet weak var saveButton: UIButton!
	
	@IBAction func saveData(_ sender: Any) {
		// 호출시 새로운 배열을 만들고 텍스트 필드의 내용을 배열의 각 항목에 할당한다.
		// 그리고 배열 객체는 NSKeyedArchiver 클래스의 archiveRootObject 메서드에 의해
		// 미리 정의된 데이터 파일로 아카이브된다.
		// 배열 객체의 인스턴스 데이터들은 아카이브로 저장되었고,
		// 애플리케이션이 다음에 실행될때 로드될수 있는 상태가 된다.
		let contactData = [name.text!, address.text!, phone.text!]
		NSKeyedArchiver.archiveRootObject(contactData, toFile: self.dataFilePath!)
		
		print("[3] Archiving 저장이 완료되었습니다.")
		
		// 애플리케이션이 실행될때 이전 실행에서 저장한 아카이브 데이터 파일이 있는지 체크할 필요가 있다.
		// 파일이 존재하면 이 애플리케이션은 생성되었던 아카이브에서 원래의 배열 객체를 재생성하기 위하여 그 내용을 읽어야 한다.
		// 그런 다음 재생성된 배열 객체에서 데이터를 추출하여 이름, 주소, 전화번호 텍스트 필드에 표시한다.
		
		// 파일 매니저 객체가 파일의 존재 여부 체크
		if FileManager.default.fileExists(atPath: self.dataFilePath!) {
			// 파일 존재
			print("[2] 파일이 존재합니다!")
			
			// 파일이 존재할 경우 아카이브 데이터 파일의 경로를 가지고 파일 매니저 객체는 파일이 존재하는지를 확인한다.
			// 파일이 존재하면 NSKeyedUnarchiver 클래스의 unarchiveObjectWithFile 메서드를 통해 파일은 언아카이브되어 새로운 배열 객체를 만든다.
			let dataArray = NSKeyedUnarchiver.unarchiveObject(withFile: self.dataFilePath!) as! [String]
			self.name.text = dataArray[0]
			self.address.text = dataArray[1]
			self.phone.text = dataArray[2]
			
			print("[2] 파일 데이터 추출 성공 => (a) name : \(dataArray[0]) | (b) address : \(dataArray[1]) | (c) phone : \(dataArray[2])")
		} else {
			// 파일 존재 안함
			print("[2] 파일이 존재하지 않습니다!")
		}
	}
	
	
    override func viewDidLoad() {
        super.viewDidLoad()

		let fileManager = FileManager.default

		// 애플리케이션의 Document 디렉토리 경로를 추출, 이 경로와 아카이브 데이터 파일 이름을 가지고 전체 경로를 만든후 dataFilePath를 생성
		let dirPaths = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)
		let docsDir = dirPaths[0]
		self.dataFilePath = docsDir.appending("/data.archive")
		print("[1] DataFilePath => \(self.dataFilePath!)")

		guard fileManager.fileExists(atPath: self.dataFilePath!) else {
			// 파일 생성
			if fileManager.createFile(atPath: self.dataFilePath!, contents: nil, attributes: nil) {
				print("[2] data.archive 파일 생성 완료!!")
			} else {
				print("[2] data.archive 파일 생성 실패!!")
			}
			
			return
		}
    }
}
