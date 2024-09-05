import 'package:flutter/material.dart';
import 'package:funding/pages/homepage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    'Mathematics',
    'Mathematical Literacy',
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
    'English',
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

  Future<void> _saveMarks() async {
    final user = Supabase.instance.client.auth.currentUser;
    if (user == null) {
      // Handle case where the user is not logged in
      print('User is not logged in.');
      return;
    }

    // Calculate the average mark
    final averageMark = _calculateAverage();

    final response = await Supabase.instance.client.from('user_marks').upsert({
      'user_id': user.id,
      'math_mark': _mathMark,
      'english_mark': _englishMark,
      'subject1_mark': _subject1Mark,
      'subject2_mark': _subject2Mark,
      'subject3_mark': _subject3Mark,
      'subject4_mark': _subject4Mark,
      'life_orientation_mark': _lifeOrientationMark,
      'average': averageMark,
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
      print('Marks saved successfully');
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
            const SizedBox(
              height: 20,
            ),
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
            const SizedBox(
              height: 20,
            ),
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
            const SizedBox(
              height: 20,
            ),
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
            const SizedBox(
              height: 20,
            ),
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
            const SizedBox(
              height: 20,
            ),
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
            const SizedBox(
              height: 20,
            ),
            _buildMarkDropdownField(
              label: 'Life Orientation Mark',
              value: _lifeOrientationMark,
              onChanged: (value) {
                setState(() {
                  _lifeOrientationMark = value ?? 0;
                });
              },
            ),
            const SizedBox(height: 20.0),
            Center(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      _saveMarks().then((_) {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Homepage(
                              minAverageMark: _calculateAverage().toInt(),
                              minMathMark: _mathMark,
                              minPhysicsMark: _subject1Mark,
                              minAccountingMark: _subject2Mark,
                              minEnglishMark: _englishMark,
                            ),
                          ),
                        );
                      });
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
                      "View Scholarships",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20.0),
                  Text(
                    "Average Mark: ${_calculateAverage().toStringAsFixed(2)}",
                    style: const TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal,
                    ),
                  ),
                ],
              ),
            ),
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
          DropdownButtonFormField<String>(
            value: value,
            items: items
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
            onChanged: onChanged,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
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
          DropdownButtonFormField<int>(
            value: value,
            items: _getMarkDropdownItems(),
            onChanged: onChanged,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.0),
                borderSide: BorderSide.none,
              ),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
            ),
          ),
        ],
      ),
    );
  }
}
