import 'package:flutter/material.dart';
import 'package:funding/grades/grade12IEB.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class EconomicsGrade12Page extends StatefulWidget {
  const EconomicsGrade12Page({super.key});

  @override
  _EconomicsGrade12PageState createState() => _EconomicsGrade12PageState();
}

class _EconomicsGrade12PageState extends State<EconomicsGrade12Page> {
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
          .list(path: 'grade_12/IEB/Economics');

      setState(() {
        pdfFiles = objects.where((file) => file.name.endsWith('.pdf')).toList();

        // Sort by year only
        pdfFiles.sort((a, b) {
          final aYear = _extractYear(a.name);
          final bYear = _extractYear(b.name);
          return bYear.compareTo(aYear); // Sort by year in descending order
        });
      });
    } catch (e) {
      print('Error fetching files: $e');
    }
  }

  String _extractYear(String fileName) {
    final yearRegex = RegExp(r'\d{4}');
    final match = yearRegex.firstMatch(fileName);
    if (match != null) {
      return match.group(0) ?? '0000'; // Return year or default '0000'
    }
    return '0000'; // Default if no year is found
  }

  Future<File?> _downloadPDF(String fileName) async {
    try {
      final String path = 'grade_12/IEB/Economics/$fileName';
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

  Widget _buildPDFListByYear(List<FileObject> files) {
    return ListView.builder(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'ECONOMICS PAPERS',
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
      body: pdfFiles.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'Economics Grade 12 Papers',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                  ),
                  _buildPDFListByYear(pdfFiles),
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
        title: const Text('PDF Viewer', style: TextStyle(color: Colors.white)),
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
          ),
          if (!_isReady) const Center(child: CircularProgressIndicator()),
          Positioned(
            bottom: 10,
            left: 10,
            right: 10,
            child: Container(
              color: Colors.black54,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () {
                      if (_currentPage > 0) {
                        _pdfViewController.setPage(_currentPage - 1);
                      }
                    },
                  ),
                  Text(
                    'Page ${_currentPage + 1} of $_totalPages',
                    style: const TextStyle(color: Colors.white),
                  ),
                  IconButton(
                    color: Colors.white,
                    icon: const Icon(Icons.arrow_forward),
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
