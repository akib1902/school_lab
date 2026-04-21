import 'package:flutter/material.dart';
import '../../services/supabase_service.dart';
import 'content_viewer_screen.dart';

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
                      future: Future.wait([
                        service.getVideos(topic['id']),
                        service.getSlides(topic['id']),  //manual 001
                      ]),
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return const SizedBox();

                        final videos = snapshot.data![0] as List;
                        final slides = snapshot.data![1] as List;

                        return Column(
                          children: [
                            ...videos.map((video) {
                              return ListTile(
                                title: Text(video['title']),
                                leading: const Icon(Icons.video_library),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ContentViewerScreen(
                                        title: video['title'],
                                        url: video['youtube_url'],
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList(),

                            ...slides.map((slide) {
                              return ListTile(
                                title: Text(slide['title']),
                                leading: const Icon(Icons.slideshow),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => ContentViewerScreen(
                                        title: slide['title'],
                                        url: slide['content_url'], // could be PDF or PPT link
                                      ),
                                    ),
                                  );
                                },
                              );
                            }).toList(),
                          ],
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