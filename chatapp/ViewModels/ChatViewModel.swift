//
//  ChatViewModel.swift
//  chatapp
//
//  Created by tobioka on 2023/12/22.
//

import Foundation

class ChatViewModel: ObservableObject {
    
    @Published var chatData: [Chat] = []
    
    init(){
        chatData = fetchChatData()
       
       
    }
    
    private func fetchChatData() -> [Chat] {
        let fileName = "chatData.json"
        let data: Data
        
         guard let filePath = Bundle.main.url(forResource:fileName,withExtension:nil)
        else{
             fatalError("\(fileName)が見つかりません．")
         }
        
        do {
            data = try Data(contentsOf: filePath)
        } catch {
            fatalError("\(fileName)のロードに失敗しました")
        }
        
        do {
            return try JSONDecoder().decode([Chat].self,from:data)
        }catch {
            fatalError("\(fileName)を\(Chat.self)に変換することに失敗しました．")
        }
        
       
    }
    
    func addMessage(chatId: String, text:String){
        
        guard let index = chatData.firstIndex(where: {
            chat in
                chat.id == chatId
        })else { return }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:m:ss"
        let formattedDateString = formatter.string(from: Date())
        
        
        let newMessage = Message(
            id: UUID().uuidString,
            text: text,
            user: User.currentUser,
            date: formattedDateString,
            readed:false
        )
        
        chatData[index].messages.append(newMessage)
    }
    
    func getTitle(messages:[Message]) -> String {
        var title = ""
        
         let names = getMembers(messages: messages, type: .name)
        for name in names {
            title += title.isEmpty ? "\(name)": ", \(name)"
        }
        
        return title
    }
    
    func getImages(messages:[Message]) -> [String] {
        getMembers(messages: messages, type: .image)
        
    }
    
    private func getMembers(messages:[Message],type:ValueType) -> [String]{
        var members: [String] = []
        var userIds:[String] = []
        
        for message in messages {
            let id = message.user.id
            
            if id == User.currentUser.id { continue }
            if userIds.contains(id) { continue }
            
            userIds.append(id)
            
            switch type{
                
            case .name:
                members.append(message.user.name)
            case .image:
                members.append(message.user.image)
            }
        }
        
        return members
    }
        
}

enum ValueType {
    case name
    case image
}
