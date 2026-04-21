import 'package:flutapp/features/course/content_viewer_screen.dart';
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
  List<Map<String, dynamic>> tools = [];  // ✅ STEP 1 (HERE)
  bool loading = true;
  final service = SupabaseService();

  @override
  void initState() {
    super.initState();
    loadResources();
  }

  Future<void> loadResources() async {
    final appState = context.read<AppState>();

    List<Map<String, dynamic>> data = [];

    if (appState.selectedCourse != null) {
      data = await service.getStudyTools(
        courseId: appState.selectedCourse!['id'],
      );
    } else {
      data = await service.getAllResources();
    }

    setState(() {
      tools = List<Map<String, dynamic>>.from(data);
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
                  final Map<String, dynamic> t = Map<String, dynamic>.from(tool);

                  final String title = t['title']?.toString() ?? 'No Title';
                  final String? url = t['content_url']?.toString();

                  return Card(
                    child: ListTile(
                      title: Text(title),
                      subtitle: Text(t['type']?.toString() ?? ''),
                      onTap: () {
                        if (url != null && url.isNotEmpty) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => ContentViewerScreen(
                                title: title,
                                url: url,
                              ),
                            ),
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text("No valid link available")),
                          );
                        }
                      },
                    ),
                  );
                }).toList(),
              ],
            ),
    );
  }
}