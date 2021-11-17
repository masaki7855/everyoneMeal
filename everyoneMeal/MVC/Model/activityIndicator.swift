//
//  activityIndicator.swift
//  everyoneMeal
//
//  Created by 細渕雅貴 on 2021/11/03.
//
import  UIKit

var ActivityIndicator = UIActivityIndicatorView()

func activityIndicator() {
    ActivityIndicator.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
    ActivityIndicator.color = UIColor.gray
    ActivityIndicator.hidesWhenStopped = true

}

