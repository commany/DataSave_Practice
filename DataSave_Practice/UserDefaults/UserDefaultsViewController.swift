//
//  UserDefaultsViewController.swift
//  DataSave_Practice
//
//  Created by commany_mac on 2017. 11. 13..
//  Copyright © 2017년 CommanyShin. All rights reserved.
//

import UIKit

class UserDefaultsViewController: UIViewController {

	@IBOutlet weak var profileImageView: UIImageView!
	
	override func viewWillAppear(_ animated: Bool) {
		guard UserDefaults.standard.object(forKey: "profileImage") != nil else {
			// 이미지 저장
			let profileImage = UIImage(named: "monster.jpeg")
			let jpgImage = UIImageJPEGRepresentation(profileImage!, 0.5)
			
			UserDefaults.standard.set(jpgImage, forKey: "profileImage")
			
			print("저장")
			return
		}
	}
	
	// 프로필 사진틀에 이미지 사진 넣기
	func profileImage() {
		print("진행")
		
		// 이미지 꺼내기
		let imageData = UserDefaults.standard.object(forKey: "profileImage") as? Data
		if let image = UIImage(data: imageData!) {
			self.profileImageView.image = image
			UserDefaults.standard.removeObject(forKey: "profileImage")
		}
	}
	
	override func viewDidLoad() {
        super.viewDidLoad()

		// 프로필 틀 원형으로 변경
		self.profileImageView.layer.cornerRadius = self.profileImageView.bounds.width / 2
		self.profileImageView.layer.masksToBounds = true
		
		profileImage()
		
		
        // UserDefault 인스턴스 생성
		// let userDefaults = UserDefaults.standard
		
		/*
		// Data Save
		UserDefaults.standard.set(true, forKey: "boolKeyName")
		UserDefaults.standard.set(1, forKey: "integerKeyName")
		
		
		// Data Read
		UserDefaults.standard.bool(forKey: "boolKeyName")
		UserDefaults.standard.integer(forKey: "integerKeyName")
		
		
		UserDefaults.standard.set("macker", forKey: "userID")
		let aUser:String = UserDefaults.standard.object(forKey: "userID") as! String
		var sUser:String = UserDefaults.standard.string(forKey: "userID")!
		print("aUser : \(aUser)")
		print("sUser : \(sUser)")
		
		
		UserDefaults.standard.set("commany", forKey: "userID")
		sUser = UserDefaults.standard.string(forKey: "userID")!
		print("sUser : \(sUser)")
		
		// Data Remove
		UserDefaults.standard.removeObject(forKey: "userID")
		//sUser = UserDefaults.standard.string(forKey: "userID")!
		//print("sUser : \(sUser)")
		
		let defaults = UserDefaults.standard
		defaults.set(25, forKey: "Age")
		defaults.set(true, forKey: "UseTouchID")
		defaults.set(CGFloat.pi, forKey: "Pi")
		
		defaults.set("Paul Hudson", forKey: "Name")
		defaults.set(Date(), forKey: "LastRun")
		
		let array = ["Hello", "World"]
		defaults.set(array, forKey: "SavedArray")
		
		let dict = ["Name": "Paul", "Country": "UK"]
		defaults.set(dict, forKey: "SavedDict")
		
		if UserDefaults.standard.object(forKey: "Age") != nil {
			let age = defaults.integer(forKey: "Age")
			print("age : \(age)")
		}
		
		let useTouchID = defaults.bool(forKey: "UseTouchID")
		let pi = defaults.double(forKey: "Pi")
		
		let savedArray = defaults.object(forKey: "SavedArray") as? [String] ?? [String]()
		
		// 전체 데이터 삭제
		
		/*
		// User Defaults Data 조회
		for (key, value) in UserDefaults.standard.dictionaryRepresentation() {
			print("** \(key) = \(value) \n")
		}

		// dump를 이용해서 데이터 출력
		// dump(UserDefaults.standard.dictionaryRepresentation())

		
		print(Array(UserDefaults.standard.dictionaryRepresentation().keys))
		print(Array(UserDefaults.standard.dictionaryRepresentation().values))
		*/
		
		// 전화번호
		let tel = "010-1111-1111"
		// 저장
		UserDefaults.standard.set(tel, forKey: Constants.telKey)
		// 읽기
		UserDefaults.standard.string(forKey: Constants.telKey)
		
		
		/*
		// 전화번호
		let tel = "010-1111-1111"
		// 저장
		UserDefaults.standard.set(tel, forKey: Constants.User.tel.rawValue)
		// 읽기
		UserDefaults.standard.string(forKey: Constants.User.tel.rawValue)
		*/
		*/
    }
}















protocol KeyNamespaceable {
	func namespaced<T : RawRepresentable>(_ key: T) -> String
}

extension KeyNamespaceable {
	func namespaced<T: RawRepresentable>(_ key: T) -> String {
		return "\(Self.self).\(key.rawValue)"
	}
}

protocol StringDefaultSettable : KeyNamespaceable {
	associatedtype StringKey : RawRepresentable
}

extension StringDefaultSettable where StringKey.RawValue == String {
	func set(_ value: String, forKey key: StringKey) {
		let key = namespaced(key)
		UserDefaults.standard.set(value, forKey: key)
	}
	
	@discardableResult
	func string(forKey key: StringKey) -> String? {
		let key = namespaced(key)
		return UserDefaults.standard.string(forKey: key)
	}
}

extension UserDefaults : StringDefaultSettable {
	enum StringKey : String {
		case tel
	}
}

struct User {
	let name: String
	let tel: String
}

extension User: StringDefaultSettable {
	enum StringKey: String {
		case name
		case tel
	}
}


struct Constants {
	static let telKey = "tel"
	
	enum User: String {
		case tel
	}
}
