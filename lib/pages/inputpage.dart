import 'package:flutter/material.dart';
import 'package:funding/pages/landing_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:funding/lists/subjects.dart'; // Import the file containing your lists

class EnterMarksPage extends StatefulWidget {
  const EnterMarksPage({super.key});

  @override
  State<EnterMarksPage> createState() => _EnterMarksPageState();
}

class _EnterMarksPageState extends State<EnterMarksPage> {
  String _selectedMath = mathematics[0];
  String _selectedHomeLanguage = homeLanguages[0];
  String _selectedFirstAdditionalLanguage = firstAdditionalLanguages[0];
  String _selectedSecondAdditionalLanguage = "None";
  String _selectedSubject1 = "None";
  String _selectedSubject2 = "None";
  String _selectedSubject3 = "None";
  String _selectedSubject4 = "None";

  int _mathMark = 0;
  int _homeLanguageMark = 0;
  int _firstAdditionalLanguageMark = 0;
  int _secondAdditionalLanguageMark = 0;
  int _subject1Mark = 0;
  int _subject2Mark = 0;
  int _subject3Mark = 0;
  int _subject4Mark = 0;
  int _lifeOrientationMark = 0;

  List<String> get _availableElectives {
    List<String> selectedElectives = [
      _selectedSubject1,
      _selectedSubject2,
      _selectedSubject3,
      _selectedSubject4,
    ];
    return electives
        .where((elec) => !selectedElectives.contains(elec))
        .toList();
  }

  List<DropdownMenuItem<String>> _getDropdownItems(List<String> items) {
    return items.map((item) {
      return DropdownMenuItem<String>(
        value: item,
        child: Text(item, style: const TextStyle(fontSize: 16.0)),
      );
    }).toList();
  }

  List<DropdownMenuItem<int>> _getMarkDropdownItems() {
    List<DropdownMenuItem<int>> items = [];
    for (int i = 0; i <= 100; i++) {
      items.add(DropdownMenuItem(value: i, child: Text(i.toString())));
    }
    return items;
  }

