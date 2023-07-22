//
//  CStructRepresentable.swift
//  
//
//  Created by Eric Canton on 7/22/23.
//

import Foundation

protocol CStructRepresentable {
  associatedtype CStruct_Type
  
  func toC() -> CStruct_Type
  func fromC(_ cStruct: CStruct_Type) -> Self
}
