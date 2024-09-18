import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CalculateAPSUCTPage extends StatefulWidget {
  const CalculateAPSUCTPage({super.key});

  @override
  _CalculateAPSUCTPageState createState() => _CalculateAPSUCTPageState();
}

class _CalculateAPSUCTPageState extends State<CalculateAPSUCTPage> {
  final SupabaseClient _supabaseClient = Supabase.instance.client;
  bool isLoading = true;
  Map<String, int?> userMarks = {};
  Map<String, String?> userSubjects = {};

  int? aps;

  // Dropdown options
  final List<String> faculties = [
    'Science',
    'Commerce',
    'Humanities',
    'Law',
    'Engineering /Built Environment',
    'Health Sciences',
  ];

  final Map<String, List<String>> facultyPrograms = {
    'Science': [
      "Applied mathematics",
      "Archaeology",
      "Applied statistics",
      "Artificial intelligence",
      "Astrophysics",
      "Biochemistry",
      "Biology",
      "Business computing",
      "Chemistry",
      "Computer engineering",
      "Computer science",
      "Environmental and geographical science",
      "Genetics",
      "Geology",
      "Human anatomy and physiology",
      "Marine biology",
      "Mathematical statistics",
      "Ocean and Atmosphere Science",
      "Mathematics",
      "Physics",
      "Quantitative Biology",
      "Statistics and Data Science",
    ],
    'Commerce': [
      'Advanced Diploma in Accounting',
      'Advanced Diploma in Actuarial Sciences',
      'Bachelor of commerce/business science (ADP)',
      'Bachelor of commerce/business science (Mainstream)',
      'Bachelor of commerce/business science in Actuarial Sciences (ADP)',
      'Bachelor of commerce/business science in Actuarial Sciences (Mainstream)'
    ],
    'Humanities': [
      "Advanced Diploma in Adult and Community Education and Training",
      "Bachelor of Arts",
      "Bachelor of Arts in Fine Art",
      "Bachelor of Arts in Theatre & Performance",
      "Bachelor of Music",
      "Bachelor of Social Science",
      "Bachelor of Social Science: in Philosophy, Politics and Economics",
      "Bachelor of Social Work",
      "Diploma in Music Performance",
      "Diploma in Theatre and Performance",
      "Higher Certificate in Adult and Community Education and Training"
    ],
    'Law': [
      "Bachelor of Laws (undergraduate)",
    ],
    'Engineering /Built Environment': [
      'Bachelor of Architectural Studies',
      'Bachelor of Science in Construction Studies',
      'Bachelor of Science in Engineering in Chemical Engineering',
      'Bachelor of Science in Engineering in Civil Engineering',
      'Bachelor of Science in Engineering in Electrical & Computer Engineering',
      'Bachelor of Science in Engineering in Electrical Engineering',
      'Bachelor of Science in Engineering in Mechanical & Mechatronic Engineering',
      'Bachelor of Science in Engineering in Mechanical Engineering',
      'Bachelor of Science in Engineering in Mechatronics',
      'Bachelor of Science in Geomatics',
      'Bachelor of Science in Property Studies'
    ],
    'Health Sciences': [
      'Bachelor of Medicine and Bachelor of Surgery',
      'Bachelor of Science in Audiology',
      'Bachelor of Science in Occupational Therapy',
      'Bachelor of Science in Physiotherapy',
      'Bachelor of Science in Speech-Language Pathology',
      'Higher Certificate in Disability Practice (January to December)'
    ]
  };

  // State variables for selected dropdown values
  String? selectedFaculty;
  String? selectedAcademicProgram;

  List<String> academicPrograms = [];

  @override
  void initState() {
    super.initState();
    _fetchUserMarks();
  }

