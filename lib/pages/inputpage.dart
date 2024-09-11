import 'package:flutter/material.dart';
import 'package:funding/pages/landing_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'analytics.dart';
//import 'dart:io';
//import 'package:pdf/pdf.dart';
//import 'package:pdf/widgets.dart' as pw;
//import 'package:path_provider/path_provider.dart';
//import 'package:open_file/open_file.dart';

class EnterMarksPage extends StatefulWidget {
  const EnterMarksPage({super.key});

  @override
  State<EnterMarksPage> createState() => _EnterMarksPageState();
}

class _EnterMarksPageState extends State<EnterMarksPage> {
  String _selectedMath = 'Mathematics';
  String _selectedEnglish = 'English Home Language';
  String _selectedSubject1 = 'Accounting';
  String _selectedSubject2 = 'Accounting';
  String _selectedSubject3 = 'Accounting';
  String _selectedSubject4 = 'Afrikaans';

  int _mathMark = 0;
  int _englishMark = 0;
  int _subject1Mark = 0;
  int _subject2Mark = 0;
  int _subject3Mark = 0;
  int _subject4Mark = 0;
  int _lifeOrientationMark = 0;

  final List<String> _subjects = [
    'Accounting',
    'Agricultural Management Practices',
    'Agricultural Sciences',
    'Agricultural Technology',
    'Business Studies',
    'Civil Technology',
    'Computer Applications Technology',
    'Consumer Studies',
    'Dance Studies',
    'Dramatic Arts',
    'Economics',
    'Electrical Technology',
    'Engineering Graphics and Design',
    'Geography',
    'History',
    'Hospitality Studies',
    'Information Technology',
    'Life Sciences',
    'Mechanical Technology',
    'Music',
    'Physical Sciences',
    'Religion Studies',
    'Tourism',
    'Visual Arts',
    'None'
  ];

  final List<String> _subjects2 = [
    'Sepedi',
    'Sesotho',
    'Setswana',
    'siSwati',
    'Tshivenda',
    'Xitsonga',
    'Afrikaans',
    'isiNdebele',
    'isiXhosa',
    'isiZulu',
  ];

  List<DropdownMenuItem<int>> _getMarkDropdownItems() {
    List<DropdownMenuItem<int>> items = [];
    for (int i = 0; i <= 100; i++) {
      items.add(DropdownMenuItem(value: i, child: Text(i.toString())));
    }
    return items;
  }

  double _calculateAverage() {
    int totalMarks = _mathMark +
        _englishMark +
        _subject1Mark +
        _subject2Mark +
        _subject3Mark +
        _subject4Mark +
        _lifeOrientationMark;

    return totalMarks / 7;
  }

  // Get level based on mark
  String _getLevelFromMark(int mark) {
    if (mark >= 0 && mark <= 29) {
      return '1';
    } else if (mark >= 30 && mark <= 39) {
      return '2';
    } else if (mark >= 40 && mark <= 49) {
      return '3';
    } else if (mark >= 50 && mark <= 59) {
      return '4';
    } else if (mark >= 60 && mark <= 69) {
      return '5';
    } else if (mark >= 70 && mark <= 79) {
      return '6';
    } else {
      return '7';
    }
  }

  /*Future<File> generatePdf(List<Map<String, dynamic>> data) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            children: [
              pw.Text('Analytics Report',
                  style: pw.TextStyle(
                      fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.SizedBox(height: 20),
              ...data.map(
                (row) => pw.Row(
                  children: [
                    pw.Expanded(child: pw.Text(row['column1'] ?? '')),
                    pw.Expanded(child: pw.Text(row['column2'] ?? '')),
                    // Add more columns as needed
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );

    final outputFile =
        File('${(await getTemporaryDirectory()).path}/analytics_report.pdf');
    await outputFile.writeAsBytes(await pdf.save());

    return outputFile;
  }*/

