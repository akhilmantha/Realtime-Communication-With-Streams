//
//  ChatRoom.swift
//  DogeChat
//
//  Created by akhil mantha on 27/01/18.
//  Copyright © 2018 Luke Parham. All rights reserved.
//

import UIKit

class ChatRoom: UIViewController {
    
    
    var inputStream :InputStream!
    var outputStream : OutputStream!
    
    var username  = ""
    
    let  maxReadLength = 4096
    
    
    func setupNetworkConnection(){
        var readStream : Unmanaged<CFReadStream>?
        var writeStream : Unmanaged<CFWriteStream>?
       CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, "localhost" as CFString, 80, &readStream, &writeStream)
        
        inputStream = readStream!.takeRetainedValue()
        outputStream = writeStream!.takeRetainedValue()
        
        inputStream.delegate = self
        
        inputStream.schedule(in: .current, forMode: .commonModes)
        outputStream.schedule(in: .current, forMode: .commonModes)
        
        inputStream.open()
        outputStream.open()
    }
    func joinChat(username : String){
        
        let data = "i am \(username)" .data(using: .ascii)!
        self.username  = username
        
        _ = data.withUnsafeBytes{ outputStream.write($0, maxLength: data.count)}
       
        
        
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
extension ChatRoom : StreamDelegate {
    func stream(_ aStream: Stream, handle eventCode: Stream.Event) {
        switch eventCode {
        case Stream.Event.hasBytesAvailable:
            print("new message recieved")
        case Stream.Event.endEncountered:
            print("new message reccieved ")
        case Stream.Event.errorOccurred:
            print("error occured")
        case Stream.Event.hasSpaceAvailable:
            print("space is available")
        default:
            print("some other event")
        break
        }
    }
    private func readAvailableBytes(stream: InputStream){
        
    }
}
