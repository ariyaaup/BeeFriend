import 'package:beefriend_app/DB/user_DB.dart';
import 'package:beefriend_app/DB_Helper/user_Data.dart';
import 'package:beefriend_app/Page/ChatListPage.dart';
// import 'package:beefriend_app/Page/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Chatpage extends StatefulWidget {
  final String Image;
  final String Name;
  final String Email;
  const Chatpage(
      {super.key,
      required this.Image,
      required this.Name,
      required this.Email});

  get receiverEmail => null;

  @override
  State<Chatpage> createState() => _ChatpageState();
}

class _ChatpageState extends State<Chatpage> {
  final TextEditingController _controllerChat = TextEditingController();
  final user = Supabase.instance.client.auth.currentUser;

  List<Map<String, dynamic>> chatMessages = [];
  final String currentUser = Supabase.instance.client.auth.currentUser!.email!;

  @override
  void initState() {
    super.initState();
    loadChat();
  }

  Future<void> loadChat() async {
    final data =
        await showData().showFullChat(user1: currentUser, user2: widget.Email);
    setState(() {
      chatMessages = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: MediaQuery.of(context).size.width > 500
          ? const Color(0xFFFFB8E0)
          : const Color(0xFFFFB8E0),
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: MediaQuery.of(context).size.width > 500
            ? const Color(0xFFEC7FA9)
            : const Color(0xFFEC7FA9),
        toolbarHeight: screenHeight * 0.1,
        leading: IconButton(
          onPressed: () {
            var navigator = Navigator.of(context);
            navigator.push(
              MaterialPageRoute(
                builder: (builder) {
                  return Chatlistpage();
                },
              ),
            );
          },
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              width: screenWidth * 0.1,
              alignment: Alignment.center,
              padding: EdgeInsets.only(left: 0.1),
              child: CircleAvatar(
                backgroundImage: NetworkImage(widget.Image),
              ),
            ),
            SizedBox(width: screenWidth * 0.025),
            Text(
              widget.Name,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontFamily: 'Poppins',
              ),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: chatMessages.isEmpty
            ? Center(child: Text("No messages yet."))
            : ListView.builder(
                reverse: true, // agar chat terbaru di bawah
                itemCount: chatMessages.length,
                itemBuilder: (context, index) {
                  final chat = chatMessages[chatMessages.length - 1 - index];
                  final isMe = chat['Sender'] == currentUser;

                  return Align(
                    alignment:
                        isMe ? Alignment.centerRight : Alignment.centerLeft,
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                      margin: EdgeInsets.symmetric(vertical: 4),
                      decoration: BoxDecoration(
                        color: isMe ? Colors.blue[300] : Colors.grey[300],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            chat['Content'] ?? '',
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(height: 4),
                          Text(
                            chat['CreatedAt'] ?? '',
                            style:
                                TextStyle(color: Colors.black54, fontSize: 10),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
      ),
      bottomNavigationBar: BottomAppBar(
        height: screenHeight * 0.15, // Sesuaikan tinggi BottomAppBar
        color: const Color(0xFFEC7FA9),
        child: Padding(
          padding: const EdgeInsets.only(left: 10, top: 10.0, bottom: 10),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 50,
                  child: TextField(
                    controller: _controllerChat,
                    style: const TextStyle(fontFamily: "Poppin"),
                    decoration: InputDecoration(
                      isDense: false,
                      enabledBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFF777777),
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: const BorderSide(
                          color: Color(0xFF333333),
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      fillColor: const Color(0xFFFFFFFF),
                      filled: true,
                      hintText: "Enter Your Message",
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 15.0,
                        horizontal: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(
                width: screenWidth * 0.05,
              ),
              IconButton(
                  onPressed: () {
                    userDatabase().chatContents(
                      userChat(
                          Email1: user!.email.toString(),
                          Email2: widget.Email,
                          chatContent: _controllerChat.text),
                    );
                    setState(() async {
                      _controllerChat.text = "".toString();
                      loadChat();
                    });
                  },
                  icon: Icon(
                    Icons.send,
                    color: Colors.white,
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
