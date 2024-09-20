import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:funding/grades/grade12.dart';

class DesignGrade12Page extends StatefulWidget {
  const DesignGrade12Page({super.key});

  @override
  _DesignGrade12PageState createState() => _DesignGrade12PageState();
}

class _DesignGrade12PageState extends State<DesignGrade12Page> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<FileObject> pdfFiles = [];
  List<FileObject> p1Files = [];
  List<FileObject> p2Files = [];
  List<FileObject> p3Files = [];

  @override
  void initState() {
    super.initState();
    _fetchPDFFiles();
  }

  Future<void> _fetchPDFFiles() async {
    try {
      // Specify the path to the "Design" folder within "grade12"
      final List<FileObject> objects =
          await supabase.storage.from('pdfs').list(path: 'grade_12/Design');

      setState(() {
        // Filter out only PDF files
        pdfFiles = objects.where((file) => file.name.endsWith('.pdf')).toList();

        // Sort PDF files by paper type (assumed pattern: P1, P2, etc.)
        _sortPdfFiles();
      });
    } catch (e) {
      print('Error fetching files: $e');
    }
  }

  void _sortPdfFiles() {
    final List<FileObject> p1 = [];
    final List<FileObject> p2 = [];
    final List<FileObject> p3 = [];

    for (final file in pdfFiles) {
      if (file.name.contains('P1')) {
        p1.add(file);
      } else if (file.name.contains('P2')) {
        p2.add(file);
      } else if (file.name.contains('P3')) {
        p3.add(file);
      }
    }

    setState(() {
      p1Files = p1;
      p2Files = p2;
      p3Files = p3;
    });
  }

  Future<File?> _downloadPDF(String fileName) async {
    try {
      // Full path including folder and file name
      final String path = 'grade_12/Design/$fileName';
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
    final File? file = await _downloadPDF(fileName); // Pass the file name
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'DESIGN PAPERS',
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
              MaterialPageRoute(builder: (context) => const Grade12Page()),
            );
          },
        ),
      ),
      body: ListView(
        children: [
          _buildCategorySection('Paper 1 (P1)', p1Files),
          _buildCategorySection('Paper 2 (P2)', p2Files),
          _buildCategorySection('Paper 3 (P3)', p3Files),
        ],
      ),
    );
  }

  Widget _buildCategorySection(String category, List<FileObject> files) {
    return files.isEmpty
        ? const SizedBox.shrink() // No space if there are no files
        : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
                child: Text(
                  category,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal,
                  ),
                ),
              ),
              ...files.map((file) => Card(
                    margin: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 16),
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
                  )),
            ],
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
            nightMode: true, // Dark mode for better reading
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