  Future<void> _fetchUserMarks() async {
    try {
      final response = await _supabaseClient
          .from('user_marks')
          .select(
              'math_mark, subject1_mark, subject2_mark, subject3_mark, subject4_mark, home_language_mark, first_additional_language_mark, second_additional_language_mark, math_type')
          .eq('user_id', _supabaseClient.auth.currentUser!.id)
          .single();

      final mathType = response['math_type'] ?? '';

      setState(() {
        userMarks = {
          'math_mark': response['math_mark'],
          'subject1_mark': response['subject1_mark'],
          'subject2_mark': response['subject2_mark'],
          'subject3_mark': response['subject3_mark'],
          'subject4_mark': response['subject4_mark'],
          'home_language_mark': response['home_language_mark'],
          'first_additional_language_mark':
              response['first_additional_language_mark'],
          'second_additional_language_mark':
              response['second_additional_language_mark'],
        };

        // Detect subjects
        userSubjects = {
          'subject1': response['subject1'],
          'subject2': response['subject2'],
          'subject3': response['subject3'],
          'subject4': response['subject4'],
          'home_language': response['home_language'],
          'first_additional_language': response['first_additional_language'],
          'second_additional_language': response['second_additional_language'],
        };

        aps = _calculateAPSUCT(userMarks, mathType);
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        isLoading = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching user marks: $error')),
      );
    }
  }

  int _calculateAPSUCT(Map<String, int?> marks, String mathType) {
    // Check for presence of specific subjects
    bool hasMathematics = mathType == 'Mathematics';
    bool hasPhysicalSciences = [
      marks['subject1_mark'],
      marks['subject2_mark'],
      marks['subject3_mark'],
      marks['subject4_mark']
    ].any((mark) => mark != null && mark > 0);

    bool hasEnglish = [
      marks['home_language_mark'],
      marks['first_additional_language_mark'],
      marks['second_additional_language_mark']
    ].any((mark) => mark != null && mark > 0);

    // Show error message if any required subjects are missing
    if (!hasMathematics || !hasPhysicalSciences || !hasEnglish) {
      String missingSubjects = '';
      if (!hasMathematics) missingSubjects += 'Mathematics ';
      if (!hasPhysicalSciences) missingSubjects += 'Physical Sciences ';
      if (!hasEnglish) missingSubjects += 'English ';

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
              'You need to include all of the following subjects: $missingSubjects'),
        ),
      );
      return 0; // Return 0 APS score if required subjects are missing
    }

    int apsScore = 0;

    // Combine all relevant marks: math_mark, subject marks, and language marks
    final allMarks = [
      marks['math_mark'],
      marks['subject1_mark'],
      marks['subject2_mark'],
      marks['subject3_mark'],
      marks['subject4_mark'],
      marks['home_language_mark'],
      marks['first_additional_language_mark'],
      marks['second_additional_language_mark'],
    ];

    // Remove any null marks
    final validMarks =
        allMarks.where((mark) => mark != null).cast<int>().toList();

    // If the mark is below 40, treat it as 0
    final adjustedMarks = validMarks.map((mark) {
      return mark < 40 ? 0 : mark;
    }).toList();

    // Sort all marks in descending order and take the top six
    adjustedMarks.sort((a, b) => b.compareTo(a));
    final bestSixSubjects = adjustedMarks.take(6);

    // Sum the marks for the best six subjects
    apsScore = bestSixSubjects.fold(0, (sum, mark) => sum + mark);

    return apsScore; // The APS will be out of 600
  }

  void _onFacultyChanged(String? value) {
    setState(() {
      selectedFaculty = value;
      selectedAcademicProgram = null;
      academicPrograms = facultyPrograms[selectedFaculty] ?? [];

      if (selectedFaculty == 'Science' ||
          selectedFaculty == 'Commerce' ||
          selectedFaculty == 'Engineering /Built Environment') {
        // Check if Mathematics, Physical Sciences, or English are present in the subject list
        bool hasMathematics = userSubjects.keys.contains('Mathematics');
        bool hasPhysicalSciences = userSubjects.keys.any((subject) =>
            subject.contains('Physical Sciences') ||
            subject.contains('Physics'));
        bool hasEnglish =
            userSubjects.keys.any((subject) => subject.contains('English'));

        if (!hasMathematics || !hasPhysicalSciences || !hasEnglish) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                  'You need to have Mathematics, Physical Sciences, and English for this faculty.'),
            ),
          );
          // Clear the selection if subjects are missing
          selectedFaculty = null;
          academicPrograms = [];
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("YOUR APS AT UCT"),
        backgroundColor: Colors.teal,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color.fromARGB(255, 242, 243, 243),
              Color.fromARGB(255, 241, 241, 241)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: isLoading
              ? const CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                )
              : Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 8.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            children: [
                              const Text(
                                'Your APS Score',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.teal,
                                ),
                              ),
                              const SizedBox(height: 20),
                              Text(
                                aps != null
                                    ? aps.toString()
                                    : 'Error calculating APS',
                                style: const TextStyle(
                                  fontSize: 40,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 0, 0, 0),
                                ),
                              ),
                              const SizedBox(height: 20),
                              const Text(
                                'UNIVERSITY OF CAPE TOWN',
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Colors.teal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Dropdown for Faculty with full width
                      SizedBox(
                        width: double.infinity, // Take up all available width
                        child: DropdownButtonFormField<String>(
                          isExpanded: true, // Expand to fit width
                          value: selectedFaculty,
                          hint: const Text('Select Faculty'),
                          items: faculties
                              .map((faculty) => DropdownMenuItem<String>(
                                    value: faculty,
                                    child: Text(
                                      faculty,
                                      overflow: TextOverflow
                                          .ellipsis, // Handle overflow
                                    ),
                                  ))
                              .toList(),
                          onChanged: _onFacultyChanged,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Dropdown for Academic Program with full width
                      if (selectedFaculty != null)
                        SizedBox(
                          width: double.infinity, // Take up all available width
                          child: DropdownButtonFormField<String>(
                            isExpanded: true, // Expand to fit width
                            value: selectedAcademicProgram,
                            hint: const Text('Select Program'),
                            items: academicPrograms
                                .map((program) => DropdownMenuItem<String>(
                                      value: program,
                                      child: Text(
                                        program,
                                        overflow: TextOverflow
                                            .ellipsis, // Handle overflow
                                      ),
                                    ))
                                .toList(),
                            onChanged: (value) {
                              setState(() {
                                selectedAcademicProgram = value;
                              });
                            },
                          ),
                        ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
