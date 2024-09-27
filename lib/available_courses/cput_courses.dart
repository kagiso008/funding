import 'package:flutter/material.dart';
import 'package:funding/pages/scholarshipsPage.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CPUTCoursesPage extends StatefulWidget {
  final int aps; // Add this parameter to receive the APS score

  const CPUTCoursesPage({super.key, required this.aps}); // Update constructor

  @override
  _CPUTCoursesPageState createState() => _CPUTCoursesPageState();
}

class _CPUTCoursesPageState extends State<CPUTCoursesPage> {
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  bool isLoading = true;
  Map<String, List<Map<String, dynamic>>> facultyCourses = {};

  @override
  void initState() {
    super.initState();
    _fetchAvailableCourses(widget.aps); // Use the passed APS score
  }

  Future<void> _fetchAvailableCourses(int aps) async {
    try {
      final userMarksResponse = await _supabaseClient
          .from('user_marks')
          .select(
              'math_mark, math_level, math_type, home_language_mark, home_language_level, first_additional_language_mark, first_additional_language_level, second_additional_language_mark, second_additional_language_level, subject1, subject1_level, subject2, subject2_level, subject3, subject3_level, subject4, subject4_level, life_orientation_mark, life_orientation_level, home_language, first_additional_language, second_additional_language')
          .eq('user_id', _supabaseClient.auth.currentUser!.id)
          .single();

      final userMarks = userMarksResponse;

      final response = await _supabaseClient
          .from('universities')
          .select(
              'university_name, qualification, aps, faculty, english_hl, english_fal, maths, technical_math, maths_lit, physical_sciences, life_orientation, accounting, business_studies, economics, history, geography, tourism, civil_technology, egd, cat, it, electrical_technology, mechanical_technology')
          .lte('aps', aps);

      final Map<String, List<Map<String, dynamic>>> groupedCourses = {};

      // Mapping user subjects to university columns
      final subjectMapping = {
        'Physical Sciences': 'physical_sciences',
        'Accounting': 'accounting',
        'Business Studies': 'business_studies',
        'Economics': 'economics',
        'History': 'history',
        'Geography': 'geography',
        'Tourism': 'tourism',
        'Civil Technology': 'civil_technology',
        'Engineering Graphics and Design': 'egd',
        'Computer Applications Technology': 'cat',
        'Information Technology': 'it',
        'Electrical Technology': 'electrical_technology',
        'Mechanical Technology': 'mechanical_technology',
      };

      for (var university in response) {
        bool meetsRequirements = true;

        // Compare based on math_type
        if (userMarks['math_type'] == 'Mathematics') {
          if ((userMarks['math_level'] ?? 0) < (university['maths'] ?? 0)) {
            meetsRequirements = false;
          }
        } else if (userMarks['math_type'] == 'Mathematical Literacy') {
          if ((userMarks['math_level'] ?? 0) < (university['maths_lit'] ?? 0)) {
            meetsRequirements = false;
          }
        } else if (userMarks['math_type'] == 'Technical Mathematics') {
          if ((userMarks['math_level'] ?? 0) <
              (university['technical_math'] ?? 0)) {
            meetsRequirements = false;
          }
        }

        // Check English requirements
        bool hasEnglishHL = userMarks['home_language']
                ?.toString()
                .toLowerCase()
                .contains('english') ??
            false;
        bool hasEnglishFAL = userMarks['first_additional_language']
                ?.toString()
                .toLowerCase()
                .contains('english') ??
            false;

        if (hasEnglishHL) {
          if ((userMarks['home_language_level'] ?? 0) <
              (university['english_hl'] ?? 0)) {
            meetsRequirements = false;
          }
        } else if (hasEnglishFAL) {
          if ((userMarks['first_additional_language_level'] ?? 0) <
              (university['english_fal'] ?? 0)) {
            meetsRequirements = false;
          }
        } else {
          meetsRequirements = false;
        }

        /// Iterate over the subjects required by the university
        subjectMapping.forEach((key, subjectName) {
          // Get the required level for this subject from the university
          final requiredLevel = university[key];

          // If the university has a requirement for this subject
          if (requiredLevel != null) {
            bool subjectFound = false;

            // Check if any of the user's selected subjects match this university subject
            for (int i = 1; i <= 4; i++) {
              final userSubject = userMarks['subject$i'];
              final userLevel = userMarks['subject${i}_level'];

              // If the user's subject matches the university-required subject
              if (userSubject == subjectName) {
                subjectFound = true;

                // If the user's subject level is less than the required level, they don't qualify
                if ((userLevel ?? 0) < requiredLevel) {
                  meetsRequirements = false;
                  break;
                }
              }
            }

            // If the required subject wasn't found in the user's selected subjects
            if (!subjectFound) {
              meetsRequirements = false;
            }
          }
        });

        // If requirements are met, add to the list
        if (meetsRequirements) {
          final faculty = university['faculty'] ?? 'Unknown Faculty';
          if (!groupedCourses.containsKey(faculty)) {
            groupedCourses[faculty] = [];
          }
          groupedCourses[faculty]!.add(university);
        }
      }

      setState(() {
        facultyCourses = groupedCourses;
        isLoading = false;
      });

      if (facultyCourses.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text('No courses match your subjects and levels')),
        );
      }
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching available courses: $error')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Courses you qualify for"),
          backgroundColor: Colors.teal,
        ),
        body: isLoading
            ? const Center(child: CircularProgressIndicator())
            : facultyCourses.isEmpty
                ? const Center(child: Text('No courses available for your APS'))
                : ListView.builder(
                    padding: const EdgeInsets.all(16.0),
                    itemCount: facultyCourses.keys.length,
                    itemBuilder: (context, index) {
                      final faculty = facultyCourses.keys.elementAt(index);
                      final courses = facultyCourses[faculty]!;

                      return Card(
                        elevation: 4.0,
                        margin: const EdgeInsets.symmetric(vertical: 10.0),
                        child: ExpansionTile(
                          title: Text(
                            faculty,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          children: courses.map((course) {
                            return ListTile(
                              title: Text(
                                course['qualification'],
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              onTap: () {
                                // Navigate to CoursePage when the ListTile is tapped
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => CoursePage(
                                      course: course,
                                      userAps: widget.aps,
                                    ),
                                  ),
                                );
                              },
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ));
  }
}

class CoursePage extends StatelessWidget {
  final Map<String, dynamic> course;
  final int userAps; // Add user's APS as a parameter

  const CoursePage({super.key, required this.course, required this.userAps});

  @override
  Widget build(BuildContext context) {
    // Subject mapping for easy display of required subjects
    final Map<String, String> subjectMapping = {
      'maths': 'Mathematics',
      'maths_lit': 'Mathematical Literacy',
      'technical_math': 'Technical Mathematics',
      'english_hl': 'English Home Language',
      'english_fal': 'English First Additional Language',
      'physical_sciences': 'Physical Sciences',
      'life_orientation': 'Life Orientation',
      // Add more subjects as needed...
    };

    // Collect maths-related subjects and English subjects into separate lists
    final List<Map<String, String>> mathSubjects = [];
    final List<Map<String, String>> englishSubjects = [];
    final List<Map<String, String>> otherSubjects = [];

    subjectMapping.forEach((key, value) {
      final subjectLevel = course[key];
      if (subjectLevel != null && subjectLevel > 0) {
        if (key == 'maths' || key == 'maths_lit' || key == 'technical_math') {
          mathSubjects
              .add({'subject': value, 'level': subjectLevel.toString()});
        } else if (key == 'english_hl' || key == 'english_fal') {
          englishSubjects
              .add({'subject': value, 'level': subjectLevel.toString()});
        } else {
          otherSubjects
              .add({'subject': value, 'level': subjectLevel.toString()});
        }
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: Text(course['qualification'] ?? 'Course Details'),
        backgroundColor: Colors.teal,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              course['qualification'] ?? 'Unknown Qualification',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Faculty: ${course['faculty'] ?? 'Unknown Faculty'}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'APS Requirement: ${course['aps'] ?? 'Not Available'}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 10),
            Text(
              'Your APS: $userAps', // Display user's APS
              style: const TextStyle(
                fontSize: 18,
                color: Colors.deepOrangeAccent,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            const Divider(),
            const SizedBox(height: 10),
            Text(
              'Required Subjects & Levels',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.teal,
              ),
            ),
            const SizedBox(height: 10),
            // Display maths-related subjects with 'or' between them
            if (mathSubjects.isNotEmpty) ...[
              Card(
                elevation: 4.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: const Icon(Icons.book, color: Colors.teal),
                  title: Text(
                    mathSubjects
                        .map((subj) =>
                            '${subj['subject']} (Level ${subj['level']})')
                        .join(' or '),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
            // Display English-related subjects with 'or' between them
            if (englishSubjects.isNotEmpty) ...[
              Card(
                elevation: 4.0,
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: ListTile(
                  leading: const Icon(Icons.book, color: Colors.teal),
                  title: Text(
                    englishSubjects
                        .map((subj) =>
                            '${subj['subject']} (Level ${subj['level']})')
                        .join(' or '),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
            // Display other required subjects
            Expanded(
              child: ListView.builder(
                itemCount: otherSubjects.length,
                itemBuilder: (context, index) {
                  final subject = otherSubjects[index];
                  return Card(
                    elevation: 4.0,
                    margin: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ListTile(
                      leading: const Icon(Icons.book, color: Colors.teal),
                      title: Text(
                        subject['subject']!,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(
                        'Required Level: ${subject['level']}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