  Future<void> _saveMarks() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      // Handle case where the user is not logged in
      print('User is not logged in.');
      return;
    }

    // Calculate the average mark
    final averageMark = _calculateAverage().toInt();

    // Calculate the total APS by summing the levels
    final totalAPS = int.parse(_getLevelFromMark(_mathMark)) +
        int.parse(_getLevelFromMark(_englishMark)) +
        int.parse(_getLevelFromMark(_subject1Mark)) +
        int.parse(_getLevelFromMark(_subject2Mark)) +
        int.parse(_getLevelFromMark(_subject3Mark)) +
        int.parse(_getLevelFromMark(_subject4Mark)) +
        int.parse(_getLevelFromMark(_lifeOrientationMark));

    final response = await Supabase.instance.client.from('user_marks').upsert({
      'user_id': user.id,
      'math_mark': _mathMark,
      'math_level': _getLevelFromMark(_mathMark), // Store level
      'english_mark': _englishMark,
      'english_level': _getLevelFromMark(_englishMark), // Store level
      'subject1': _selectedSubject1,
      'subject1_mark': _subject1Mark,
      'subject1_level': _getLevelFromMark(_subject1Mark), // Store level
      'subject2': _selectedSubject2,
      'subject2_mark': _subject2Mark,
      'subject2_level': _getLevelFromMark(_subject2Mark), // Store level
      'subject3': _selectedSubject3,
      'subject3_mark': _subject3Mark,
      'subject3_level': _getLevelFromMark(_subject3Mark), // Store level
      'subject4': _selectedSubject4,
      'subject4_mark': _subject4Mark,
      'subject4_level': _getLevelFromMark(_subject4Mark), // Store level
      'life_orientation_mark': _lifeOrientationMark,
      'life_orientation_level':
          _getLevelFromMark(_lifeOrientationMark), // Store level
      'average': averageMark,
      'aps_mark': totalAPS, // Store the total APS mark
    });

    // Check if response is null
    if (response == null) {
      print('Error: Response is null');
      return;
    }

    // Check for error in response
    if (response.error != null) {
      print('Error saving marks: ${response.error!.message}');
    } else {
      print('Marks and APS saved successfully');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Enter Your Marks"),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(bottom: 16.0),
              child: Text(
                'Please enter your marks below:',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.teal,
                ),
              ),
            ),
            _buildDropdownField(
              label: 'Mathematics',
              value: _selectedMath,
              items: ['Mathematics', 'Mathematical Literacy'],
              onChanged: (value) {
                setState(() {
                  _selectedMath = value!;
                });
              },
            ),
            _buildMarkDropdownField(
              label: 'Mathematics Mark',
              value: _mathMark,
              onChanged: (value) {
                setState(() {
                  _mathMark = value ?? 0;
                });
              },
            ),
            _buildLevelDisplay(level: _getLevelFromMark(_mathMark)),
            const SizedBox(height: 20),
            _buildDropdownField(
              label: 'English',
              value: _selectedEnglish,
              items: [
                'English Home Language',
                'English First Additional Language',
                'English Second Additional Language'
              ],
              onChanged: (value) {
                setState(() {
                  _selectedEnglish = value!;
                });
              },
            ),
            _buildMarkDropdownField(
              label: 'English Mark',
              value: _englishMark,
              onChanged: (value) {
                setState(() {
                  _englishMark = value ?? 0;
                });
              },
            ),
            _buildLevelDisplay(level: _getLevelFromMark(_englishMark)),
            const SizedBox(height: 20),
            _buildDropdownField(
              label: 'Subject 1',
              value: _selectedSubject1,
              items: _subjects,
              onChanged: (value) {
                setState(() {
                  _selectedSubject1 = value!;
                });
              },
            ),
            _buildMarkDropdownField(
              label: 'Subject 1 Mark',
              value: _subject1Mark,
              onChanged: (value) {
                setState(() {
                  _subject1Mark = value ?? 0;
                });
              },
            ),
            _buildLevelDisplay(level: _getLevelFromMark(_subject1Mark)),
            const SizedBox(height: 20),
            _buildDropdownField(
              label: 'Subject 2',
              value: _selectedSubject2,
              items: _subjects,
              onChanged: (value) {
                setState(() {
                  _selectedSubject2 = value!;
                });
              },
            ),
            _buildMarkDropdownField(
              label: 'Subject 2 Mark',
              value: _subject2Mark,
              onChanged: (value) {
                setState(() {
                  _subject2Mark = value ?? 0;
                });
              },
            ),
            _buildLevelDisplay(level: _getLevelFromMark(_subject2Mark)),
            const SizedBox(height: 20),
            _buildDropdownField(
              label: 'Subject 3',
              value: _selectedSubject3,
              items: _subjects,
              onChanged: (value) {
                setState(() {
                  _selectedSubject3 = value!;
                });
              },
            ),
            _buildMarkDropdownField(
              label: 'Subject 3 Mark',
              value: _subject3Mark,
              onChanged: (value) {
                setState(() {
                  _subject3Mark = value ?? 0;
                });
              },
            ),
            _buildLevelDisplay(level: _getLevelFromMark(_subject3Mark)),
            const SizedBox(height: 20),
            _buildDropdownField(
              label: 'Subject 4',
              value: _selectedSubject4,
              items: _subjects2,
              onChanged: (value) {
                setState(() {
                  _selectedSubject4 = value!;
                });
              },
            ),
            _buildMarkDropdownField(
              label: 'Subject 4 Mark',
              value: _subject4Mark,
              onChanged: (value) {
                setState(() {
                  _subject4Mark = value ?? 0;
                });
              },
            ),
            _buildLevelDisplay(level: _getLevelFromMark(_subject4Mark)),
            const SizedBox(height: 20),
            _buildMarkDropdownField(
              label: 'Life Orientation Mark',
              value: _lifeOrientationMark,
              onChanged: (value) {
                setState(() {
                  _lifeOrientationMark = value ?? 0;
                });
              },
            ),
            _buildLevelDisplay(level: _getLevelFromMark(_lifeOrientationMark)),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  await _saveMarks();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LandingPage(
                          /*minAverageMark: _calculateAverage().toInt(),
                        minMathMark: _mathMark,
                        minPhysicsMark: _subject1Mark,
                        minAccountingMark: _subject2Mark,
                        minEnglishMark: _englishMark,
                      */
                          ),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.teal,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 40.0, vertical: 20.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                ),
                child: const Text(
                  "Save marks",
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownField({
    required String label,
    required String value,
    required List<String> items,
    required ValueChanged<String?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Colors.teal, width: 1.5),
              color: Colors.grey[200],
            ),
            child: DropdownButtonFormField<String>(
              value: value,
              onChanged: onChanged,
              items: items.map((item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(fontSize: 16.0),
                  ),
                );
              }).toList(),
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMarkDropdownField({
    required String label,
    required int value,
    required ValueChanged<int?> onChanged,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8.0),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.0),
              border: Border.all(color: Colors.teal, width: 1.5),
              color: Colors.grey[200],
            ),
            child: DropdownButtonFormField<int>(
              value: value,
              onChanged: onChanged,
              items: _getMarkDropdownItems(),
              decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }

// Widget to display the calculated level
  Widget _buildLevelDisplay({required String level}) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Text(
        'Level: $level',
        style: const TextStyle(
          fontWeight: FontWeight.bold,
          color: Colors.teal,
        ),
      ),
    );
  }
}
