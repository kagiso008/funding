import 'package:flutter/material.dart';
import 'package:funding/grades/grade11home.dart';
import 'package:funding/pages/landing_page.dart';
import 'package:funding/pages/past_papers.dart';
import 'package:funding/pastPapers/grade11IEB/BusinessStudies/businessStudies.dart';
import 'package:funding/pastPapers/grade11IEB/ConsumerStudies/consumerStudies.dart';
import 'package:funding/pastPapers/grade11IEB/DanceStudies/danceStudies.dart';
import 'package:funding/pastPapers/grade11IEB/Design/design.dart';
import 'package:funding/pastPapers/grade11IEB/DramaticArts/dramaticArts.dart';
import 'package:funding/pastPapers/grade11IEB/Economics/economics.dart';
import 'package:funding/pastPapers/grade11IEB/ElectricalTechnology/electricalTechnology.dart';
import 'package:funding/pastPapers/grade11IEB/EngineeringGraphicsAndDesign/egd.dart';
import 'package:funding/pastPapers/grade11IEB/English/english.dart';
import 'package:funding/pastPapers/grade11IEB/Geography/geography.dart';
import 'package:funding/pastPapers/grade11IEB/History/history.dart';
import 'package:funding/pastPapers/grade11IEB/HospitalityStudies/hospitalityStudies.dart';
import 'package:funding/pastPapers/grade11IEB/InformationTechnology/IT.dart';
import 'package:funding/pastPapers/grade11IEB/IsiNdebele/isiNdebele.dart';
import 'package:funding/pastPapers/grade11IEB/IsiXhosa/isiXhosa.dart';
import 'package:funding/pastPapers/grade11IEB/IsiZulu/isiZulu.dart';
import 'package:funding/pastPapers/grade11IEB/LifeOrientation/LifeOrientation.dart';
import 'package:funding/pastPapers/grade11IEB/LifeSciences/lifeSciences.dart';
import 'package:funding/pastPapers/grade11IEB/MarineSciences/marineSciences.dart';
import 'package:funding/pastPapers/grade11IEB/MathematicalLiteracy/mathsLit.dart';
import 'package:funding/pastPapers/grade11IEB/Mathematics/maths.dart';
import 'package:funding/pastPapers/grade11IEB/MechanicalTechnology/mechinalTechnology.dart';
import 'package:funding/pastPapers/grade11IEB/Music/music.dart';
import 'package:funding/pastPapers/grade11IEB/PhysicalSciences/physicalSciences.dart';
import 'package:funding/pastPapers/grade11IEB/ReligionStudies/religionStudies.dart';
import 'package:funding/pastPapers/grade11IEB/Sepedi/sepedi.dart';
import 'package:funding/pastPapers/grade11IEB/Sesotho/sesotho.dart';
import 'package:funding/pastPapers/grade11IEB/Setswana/setswana.dart';
import 'package:funding/pastPapers/grade11IEB/Siswati/siswati.dart';
import 'package:funding/pastPapers/grade11IEB/SouthAfricanSignLanguage/sign.dart';
import 'package:funding/pastPapers/grade11IEB/TechnicalMathematics/technicalMath.dart';
import 'package:funding/pastPapers/grade11IEB/TechnicalSciences/technicalScience.dart';
import 'package:funding/pastPapers/grade11IEB/Tourism/tourism.dart';
import 'package:funding/pastPapers/grade11IEB/Tshivenda/tshivenda.dart';
import 'package:funding/pastPapers/grade11IEB/VisualArts/visualArts.dart';
import 'package:funding/pastPapers/grade11IEB/Xitsonga/xitsonga.dart';

class Grade11IEBPage extends StatelessWidget {
  const Grade11IEBPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Grade11HomePage()),
            );
          },
        ),
        title: const Text("IEB SUBJECTS"),
        backgroundColor: Colors.teal,
        centerTitle: true,
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'BUSINESS STUDIES',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const BusinessStudiesGrade11Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'CONSUMER STUDIES',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ConsumerStudiesGrade11Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'ENGLISH',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EnglishGrade11Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'GEOGRAPHY',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const GeographyGrade11Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'HISTORY',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const HistoryGrade11Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'isiZULU',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const IsiZuluGrade11Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'LIFE SCIENCE',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const LifeSciencesGrade11Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'MATHEMATICAL LITERACY',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const MathematicalLiteracyGrade11Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'MATHEMATICS',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MathsGrade11Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'PHYSICAL SCIENCE',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const PhysicalSciencesGrade11Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'VISUAL ARTS',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const VisualArtsGrade11Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Custom Button Widget
  Widget _buildCustomButton({
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double
          .infinity, // Makes the button stretch across the width of the screen
      height: 60, // Ensures all buttons have the same height
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 10,
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding:
              const EdgeInsets.symmetric(horizontal: 24), // Padding for content
        ),
        child: FittedBox(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(width: 10),
              Text(
                label,
                style: const TextStyle(
                  fontSize: 22,
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  overflow:
                      TextOverflow.ellipsis, // Handles overflow gracefully
                ),
                maxLines: 1, // Ensures text stays on one line
              ),
            ],
          ),
        ),
      ),
    );
  }
}
