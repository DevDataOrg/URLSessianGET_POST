//
//  Data.swift
//  URLSessianGET_POST
//
//  Created by Artyom Romanchuk on 06.01.2021.
//

//JSON view Emploers:
// http://dummy.restapiexample.com/api/v1/employees
//{"status": "success",
//  "data": [
//    {
//      "id": "1",
//      "employee_name": "Tiger Nixon",
//      "employee_salary": "320800",
//      "employee_age": "61",
//      "profile_image": ""
//    },
//    {
//      "id": "2",
//      "employee_name": "Garrett Winters",
//      "employee_salary": "170750",
//      "employee_age": "63",
//      "profile_image": ""
//    },

//JSON view  POSTS:
// https://jsonplaceholder.typicode.com/posts

//[
//  {
//    "userId": 1,
//    "id": 1,
//    "title": "sunt aut facere repellat provident occaecati excepturi optio reprehenderit",
//    "body": "quia et suscipit\nsuscipit recusandae consequuntur expedita et cum\nreprehenderit molestiae ut ut quas totam\nnostrum rerum est autem sunt rem eveniet architecto"
//  },
//  {
//    "userId": 1,
//    "id": 2,
//    "title": "qui est esse",
//    "body": "est rerum tempore vitae\nsequi sint nihil reprehenderit dolor beatae ea dolores neque\nfugiat blanditiis voluptate porro vel nihil molestiae ut reiciendis\nqui aperiam non debitis possimus qui neque nisi nulla"
//  },

import Foundation
import SwiftUI

struct User: Codable {
    var id: Int?
    var title: String?
    var body: String?
}

struct Employee: Codable {
    var status: String
    var data: [EmpData]
}

struct EmpData: Codable, Identifiable {
    var id = UUID()
    var userId: String?
    var name: String?
    var salary: String?
    var age: String?
    
    enum CodingKeys: String, CodingKey {
        case userId = "id"
        case name = "employee_name"
        case salary = "employee_salary"
        case age = "employee_age"
    }
}

class Api{
    func getAllEmployee(completion: @escaping ([EmpData]) -> ()) {
        guard let url = URL(string: "http://dummy.restapiexample.com/api/v1/employees") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, respinse, error) in
            guard let empData = data else { return }
            do {
                let employee = try JSONDecoder().decode(Employee.self, from: empData)
                DispatchQueue.main.async {
                    completion(employee.data)
                }
            }
            catch {
                print(error)
            }
        }.resume()
    }
    
    func addEmployee(completion: @escaping (User) -> ()) {
        let param: [String: Any] =
            [
                "id": 101,
                "title": "foo",
                "body": "bar"
            ]
        let body = try? JSONSerialization.data(withJSONObject: param)
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpBody = body
        request.httpMethod = "POST"
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-type")
        
        URLSession.shared.dataTask(with: request) { data, request, error in
            guard let empData = data else { return }
            do {
                let employee = try JSONDecoder().decode(User.self, from: empData)
                DispatchQueue.main.async {
                    completion(employee)
                }
            }
            catch {
                print(error)
            }
        }.resume()
    }
    
    func updateEmployee(completion: @escaping (User) -> ()) {
        let param: [String: Any] =
            [
                "id": 2,
                "title": "foo",
                "body": "bar"
            ]
        let body = try? JSONSerialization.data(withJSONObject: param)
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(String(describing: param["id"]!))") else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpBody = body
        request.httpMethod = "PUT"
        request.setValue("application/json; charset=UTF-8", forHTTPHeaderField: "Content-type")
        
        URLSession.shared.dataTask(with: request) { data, request, error in
            guard let empData = data else { return }
            do {
                let employee = try JSONDecoder().decode(User.self, from: empData)
                DispatchQueue.main.async {
                    completion(employee)
                }
            }
            catch {
                print(error)
            }
        }.resume()
    }
    
    func getSingleUser(param: String, completion: @escaping (User) -> ()) {
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts/\(param)") else {
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, respinse, error) in
            guard let empData = data else { return }
            do {
                let employee = try JSONDecoder().decode(User.self, from: empData)
                DispatchQueue.main.async {
                    completion(employee)
                }
            }
            catch {
                print(error)
            }
        }.resume()
    }
}
