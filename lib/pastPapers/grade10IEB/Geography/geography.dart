import 'package:flutter/material.dart';
import 'package:funding/grades/grade10IEB.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:funding/grades/grade10.dart';

class GeographyGrade10Page extends StatefulWidget {
  const GeographyGrade10Page({super.key});

  @override
  _GeographyGrade10PageState createState() => _GeographyGrade10PageState();
}

class _GeographyGrade10PageState extends State<GeographyGrade10Page> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<FileObject> pdfFiles = [];

  @override
  void initState() {
    super.initState();
    _fetchPDFFiles();
  }

  Future<void> _fetchPDFFiles() async {
    try {
      final List<FileObject> objects = await supabase.storage
          .from('pdfs')
          .list(path: 'grade_10/IEB/Geography');

      setState(() {
        pdfFiles = objects.where((file) => file.name.endsWith('.pdf')).toList();
      });
    } catch (e) {
      print('Error fetching files: $e');
    }
  }

  Future<File?> _downloadPDF(String fileName) async {
    try {
      final String path = 'grade_10/IEB/Geography/$fileName';
      final response = await supabase.storage.from('pdfs').download(path);

      if (response.isNotEmpty) {
        final tempDir = await getTemporaryDirectory();
        final file = File('${tempDir.path}/$fileName');
        await file.writeAsBytes(response);
        return file;
      }
    } catch (e) {
      print('Error downloading file: $e');
    }
    return null;
  }

  void _openPDF(String fileName) async {
    final File? file = await _downloadPDF(fileName);
    if (file != null) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => PDFViewPage(file: file),
        ),
      );
    } else {
      print('Failed to open PDF');
    }
  }

  // Helper method to sort PDFs by P1, P2, P3
  List<FileObject> _sortByPaper(List<FileObject> files, String paper) {
    return files
        .where((file) => file.name.toLowerCase().contains(paper))
        .toList()
      ..sort((a, b) => a.name.compareTo(b.name));
  }

  // Method to build PDF list without sorting them by P1, P2, P3
  Widget _buildPDFList(List<FileObject> files, String categoryTitle) {
    if (files.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            categoryTitle,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.teal,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: files.length,
          itemBuilder: (context, index) {
            final file = files[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              color: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.picture_as_pdf,
                  color: Colors.redAccent,
                  size: 40,
                ),
                title: Text(
                  file.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                  onPressed: () => _openPDF(file.name),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  // Widget to build a section for each paper type (P1, P2, P3)
  Widget _buildPaperSection(String paperTitle, List<FileObject> files) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Text(
            paperTitle,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: files.length,
          itemBuilder: (context, index) {
            final file = files[index];
            return Card(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
              color: Colors.teal,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: ListTile(
                leading: const Icon(
                  Icons.picture_as_pdf,
                  color: Colors.redAccent,
                  size: 40,
                ),
                title: Text(
                  file.name,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                trailing: IconButton(
                  icon: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.white,
                  ),
                  onPressed: () => _openPDF(file.name),
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'GEOGRAPHY PAPERS',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Grade10IEBPage()),
            );
          },
        ),
      ),
      body: pdfFiles.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  _buildPDFList(pdfFiles, 'Geography Grade 10 Papers'),
                ],
              ),
            ),
    );
  }
}

class PDFViewPage extends StatefulWidget {
  final File file;

  const PDFViewPage({super.key, required this.file});

  @override
  _PDFViewPageState createState() => _PDFViewPageState();
}

class _PDFViewPageState extends State<PDFViewPage> {
  bool _isReady = false;
  int _totalPages = 0;
  int _currentPage = 0;
  late PDFViewController _pdfViewController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'PDF Viewer',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Stack(
        children: [
          PDFView(
            filePath: widget.file.path,
            autoSpacing: true,
            enableSwipe: true,
            swipeHorizontal: true,
            nightMode: true,
            onRender: (pages) {
              setState(() {
                _totalPages = pages!;
                _isReady = true;
              });
            },
            onViewCreated: (controller) {
              setState(() {
                _pdfViewController = controller;
              });
            },
            onPageChanged: (page, total) {
              setState(() {
                _currentPage = page!;
              });
            },
            onError: (error) {
              print(error.toString());
            },
          ),
          if (!_isReady)
            const Center(
              child: CircularProgressIndicator(),
            ),
          Positioned(
            bottom: 20,
            left: 20,
            right: 20,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.7),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                    onPressed: () {
                      if (_currentPage > 0) {
                        _pdfViewController.setPage(_currentPage - 1);
                      }
                    },
                  ),
                  Text(
                    'Page ${_currentPage + 1} / $_totalPages',
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.arrow_forward_ios,
                        color: Colors.white),
                    onPressed: () {
                      if (_currentPage < _totalPages - 1) {
                        _pdfViewController.setPage(_currentPage + 1);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
