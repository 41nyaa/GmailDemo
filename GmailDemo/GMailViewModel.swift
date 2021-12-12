//
//  GmailManager.swift
//  GmailDemo
//
//  Created by 41nyaa on 2021/10/25.
//

import Foundation
import SwiftUI

struct Label: Codable, Identifiable {
    enum MessageListVisibility: String, Codable {
        case show = "show"
        case hide = "hide"
    }
    enum LabelListVisibility: String, Codable {
        case labelShow = "labelShow"
        case labelShowIfUnread = "labelShowIfUnread"
        case labelHide = "labelHide"
    }

    struct Color: Codable {
        var textColor: String
        var backgroundColor: String
    }

    var id: String
    var name: String
    var messageListVisibility: MessageListVisibility?
    var labelListVisibility: LabelListVisibility?
    var messagesTotal: Int?
    var messagesUnread: Int?
    var threadsTotal: Int?
    var threadsUnread: Int?
    var color: Color?
    var type: String
}

struct Labels: Codable {
    var labels: [Label]
}

struct Header: Codable {
    var name: String
    var value: String
}

struct MessagePartBody: Codable {
  var attachmentId: String?
  var size: Int
  var data: String?
}

struct MessagePart: Codable {
    var partId: String
    var mimeType: String
    var filename: String
    var headers: [Header]
    var body: MessagePartBody
    var parts: [MessagePart]?
}

struct Message: Codable, Identifiable {
    var id: String
    var threadId: String
    var labelIds: [String]?
    var snippet: String?
    var historyId: String?
    var internalDate: String?
    var payload: MessagePart?
    var sizeEstimate: Int?
    var raw: String?
}

struct Thread: Codable, Identifiable {
    var id: String
    var snippet: String
    var historyId: String
    var messages: [Message]?
}

struct ThreadList: Codable {
    var threads: [Thread]
    var nextPageToken: String
    var resultSizeEstimate: Int
}

class GMailViewModel: ObservableObject {
    @Published var labels: Labels = Labels(labels: [])
    var labelId: String = ""
    @Published var threads: ThreadList = ThreadList(threads: [], nextPageToken: "", resultSizeEstimate: 0)
    var id: String = ""
    @Published var data: String = ""
    var message: Message = Message(id: "", threadId: "", labelIds: nil, snippet: nil, historyId: nil, internalDate: nil, sizeEstimate: nil, raw: nil)
    
    func getLabel(userID: String, token: String) {
        let url = URL(string: "https://gmail.googleapis.com/gmail/v1/users/\(userID)/labels")!
        var request = URLRequest(url: url)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        getData(request: request, updateHandler: self.updateLabels)
    }
    
    func getThreads(userID: String, token: String) {
        var url = URLComponents(string: "https://gmail.googleapis.com/gmail/v1/users/\(userID)/threads")!
        url.queryItems = [
            URLQueryItem(name: "labelIds", value: self.labelId),
        ]

        var request = URLRequest(url: url.url!)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        getData(request: request, updateHandler: self.updateThreads)
    }
    
    func getMessage(userID: String, token: String) {
        let url = URLComponents(string: "https://gmail.googleapis.com/gmail/v1/users/\(userID)/messages/\(id)")!

        var request = URLRequest(url: url.url!)
        request.addValue("Bearer \(token)", forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")

        getData(request: request, updateHandler: self.updateMessage)
    }
    
    func getData(request: URLRequest, updateHandler: @escaping (Data) -> Void) {
        
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                updateHandler(data)
            }
        }
        task.resume()
    }
    
    func updateLabels(data: Data) {
        do {
            self.labels = try JSONDecoder().decode(Labels.self, from: data)
        } catch {
            print(String(describing: error))
        }
    }
    
    func updateThreads(data: Data) {
        do {
            self.threads = try JSONDecoder().decode(ThreadList.self, from: data)
        } catch {
            print(String(describing: error))
        }
    }
    
    func updateMessage(data: Data) {
        do {
            self.message = try JSONDecoder().decode(Message.self, from: data)
            
            let base64Data = self.message.payload!.parts![0].body.data!
                .replacingOccurrences(of: "-", with: "+")
                .replacingOccurrences(of: "_", with: "/")
            
            guard let restoreData = Data(base64Encoded: base64Data) else {
                print("decode error")
                return
            }

            self.data = String(data: restoreData, encoding: .utf8)!
        } catch {
            print(String(describing: error))
        }
    }
}
