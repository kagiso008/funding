import 'package:flutter/material.dart';
import 'package:funding/grades/grade11home.dart';
import 'package:funding/pages/landing_page.dart';
import 'package:funding/pages/past_papers.dart';
import 'package:funding/pastPapers/grade11/Accounting/accounting.dart';
import 'package:funding/pastPapers/grade11/Afrikaans/Afrikaans.dart';
import 'package:funding/pastPapers/grade11/AgriculturalSciences/AgriculturalScience.dart';
import 'package:funding/pastPapers/grade11/AgriculturalTechnology/AgriculturalTechnology.dart';
import 'package:funding/pastPapers/grade11/BusinessStudies/businessStudies.dart';
import 'package:funding/pastPapers/grade11/CivilTechnology/civilTechnology.dart';
import 'package:funding/pastPapers/grade11/AgriculturalManagementPractices/AgriculturalManagementSciences.dart.dart';
import 'package:funding/pastPapers/grade11/ComputerApplicationsTechnology/cat.dart';
import 'package:funding/pastPapers/grade11/ConsumerStudies/consumerStudies.dart';
import 'package:funding/pastPapers/grade11/DanceStudies/danceStudies.dart';
import 'package:funding/pastPapers/grade11/Design/design.dart';
import 'package:funding/pastPapers/grade11/DramaticArts/dramaticArts.dart';
import 'package:funding/pastPapers/grade11/Economics/economics.dart';
import 'package:funding/pastPapers/grade11/ElectricalTechnology/electricalTechnology.dart';
import 'package:funding/pastPapers/grade11/EngineeringGraphicsAndDesign/egd.dart';
import 'package:funding/pastPapers/grade11/English/english.dart';
import 'package:funding/pastPapers/grade11/Geography/geography.dart';
import 'package:funding/pastPapers/grade11/History/history.dart';
import 'package:funding/pastPapers/grade11/HospitalityStudies/hospitalityStudies.dart';
import 'package:funding/pastPapers/grade11/InformationTechnology/IT.dart';
import 'package:funding/pastPapers/grade11/IsiNdebele/isiNdebele.dart';
import 'package:funding/pastPapers/grade11/IsiXhosa/isiXhosa.dart';
import 'package:funding/pastPapers/grade11/IsiZulu/isiZulu.dart';
import 'package:funding/pastPapers/grade11/LifeOrientation/LifeOrientation.dart';
import 'package:funding/pastPapers/grade11/LifeSciences/lifeSciences.dart';
import 'package:funding/pastPapers/grade11/MarineSciences/marineSciences.dart';
import 'package:funding/pastPapers/grade11/MathematicalLiteracy/mathsLit.dart';
import 'package:funding/pastPapers/grade11/Mathematics/maths.dart';
import 'package:funding/pastPapers/grade11/MechanicalTechnology/mechinalTechnology.dart';
import 'package:funding/pastPapers/grade11/Music/music.dart';
import 'package:funding/pastPapers/grade11/PhysicalSciences/physicalSciences.dart';
import 'package:funding/pastPapers/grade11/ReligionStudies/religionStudies.dart';
import 'package:funding/pastPapers/grade11/Sepedi/sepedi.dart';
import 'package:funding/pastPapers/grade11/Sesotho/sesotho.dart';
import 'package:funding/pastPapers/grade11/Setswana/setswana.dart';
import 'package:funding/pastPapers/grade11/Siswati/siswati.dart';
import 'package:funding/pastPapers/grade11/SouthAfricanSignLanguage/sign.dart';
import 'package:funding/pastPapers/grade11/TechnicalMathematics/technicalMath.dart';
import 'package:funding/pastPapers/grade11/TechnicalSciences/technicalScience.dart';
import 'package:funding/pastPapers/grade11/Tourism/tourism.dart';
import 'package:funding/pastPapers/grade11/Tshivenda/tshivenda.dart';
import 'package:funding/pastPapers/grade11/VisualArts/visualArts.dart';
import 'package:funding/pastPapers/grade11/Xitsonga/xitsonga.dart';

class Grade11Page extends StatelessWidget {
  const Grade11Page({super.key});

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
        title: const Text("NSC SUBJECTS"),
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
                          builder: (context) => const AccountingGrade11Page()),
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
                          builder: (context) => const AfrikaansGrade11Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'AGRICULTURAL SCIENCE',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const AgriculturalScienceGrade11Page()),
                    );
                  },
                ),
                /*const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'AGRICULTURAL MANAGEMENT PRACTICES',
                  
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const AgriculturalManagementPractices()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'AGRICULTURAL TECHNOLOGY',
                  
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const AgriculturalTechnologyGrade11Page()),
                    );
                  },
                ),*/
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
                  label: 'CIVIL TECNOLOGY',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const CivilTechnologyGrade11Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'COMPUTER APPLICATIONS TECHNOLOGY',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CATGrade11Page()),
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
                  label: 'DANCE STUDIES',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const DanceStudiesGrade11Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'DESIGN',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const DesignGrade11Page()),
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
                              const DramaticArtsGrade11Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'ECONOMICS',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EconomicsGrade11Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'ELECTRICAL TECHNOLOGY',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ElectricalTechnologyGrade11Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'ENGINEERING GRAPHICS AND DESIGN',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const EGDGrade11Page()),
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
                  label: 'HOSPITALITY STUDIES',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const HospitalityStudiesGrade11Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'INFORMATION TECHNOLOGY',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ITGrade11Page()),
                    );
                  },
                ),
                /*const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'isiNDEBELE',
                  
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const IsiNdebeleGrade11Page()),
                    );
                  },
                ),*/
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'isiXHOSA',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const IsiXhosaGrade11Page()),
                    );
                  },
                ),
                /*const SizedBox(height: 50),
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
                ),*/
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'LIFE ORIENTATION',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const LifeOrientationGrade11Page()),
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
                /*const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'MARINE SCIENCE',
                  
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const MarineSciencesGrade11Page()),
                    );
                  },
                ),*/
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
                  label: 'MECHANICAL TECHNOLOGY',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const MechanicalTechnologyGrade11Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'MUSIC',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MusicGrade11Page()),
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
                  label: 'RELIGION STUDIES',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const ReligionStudiesGrade11Page()),
                    );
                  },
                ),
                /*const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'SEPEDI',
                  
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SepediGrade11Page()),
                    );
                  },
                ),*/
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'SESOTHO',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SesothoGrade11Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'SETSWANA',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SetswanaGrade11Page()),
                    );
                  },
                ),
                /*const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'SISWATI',
                  
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SiswatiGrade11Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'SOUTH AFRICAN SIGN LANGUAGE',
                  
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const SASLGrade11Page()),
                    );
                  },
                ),*/
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'TECHNICAL MATHEMATICS',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const TechnicalMathsGrade11Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'TECHNICAL SCIENCES',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              const TechnicalScienceGrade11Page()),
                    );
                  },
                ),
                const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'TOURISM',
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TourismGrade11Page()),
                    );
                  },
                ),
                /*const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'TSHIVENDA',
                  
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const TshivendaGrade11Page()),
                    );
                  },
                ),*/
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
                /*const SizedBox(height: 50),
                _buildCustomButton(
                  label: 'XITSONGA',
                  
                  color: Colors.teal,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const XitsongaGrade11Page()),
                    );
                  },
                ),*/
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
