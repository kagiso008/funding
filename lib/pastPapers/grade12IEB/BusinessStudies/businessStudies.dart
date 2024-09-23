import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:funding/grades/grade12IEB.dart';

class BusinessStudiesGrade12Page extends StatefulWidget {
  const BusinessStudiesGrade12Page({super.key});

  @override
  _BusinessStudiesGrade12PageState createState() =>
      _BusinessStudiesGrade12PageState();
}

class _BusinessStudiesGrade12PageState
    extends State<BusinessStudiesGrade12Page> {
  final SupabaseClient supabase = Supabase.instance.client;
  List<FileObject> pdfFiles = [];

  @override
  void initState() {
    super.initState();
    _fetchPDFFiles();
  }

  Future<void> _fetchPDFFiles() async {
    try {
      // Specify the path to the folder
      final List<FileObject> objects = await supabase.storage
          .from('pdfs')
          .list(path: 'grade_12/IEB/BusinessStudies');

      setState(() {
        // Filter only PDF files
        pdfFiles = objects.where((file) => file.name.endsWith('.pdf')).toList();

        // Sort the files by year extracted from the file name
        pdfFiles.sort((a, b) {
          final yearA = _extractYear(a.name);
          final yearB = _extractYear(b.name);
          return yearA.compareTo(yearB);
        });
      });
    } catch (e) {
      print('Error fetching files: $e');
    }
  }

// Function to extract the year from the file name (assuming the format includes the year)
  int _extractYear(String fileName) {
    final RegExp yearRegExp = RegExp(r'\d{4}');
    final match = yearRegExp.firstMatch(fileName);
    if (match != null) {
      return int.parse(match.group(0)!);
    }
    // Default year if no year found in the name
    return 0;
  }

  Future<File?> _downloadPDF(String fileName) async {
    try {
      final String path = 'grade_12/IEB/BusinessStudies/$fileName';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.teal,
        title: const Text(
          'BUSINESS STUDIES PAPERS',
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
          : _buildPDFList(),
    );
  }

  Widget _buildPDFList() {
    return ListView.builder(
      itemCount: pdfFiles.length,
      itemBuilder: (context, index) {
        final file = pdfFiles[index];
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