  double _calculateAverage() {
    int totalMarks = _mathMark +
        _homeLanguageMark +
        _firstAdditionalLanguageMark +
        _secondAdditionalLanguageMark +
        _subject1Mark +
        _subject2Mark +
        _subject3Mark +
        _subject4Mark +
        _lifeOrientationMark;

    return totalMarks / 9; // Update the divisor to 9
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
        int.parse(_getLevelFromMark(_homeLanguageMark)) +
        int.parse(_getLevelFromMark(_firstAdditionalLanguageMark)) +
        int.parse(_getLevelFromMark(_secondAdditionalLanguageMark)) +
        int.parse(_getLevelFromMark(_subject1Mark)) +
        int.parse(_getLevelFromMark(_subject2Mark)) +
        int.parse(_getLevelFromMark(_subject3Mark)) +
        int.parse(_getLevelFromMark(_subject4Mark)) +
        int.parse(_getLevelFromMark(_lifeOrientationMark));

    final response = await Supabase.instance.client.from('user_marks').upsert({
      'user_id': user.id,
      'math_mark': _mathMark,
      'math_level': _getLevelFromMark(_mathMark), // Store level
      'math_type': _selectedMath, // Store the selected math type
      'home_language_mark': _homeLanguageMark,
      'home_language_level':
          _getLevelFromMark(_homeLanguageMark), // Store level
      'first_additional_language_mark': _firstAdditionalLanguageMark,
      'first_additional_language_level':
          _getLevelFromMark(_firstAdditionalLanguageMark), // Store level
      'second_additional_language_mark': _secondAdditionalLanguageMark,
      'second_additional_language_level':
          _getLevelFromMark(_secondAdditionalLanguageMark), // Store level
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
      'home_language': _selectedHomeLanguage,
      'first_additional_language': _selectedFirstAdditionalLanguage,
      'second_additional_language': _selectedSecondAdditionalLanguage,
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
      print('Marks, math type, and APS saved successfully');
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
            _buildDropdownWithMarkField(
              subjectLabel: 'Mathematics',
              subjectValue: _selectedMath,
              subjectItems: mathematics,
              onSubjectChanged: (value) {
                setState(() {
                  _selectedMath = value!;
                });
              },
              markValue: _mathMark,
              onMarkChanged: (value) {
                setState(() {
                  _mathMark = value ?? 0;
                });
              },
              isMarkEnabled: _selectedMath != 'None',
            ),
            _buildDropdownWithMarkField(
              subjectLabel: 'Home Language',
              subjectValue: _selectedHomeLanguage,
              subjectItems: homeLanguages,
              onSubjectChanged: (value) {
                setState(() {
                  _selectedHomeLanguage = value!;
                });
              },
              markValue: _homeLanguageMark,
              onMarkChanged: (value) {
                setState(() {
                  _homeLanguageMark = value ?? 0;
                });
              },
              isMarkEnabled: _selectedHomeLanguage != 'None',
            ),
            _buildDropdownWithMarkField(
              subjectLabel: 'First Additional Language',
              subjectValue: _selectedFirstAdditionalLanguage,
              subjectItems: firstAdditionalLanguages,
              onSubjectChanged: (value) {
                setState(() {
                  _selectedFirstAdditionalLanguage = value!;
                });
              },
              markValue: _firstAdditionalLanguageMark,
              onMarkChanged: (value) {
                setState(() {
                  _firstAdditionalLanguageMark = value ?? 0;
                });
              },
              isMarkEnabled: _selectedFirstAdditionalLanguage != 'None',
            ),
            _buildDropdownWithMarkField(
              subjectLabel: 'Elective 1',
              subjectValue: _selectedSubject1,
              subjectItems: _availableElectives,
              onSubjectChanged: (value) {
                setState(() {
                  _selectedSubject1 = value!;
                });
              },
              markValue: _subject1Mark,
              onMarkChanged: (value) {
                setState(() {
                  _subject1Mark = value ?? 0;
                });
              },
              isMarkEnabled: _selectedSubject1 != 'None',
            ),
            _buildDropdownWithMarkField(
              subjectLabel: 'Elective 2',
              subjectValue: _selectedSubject2,
              subjectItems: _availableElectives,
              onSubjectChanged: (value) {
                setState(() {
                  _selectedSubject2 = value!;
                });
              },
              markValue: _subject2Mark,
              onMarkChanged: (value) {
                setState(() {
                  _subject2Mark = value ?? 0;
                });
              },
              isMarkEnabled: _selectedSubject2 != 'None',
            ),
            _buildDropdownWithMarkField(
              subjectLabel: 'Elective 3',
              subjectValue: _selectedSubject3,
              subjectItems: _availableElectives,
              onSubjectChanged: (value) {
                setState(() {
                  _selectedSubject3 = value!;
                });
              },
              markValue: _subject3Mark,
              onMarkChanged: (value) {
                setState(() {
                  _subject3Mark = value ?? 0;
                });
              },
              isMarkEnabled: _selectedSubject3 != 'None',
            ),
            _buildDropdownWithMarkField(
              subjectLabel: 'Life Orientation',
              subjectValue: 'Life Orientation',
              subjectItems: ['Life Orientation'], // Single item as label
              onSubjectChanged: (value) {
                // No change required
              },
              markValue: _lifeOrientationMark,
              onMarkChanged: (value) {
                setState(() {
                  _lifeOrientationMark = value ?? 0;
                });
              },
              isMarkEnabled: true, // Always enabled
            ),
            const SizedBox(height: 20),
            const Text("extra subjects"),
            const SizedBox(height: 20),
            _buildDropdownWithMarkField(
              subjectLabel: 'Elective 4',
              subjectValue: _selectedSubject4,
              subjectItems: _availableElectives,
              onSubjectChanged: (value) {
                setState(() {
                  _selectedSubject4 = value!;
                });
              },
              markValue: _subject4Mark,
              onMarkChanged: (value) {
                setState(() {
                  _subject4Mark = value ?? 0;
                });
              },
              isMarkEnabled: _selectedSubject4 != 'None',
            ),
            _buildDropdownWithMarkField(
              subjectLabel: 'Second Additional Language',
              subjectValue: _selectedSecondAdditionalLanguage,
              subjectItems: secondAdditionalLanguages,
              onSubjectChanged: (value) {
                setState(() {
                  _selectedSecondAdditionalLanguage = value!;
                });
              },
              markValue: _secondAdditionalLanguageMark,
              onMarkChanged: (value) {
                setState(() {
                  _secondAdditionalLanguageMark = value ?? 0;
                });
              },
              isMarkEnabled: _selectedSecondAdditionalLanguage != 'None',
            ),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  await _saveMarks();

                  // Navigate to the landing page after saving the marks
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LandingPage()),
                  );
                },
                child: const Text('Save Marks'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdownWithMarkField({
    required String subjectLabel,
    required String subjectValue,
    required List<String> subjectItems,
    required ValueChanged<String?> onSubjectChanged,
    required int markValue,
    required ValueChanged<int?> onMarkChanged,
    required bool isMarkEnabled,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Row(
        children: [
          Expanded(
            child: PopupMenuButton<String>(
              onSelected: onSubjectChanged,
              itemBuilder: (BuildContext context) {
                return subjectItems.map((String item) {
                  return PopupMenuItem<String>(
                    value: item,
                    child: SizedBox(
                      width: 200, // Set a fixed width for scrolling
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child:
                            Text(item, style: const TextStyle(fontSize: 16.0)),
                      ),
                    ),
                  );
                }).toList();
              },
              child: ListTile(
                title: Text(subjectLabel),
                subtitle: Text(subjectValue),
                trailing: const Icon(Icons.arrow_drop_down),
              ),
            ),
          ),
          const SizedBox(width: 16), // Space between dropdowns
          SizedBox(
            width: 80, // Set the width for the mark dropdown
            child: DropdownButtonFormField<int>(
              value: isMarkEnabled ? markValue : null,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                isDense: true, // Compact the dropdown
              ),
              items: _getMarkDropdownItems(),
              onChanged: isMarkEnabled ? onMarkChanged : null,
            ),
          ),
        ],
      ),
    );
  }
}
