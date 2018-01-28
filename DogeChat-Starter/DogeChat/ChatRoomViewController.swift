
import UIKit

class ChatRoomViewController: UIViewController {
  let tableView = UITableView()
  let messageInputBar = MessageInputView()
  let chatRoom = ChatRoom()
  
  var messages = [Message]()
  
  var username = ""
  
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    chatRoom.setupNetworkConnection()
    chatRoom.joinChat(username: username)
  }
  
  override func viewWillDisappear(_ animated: Bool) {
    super.viewWillDisappear(animated)

  }
}

//MARK - Message Input Bar
extension ChatRoomViewController: MessageInputDelegate {
  func sendWasTapped(message: String) {
    
  }
}

