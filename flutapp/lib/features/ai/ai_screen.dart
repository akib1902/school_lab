import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../core/state/app_state.dart';

class AiScreen extends StatefulWidget {
  const AiScreen({super.key});

  @override
  State<AiScreen> createState() => _AiScreenState();
}

class _AiScreenState extends State<AiScreen> {
  final TextEditingController controller = TextEditingController();
  final List<Map<String, String>> messages = [];

  void sendMessage() {
    final appState = context.read<AppState>();
    final course = appState.selectedCourse;

    final text = controller.text.trim();
    if (text.isEmpty) return;

    String contextInfo = course != null
        ? "Course: ${course['title']}"
        : "General";

    setState(() {
      messages.add({"role": "user", "text": text});
      messages.add({
        "role": "ai",
        "text": "[$contextInfo]\nAI response for: $text"
      });
    });

    controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 40),

          const Text(
            "AI Assistant",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),

          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(12),
              children: messages.map((msg) {
                return Align(
                  alignment: msg['role'] == "user"
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 6),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: msg['role'] == "user"
                          ? Colors.blue
                          : Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(msg['text']!),
                  ),
                );
              }).toList(),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: controller,
                    decoration:
                        const InputDecoration(hintText: "Ask something..."),
                  ),
                ),
                IconButton(
                  onPressed: sendMessage,
                  icon: const Icon(Icons.send),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}