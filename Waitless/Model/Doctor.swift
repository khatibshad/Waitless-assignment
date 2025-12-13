//
//  Doctor.swift
//  Waitless
//
//  Created by Shayan Khatibshad on 2025-12-13.
//

import Foundation

struct Doctor: Identifiable {
    let id = UUID()
    let name: String
    let specialty: String
    let rating: Double
    let time: String
    let hospital: String
    let imageName: String
    
}

extension Doctor {
    static let doctors: [Doctor] = [
        .init(
            name: "Dr. Dennis Ko",
            specialty: "Cardiologist",
            rating: 4.8,
            time: "09:00 a.m–13:30 p.m",
            hospital: "Sunnybrook Hospital",
            imageName: "dr-1"
        ),
        .init(
            name: "Dr. Lori Shapiro",
            specialty: "Dermatologist",
            rating: 4.8,
            time: "09:00 a.m–13:30 p.m",
            hospital: "Sunnybrook Hospital",
            imageName: "dr-2"
        ),
        .init(
            name: "Dr. Lori Shapiro",
            specialty: "Dermatologist",
            rating: 4.8,
            time: "09:00 a.m–13:30 p.m",
            hospital: "Sunnybrook Hospital",
            imageName: "dr-1"
        ),
        .init(
            name: "Dr. Lori Shapiro",
            specialty: "Dermatologist",
            rating: 4.8,
            time: "09:00 a.m–13:30 p.m",
            hospital: "Sunnybrook Hospital",
            imageName: "dr-2"
        ),
        .init(
            name: "Dr. Lori Shapiro",
            specialty: "Dermatologist",
            rating: 4.8,
            time: "09:00 a.m–13:30 p.m",
            hospital: "Sunnybrook Hospital",
            imageName: "dr-1"
        ),
        .init(
            name: "Dr. Lori Shapiro",
            specialty: "Dermatologist",
            rating: 4.8,
            time: "09:00 a.m–13:30 p.m",
            hospital: "Sunnybrook Hospital",
            imageName: "dr-2"
        ),
        .init(
            name: "Dr. Lori Shapiro",
            specialty: "Dermatologist",
            rating: 4.8,
            time: "09:00 a.m–13:30 p.m",
            hospital: "Sunnybrook Hospital",
            imageName: "dr-1"
        )
    ]

}
