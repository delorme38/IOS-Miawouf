//
//  PetModel.swift
//  miawouf
//
//  Created by Sébastien Delorme (Étudiant) on 2022-05-04.
//

import Foundation

struct Pet {

  enum Gender {
      case male, female
    }

  var name: String?
  var hasMajority: Bool
  var phone: String?
  var race: String?
  var gender: Gender
}
