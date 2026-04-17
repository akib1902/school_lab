import 'package:flutter/material.dart';
import '../../services/supabase_service.dart';

class CourseDetailScreen extends StatefulWidget {
  final String courseId;
  final String title;

  const CourseDetailScreen({
    super.key,
    required this.courseId,
    required this.title,
  });

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  final service = SupabaseService();
  List topics = [];
  bool loading = true;

  @override
  void initState() {
    super.initState();
    loadTopics();
  }

  Future<void> loadTopics() async {
    final data = await service.getTopics(widget.courseId);
    setState(() {
      topics = data;
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: loading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(16),
              children: topics.map((topic) {
                return ExpansionTile(
                  title: Text(topic['title']),
                  children: [
                    FutureBuilder(
                      future: service.getSlides(topic['id']),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Padding(
                            padding: EdgeInsets.all(8),
                            child: CircularProgressIndicator(),
                          );
                        }

                        final slides = snapshot.data as List;

                        return Column(
                          children: slides.map((slide) {
                            return ListTile(
                              title: Text(slide['title']),
                              trailing: const Icon(Icons.open_in_new),
                            );
                          }).toList(),
                        );
                      },
                    )
                  ],
                );
              }).toList(),
            ),
    );
  }
}