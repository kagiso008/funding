import 'package:flutter/material.dart';
import 'package:funding/grades/grade10home.dart';
import 'package:funding/pages/landing_page.dart';
import 'package:funding/pages/past_papers.dart';
import 'package:funding/pastPapers/grade10IEB/Accounting/accounting.dart';
import 'package:funding/pastPapers/grade10IEB/Afrikaans/Afrikaans.dart';
import 'package:funding/pastPapers/grade10IEB/AgriculturalSciences/AgriculturalScience.dart';
import 'package:funding/pastPapers/grade10IEB/AgriculturalTechnology/AgriculturalTechnology.dart';
import 'package:funding/pastPapers/grade10IEB/BusinessStudies/businessStudies.dart';
import 'package:funding/pastPapers/grade10IEB/CivilTechnology/civilTechnology.dart';
import 'package:funding/pastPapers/grade10IEB/AgriculturalManagementPractices/AgriculturalManagementSciences.dart.dart';
import 'package:funding/pastPapers/grade10IEB/ComputerApplicationsTechnology/cat.dart';
import 'package:funding/pastPapers/grade10IEB/ConsumerStudies/consumerStudies.dart';
import 'package:funding/pastPapers/grade10IEB/DanceStudies/danceStudies.dart';
import 'package:funding/pastPapers/grade10IEB/Design/design.dart';
import 'package:funding/pastPapers/grade10IEB/DramaticArts/dramaticArts.dart';
import 'package:funding/pastPapers/grade10IEB/Economics/economics.dart';
import 'package:funding/pastPapers/grade10IEB/ElectricalTechnology/electricalTechnology.dart';
import 'package:funding/pastPapers/grade10IEB/EngineeringGraphicsAndDesign/egd.dart';
import 'package:funding/pastPapers/grade10IEB/English/english.dart';
import 'package:funding/pastPapers/grade10IEB/Geography/geography.dart';
import 'package:funding/pastPapers/grade10IEB/History/history.dart';
import 'package:funding/pastPapers/grade10IEB/HospitalityStudies/hospitalityStudies.dart';
import 'package:funding/pastPapers/grade10IEB/InformationTechnology/IT.dart';
import 'package:funding/pastPapers/grade10IEB/IsiNdebele/isiNdebele.dart';
import 'package:funding/pastPapers/grade10IEB/IsiXhosa/isiXhosa.dart';
import 'package:funding/pastPapers/grade10IEB/IsiZulu/isiZulu.dart';
import 'package:funding/pastPapers/grade10IEB/LifeOrientation/LifeOrientation.dart';
import 'package:funding/pastPapers/grade10IEB/LifeSciences/lifeSciences.dart';
import 'package:funding/pastPapers/grade10IEB/MarineSciences/marineSciences.dart';
import 'package:funding/pastPapers/grade10IEB/MathematicalLiteracy/mathsLit.dart';
import 'package:funding/pastPapers/grade10IEB/Mathematics/maths.dart';
import 'package:funding/pastPapers/grade10IEB/MechanicalTechnology/mechinalTechnology.dart';
import 'package:funding/pastPapers/grade10IEB/Music/music.dart';
import 'package:funding/pastPapers/grade10IEB/PhysicalSciences/physicalSciences.dart';
import 'package:funding/pastPapers/grade10IEB/ReligionStudies/religionStudies.dart';
import 'package:funding/pastPapers/grade10IEB/Sepedi/sepedi.dart';
import 'package:funding/pastPapers/grade10IEB/Sesotho/sesotho.dart';
import 'package:funding/pastPapers/grade10IEB/Setswana/setswana.dart';
import 'package:funding/pastPapers/grade10IEB/Siswati/siswati.dart';
import 'package:funding/pastPapers/grade10IEB/SouthAfricanSignLanguage/sign.dart';
import 'package:funding/pastPapers/grade10IEB/TechnicalMathematics/technicalMath.dart';
import 'package:funding/pastPapers/grade10IEB/TechnicalSciences/technicalScience.dart';
import 'package:funding/pastPapers/grade10IEB/Tourism/tourism.dart';
import 'package:funding/pastPapers/grade10IEB/Tshivenda/tshivenda.dart';
import 'package:funding/pastPapers/grade10IEB/VisualArts/visualArts.dart';
import 'package:funding/pastPapers/grade10IEB/Xitsonga/xitsonga.dart';

class Grade10IEBPage extends StatelessWidget {
  const Grade10IEBPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Grade10HomePage()),
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
                  label: 'ACCOUNTING',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AccountingGrade10Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'AFRIKAANS',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AfrikaansGrade10Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'BUSINESS STUDIES',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const BusinessStudiesGrade10Page()),
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
                              const ConsumerStudiesGrade10Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'DRAMATIC ARTS',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const DramaticArtsGrade10Page()),
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
                          builder: (context) => const EnglishGrade10Page()),
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
                          builder: (context) => const GeographyGrade10Page()),
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
                          builder: (context) => const HistoryGrade10Page()),
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
                          builder: (context) => const IsiZuluGrade10Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'LIFE SCIENCES',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const LifeSciencesGrade10Page()),
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
                              const MathematicalLiteracyGrade10Page()),
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
                          builder: (context) => const MathsGrade10Page()),
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

  Widget _buildCustomButton({
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: 10,
          backgroundColor: color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24),
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
