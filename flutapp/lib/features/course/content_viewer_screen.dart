import 'dart:io';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

class ContentViewerScreen extends StatefulWidget {
  final String title;
  final String url;
  // Optional: Pass the explicit type if you know it from Supabase ('pdf', 'slide', 'youtube')
  final String? fileType; 

  const ContentViewerScreen({
    super.key,
    required this.title,
    required this.url,
    this.fileType,
  });

  @override
  State<ContentViewerScreen> createState() => _ContentViewerScreenState();
}

class _ContentViewerScreenState extends State<ContentViewerScreen> {
  WebViewController? controller;
  
  bool isYoutube = false;
  bool isPdf = false;
  bool isSlide = false;
  
  // PDF Download States
  String? localPdfPath;
  bool isDownloading = false;
  String downloadError = '';

  @override
  void initState() {
    super.initState();
    _initializeContent();
  }

  void _initializeContent() {
    final urlLower = widget.url.toLowerCase();
    final titleLower = widget.title.toLowerCase();

    // 1. Determine Content Type
    isYoutube = urlLower.contains("youtube.com") || urlLower.contains("youtu.be");
    
    // Guess type based on explicit parameter, extension, or title
    isPdf = widget.fileType == 'pdf' || urlLower.endsWith('.pdf') || titleLower.contains('pdf');
    isSlide = widget.fileType == 'slide' || urlLower.endsWith('.ppt') || urlLower.endsWith('.pptx') || titleLower.contains('slide');

    // 2. Route to correct handler
    if (isYoutube) {
      // Handled in build()
    } else if (isPdf) {
      _downloadAndSavePdf();
    } else {
      // It's a Slide or generic web link. Initialize WebView.
      String webUrl = widget.url;

      // PRO TIP: If it's a Google Drive link, changing "/view" to "/preview" 
      // forces an embedded UI perfect for WebViews (Works for Slides and PDFs!)
      if (webUrl.contains('drive.google.com') && webUrl.contains('/view')) {
        webUrl = webUrl.replaceFirst('/view', '/preview');
      } else if (isSlide && !webUrl.contains('drive.google.com')) {
        // Fallback for standard PPT URLs using Google Docs Viewer
        webUrl = 'https://docs.google.com/viewer?url=$webUrl&embedded=true';
      }

      controller = WebViewController()
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..loadRequest(Uri.parse(webUrl));
    }
  }

  Future<void> _downloadAndSavePdf() async {
    setState(() {
      isDownloading = true;
    });

    try {
      String downloadUrl = widget.url;

      // If it's a Google Drive URL, convert it to a direct download API link
      if (downloadUrl.contains('drive.google.com')) {
        final RegExp regExp = RegExp(r'/file/d/([a-zA-Z0-9_-]+)');
        final match = regExp.firstMatch(downloadUrl);
        if (match != null && match.groupCount >= 1) {
          final fileId = match.group(1);
          downloadUrl = 'https://drive.google.com/uc?export=download&id=$fileId';
        }
      }

      final response = await http.get(Uri.parse(downloadUrl));
      
      if (response.statusCode == 200) {
        final bytes = response.bodyBytes;
        final dir = await getTemporaryDirectory();
        
        // Create a unique filename so we don't overwrite files constantly
        final fileName = 'temp_pdf_${DateTime.now().millisecondsSinceEpoch}.pdf';
        final file = File('${dir.path}/$fileName');
        
        await file.writeAsBytes(bytes);

        setState(() {
          localPdfPath = file.path;
          isDownloading = false;
        });
      } else {
        throw Exception('Failed to download PDF. Status: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        downloadError = 'Failed to load PDF: $e';
        isDownloading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (isYoutube) {
      final videoId = YoutubePlayer.convertUrlToId(widget.url);
      return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: videoId != null 
          ? YoutubePlayer(
              controller: YoutubePlayerController(
                initialVideoId: videoId,
                flags: const YoutubePlayerFlags(autoPlay: false),
              ),
            )
          : const Center(child: Text("Invalid YouTube URL")),
      );
    }

    if (isPdf) {
      return Scaffold(
        appBar: AppBar(title: Text(widget.title)),
        body: _buildPdfBody(),
      );
    }

    // Fallback: Webview for Slides and Generic URLs
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: controller != null 
          ? WebViewWidget(controller: controller!)
          : const Center(child: CircularProgressIndicator()),
    );
  }

  Widget _buildPdfBody() {
    if (isDownloading) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text("Downloading PDF..."),
          ],
        ),
      );
    }

    if (downloadError.isNotEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(downloadError, textAlign: TextAlign.center, style: const TextStyle(color: Colors.red)),
        ),
      );
    }

    if (localPdfPath != null) {
      return PDFView(
        filePath: localPdfPath,
        enableSwipe: true,
        swipeHorizontal: false,
        autoSpacing: false,
        pageFling: false,
      );
    }

    return const Center(child: Text("Unable to load document."));
  }
}