import 'package:flutter/material.dart';
import '../../services/supabase_service.dart';
import '../course/course_detail_screen.dart';
import 'package:provider/provider.dart';
import '../../core/state/app_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final service = SupabaseService();
  List courses = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadCourses();
  }

  Future<void> loadCourses() async {
    final data = await service.getCourses();
    setState(() {
      courses = data;
      loading = false;
    });
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
                  "Your Courses",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 16),

                ...courses.map((course) {
                  return Card(
                    child: ListTile(
                      title: Text(course['title']),
                      subtitle: Text(course['course_code']),
                      trailing: const Icon(Icons.arrow_forward),
                      onTap: () {
                        context.read<AppState>().setCourse(course);

                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => CourseDetailScreen(
                              courseId: course['id'],
                              title: course['title'],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                }).toList()
              ],
            ),
    );
  }
}