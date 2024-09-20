import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:funding/grades/grade12.dart';

class IsiZuluGrade12Page extends StatefulWidget {
  const IsiZuluGrade12Page({super.key});

  @override
  _IsiZuluGrade12PageState createState() => _IsiZuluGrade12PageState();
}

class _IsiZuluGrade12PageState extends State<IsiZuluGrade12Page> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<FileObject> pdfFiles = [];
  List<FileObject> hlFiles = [];
  List<FileObject> falFiles = [];
  List<FileObject> salFiles = [];

  @override
  void initState() {
    super.initState();
    _fetchPDFFiles();
  }

  Future<void> _fetchPDFFiles() async {
    try {
      final List<FileObject> objects =
          await supabase.storage.from('pdfs').list(path: 'grade_12/IsiZulu');

      setState(() {
        pdfFiles = objects.where((file) => file.name.endsWith('.pdf')).toList();

        // Categorize files by HL, FAL, SAL
        hlFiles = pdfFiles
            .where((file) => file.name.toLowerCase().contains('hl'))
            .toList()
          ..sort((a, b) => a.name.compareTo(b.name));

        falFiles = pdfFiles
            .where((file) => file.name.toLowerCase().contains('fal'))
            .toList()
          ..sort((a, b) => a.name.compareTo(b.name));

        salFiles = pdfFiles
            .where((file) => file.name.toLowerCase().contains('sal'))
            .toList()
          ..sort((a, b) => a.name.compareTo(b.name));
      });
    } catch (e) {
      print('Error fetching files: $e');
    }
  }

  Future<File?> _downloadPDF(String fileName) async {
    try {
      final String path = 'grade_12/IsiZulu/$fileName';
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

  // Method to build PDF list by sorting them into P1, P2, and P3
  Widget _buildPDFListByPaper(List<FileObject> files, String categoryTitle) {
    if (files.isEmpty) {
      return const SizedBox.shrink();
    }

    final p1Files = _sortByPaper(files, 'p1');
    final p2Files = _sortByPaper(files, 'p2');
    final p3Files = _sortByPaper(files, 'p3');

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
        // Display P1 Files
        if (p1Files.isNotEmpty) _buildPaperSection('Paper 1 (P1)', p1Files),
        // Display P2 Files
        if (p2Files.isNotEmpty) _buildPaperSection('Paper 2 (P2)', p2Files),
        // Display P3 Files
        if (p3Files.isNotEmpty) _buildPaperSection('Paper 3 (P3)', p3Files),
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
          'ISIZULU PAPERS',
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
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(
                'IsiZulu Grade 12 Papers',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ),
            // Build lists for HL, FAL, and SAL sorted by P1, P2, P3
            _buildPDFListByPaper(hlFiles, 'Home Language (HL)'),
            _buildPDFListByPaper(falFiles, 'First Additional Language (FAL)'),
            _buildPDFListByPaper(salFiles, 'Second Additional Language (SAL)'),
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
              print('Error: $error');
            },
            onPageError: (page, error) {
              print('Page $page: ${error.toString()}');
            },
          ),
          if (!_isReady) const Center(child: CircularProgressIndicator()),
          if (_isReady)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    icon: const Icon(Icons.chevron_left),
                    onPressed: _currentPage > 0
                        ? () {
                            _pdfViewController.setPage(_currentPage - 1);
                          }
                        : null,
                  ),
                  Text('Page ${_currentPage + 1} of $_totalPages'),
                  IconButton(
                    icon: const Icon(Icons.chevron_right),
                    onPressed: _currentPage < _totalPages - 1
                        ? () {
                            _pdfViewController.setPage(_currentPage + 1);
                          }
                        : null,
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
