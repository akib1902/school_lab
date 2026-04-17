import 'package:flutter/material.dart';
import '../../services/supabase_service.dart';
import 'package:provider/provider.dart';
import '../../core/state/app_state.dart';

class ResourcesScreen extends StatefulWidget {
  const ResourcesScreen({super.key});

  @override
  State<ResourcesScreen> createState() => _ResourcesScreenState();
}

class _ResourcesScreenState extends State<ResourcesScreen> {
  final service = SupabaseService();
  List tools = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadResources();
  }

  Future<void> loadResources() async {
    final appState = context.read<AppState>();

    List data;

    if (appState.selectedCourse != null) {
      data = await service.getStudyTools(
        courseId: appState.selectedCourse!['id'],
      );
    } else {
      data = await service.getAllResources(); // ✅ now valid
    }

    setState(() {
      tools = data;
      loading = false;
    });
  }

  IconData getIcon(String type) {
    switch (type) {
      case 'syllabus':
        return Icons.school;
      case 'previous_questions':
        return Icons.question_answer;
      case 'exam_note':
        return Icons.note;
      default:
        return Icons.insert_drive_file;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: [
                const Text(
                  "Study Resources",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                ...tools.map((tool) {
                  return Card(
                    child: ListTile(
                      leading: Icon(getIcon(tool['type'])),
                      title: Text(tool['title']),
                      subtitle: Text(tool['type']),
                    ),
                  );
                }).toList()
              ],
            ),
    );
  }
}