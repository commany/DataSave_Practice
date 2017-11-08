//
//  UserInfo.swift
//  DataSave_Practice
//
//  Created by commany_mac on 2017. 10. 28..
//  Copyright © 2017년 CommanyShin. All rights reserved.
//

import Foundation

class UserInfo: NSObject, NSCoding {
	var name: String
	var address: String
	var phone: Int64
	
	init(name: String, address: String, phone: Int64) {
		self.name = name
		self.address = address
		self.phone = phone
	}
	
	func encode(with aCoder: NSCoder) {
		aCoder.encode(self.name, forKey: "name")
		aCoder.encode(self.address, forKey: "address")
		aCoder.encode(self.phone, forKey: "phone")
	}
	
	required init?(coder aDecoder: NSCoder) {
		self.name = aDecoder.decodeObject(forKey: "name") as! String
		self.address = aDecoder.decodeObject(forKey: "address") as! String
		self.phone = aDecoder.decodeInt64(forKey: "phone")
	}
}
