

import 'package:fahad_tutor/model/chatmessage.dart';
import 'package:fahad_tutor/repo/tutor_repo.dart';
import 'package:flutter/material.dart';

class Chats extends StatefulWidget {
  final String meetingId;
  final String userId;
  final String user_type;
  const Chats({super.key,
  required this.meetingId,
    required this.userId,
    required this.user_type});

  @override
  State<Chats> createState() => _ChatsState();
}

class _ChatsState extends State<Chats> {
   final TutorRepository _repository = TutorRepository();
  final TextEditingController _controller = TextEditingController();

  late Future<List<ChatMessage>> _chatFuture;

  @override
  void initState() {
    super.initState();
    _chatFuture = _repository.fetchChat(
      meetingId: widget.meetingId,
      userId: widget.userId,
      user_type: widget.user_type,
    );
  }

  void _refreshChat() {
    setState(() {
      _chatFuture = _repository.fetchChat(
        meetingId: widget.meetingId,
        userId: widget.userId,
        user_type: widget.user_type
      );
    });
  }

  void _sendMessage() async {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      await _repository.sendMessage(
        meetingId: widget.meetingId,
        userId: widget.userId,
        message: text,
        user_type: widget.user_type,
      );
      _controller.clear();
      _refreshChat();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Chat")),
      body: Column(
        children: [
          Expanded(
  child: FutureBuilder<List<ChatMessage>>(
    future: _chatFuture,
    builder: (context, snapshot) {
      if (snapshot.connectionState == ConnectionState.waiting) {
        return const Center(child: CircularProgressIndicator());
      } else if (snapshot.hasError) {
        return Center(child: Text("Error: ${snapshot.error}"));
      } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
        return const Center(child: Text("No messages yet"));
      }

      final messages = snapshot.data!;
      // messages.sort((a, b) => b.message.compareTo(a.datetime),);
      // ✅ Sort ascending by id (smallest → largest)
      messages.sort((a, b) => int.parse(a.id).compareTo(int.parse(b.id)));
      return ListView.builder(
        reverse: false,
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final msg = messages[index];
          return Align(
            alignment: msg.isOwn ? Alignment.centerRight : Alignment.centerLeft,
            child: Container(
              margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: msg.isOwn ? Colors.blue : Colors.grey.shade300,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                msg.message,
                style: TextStyle(color: msg.isOwn ? Colors.white : Colors.black),
              ),
            ),
          );
        },
      );
    },
  ),
),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: const InputDecoration(
                      hintText: "Type a message...",
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: _sendMessage,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}