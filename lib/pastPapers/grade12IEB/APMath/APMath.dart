import 'package:flutter/material.dart';
import 'package:funding/grades/grade12IEB.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class APMathGrade12Page extends StatefulWidget {
  const APMathGrade12Page({super.key});

  @override
  _APMathGrade12PageState createState() => _APMathGrade12PageState();
}

class _APMathGrade12PageState extends State<APMathGrade12Page> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<FileObject> pdfFilesP1 = [];
  List<FileObject> pdfFilesP2 = [];

  @override
  void initState() {
    super.initState();
    _fetchPDFFiles();
  }

  Future<void> _fetchPDFFiles() async {
    try {
      // Specify the path to the "AdvancedProgrammeMaths" folder within "grade12"
      final List<FileObject> objects = await supabase.storage
          .from('pdfs')
          .list(path: 'grade_12/IEB/AdvancedProgrammeMaths');

      setState(() {
        // Filter out only PDF files and sort them by P1 and P2
        pdfFilesP1 = objects
            .where((file) =>
                file.name.endsWith('.pdf') && file.name.contains('P1'))
            .toList();
        pdfFilesP2 = objects
            .where((file) =>
                file.name.endsWith('.pdf') && file.name.contains('P2'))
            .toList();
      });
    } catch (e) {
      print('Error fetching files: $e');
    }
  }

  Future<File?> _downloadPDF(String fileName) async {
    try {
      // Full path including folder and file name
      final String path = 'grade_12/IEB/AdvancedProgrammeMaths/$fileName';
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
          'AP MATH PAPERS',
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
              MaterialPageRoute(builder: (context) => const Grade12IEBPage()),
            );
          },
        ),
      ),
      body: (pdfFilesP1.isEmpty && pdfFilesP2.isEmpty)
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              children: [
                if (pdfFilesP1.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Paper 1 (P1)',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                  ..._buildPDFList(pdfFilesP1),
                ],
                if (pdfFilesP2.isNotEmpty) ...[
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Paper 2 (P2)',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                  ..._buildPDFList(pdfFilesP2),
                ],
              ],
            ),
    );
  }

  List<Widget> _buildPDFList(List<FileObject> files) {
    return files.map((file) {
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
    }).toList();
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
