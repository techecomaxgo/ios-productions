//
//  RoomsGuestStru.swift
//  MaxPay
//
//  Created by Admin on 05/06/24.
//

import Foundation


// Define a struct for the Child details
struct Child {
    var numberOfChild: Int
    var childAge: [String]
}

// Define a struct for RoomDetails
struct RoomDetails {
    var numberOfAdults: Int
    var child: Child
}
