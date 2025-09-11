//
//  UIColorTransformer.swift
//  ReminderClone
//
//  Created by Dhawal Mahajan on 01/09/25.
//

import UIKit
class UIColorTransformer: ValueTransformer {
    override func transformedValue(_ value: Any?) -> Any? {
        guard let color = value as? UIColor else {  return nil}
        do {
            let data = try NSKeyedArchiver.archivedData(withRootObject: color, requiringSecureCoding: true)
            return data
        } catch  {
            print(error)
            return nil
        }
        
    }
    override func reverseTransformedValue(_ value: Any?) -> Any? {
        guard let data = value as? Data else {  return nil}
        do {
            let data = try NSKeyedUnarchiver.unarchivedObject(ofClass: UIColor.self, from: data)
            return data
        } catch  {
            print(error)
            return nil
        }
    }
}
