import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:sem5project/constants.dart';
import 'package:sem5project/screens/bottom_navigation_page.dart';
import 'package:sem5project/screens/quiz/quizscreen.dart';

class FreeTestPage extends StatefulWidget {
  const FreeTestPage({super.key});

  @override
  State<FreeTestPage> createState() => _FreeTestPageState();
}

class _FreeTestPageState extends State<FreeTestPage> {
  List<Map> maths = [
    {
      "id": 1,
      "question":
          "The marked price of mustard oil is 25% more than its cost price. At what percentage less than the marked price should it be sold to have no profit and no loss ? ",
      "options": ['15%', '20%', '18%', '22%'],
      "answer_index": 1,
    },
    {
      "id": 2,
      "question":
          "As part of his journey, a person travels 120 km at 80 km/h, the next 100 km at 40 km/h,and comes back to the starting point at 75 km/h. The average speed of the person throughout the journey (approximately) is:",
      "options": ['63.46 km/h', '58.74 km/h', '68.15 km/h', '49.58 km/h'],
      "answer_index": 0,
    },
    {
      "id": 3,
      "question": "If sin(a+b)=1 and cos(a-b)=1/2 , then find a.",
      "options": ['75°', '30°', '15°', '45°'],
      "answer_index": 0,
    },
    {
      "id": 4,
      "question":
          "Two concentric circles are of radii 10 cm and 6 cm. Find the length of the chord of the larger circle which touches the smaller circle.",
      "options": ['8 cm', '16 cm', '12 cm', '9 cm'],
      "answer_index": 1,
    },
    {
      "id": 5,
      "question":
          "A train 900 m long is running at 108 km/h. How long will it take to clear a 900 m long platform completely ?",
      "options": ['60 s ', '45 s', '30 s', '18 s'],
      "answer_index": 0,
    },
    {
      "id": 6,
      "question":
          "If m∠C=m∠Z and AC=XZ, then which of the following conditions is necessary for ΔABC and ΔXYZ to be congruent ?",
      "options": ['AB=AC', 'BC=YZ', 'AB=XY', 'BC=AB'],
      "answer_index": 1,
    },
    {
      "id": 7,
      "question":
          "In what time will ₹10,000 at 4% per annum, produce the same interest as ₹8,000 does in 4 years at 5% simple interest ?",
      "options": ['5 years', '3 years', '4 years', '6 years'],
      "answer_index": 2,
    },
    {
      "id": 8,
      "question":
          "A man, a boy and a woman can finish a work in 10 days, 15 days and 30 days,respectively. In how many days can the work be finished by a man, a woman and a boy when all of them work together ?",
      "options": ['10', '5', '8', '6'],
      "answer_index": 1,
    },
    {
      "id": 9,
      "question":
          "f the four numbers, 39, 117, 17 and y are in proportion, then find the value of y.",
      "options": ['49', '51', '57', '85'],
      "answer_index": 1,
    },
    {
      "id": 10,
      "question":
          "f {(3 sin θ - cos θ) / (cos θ + sin θ)} = 1, then the value of cot θ is:",
      "options": ['3', '0', '1', '2'],
      "answer_index": 2,
    },
    {
      "id": 11,
      "question":
          "What will be the remainder when (265)4081+9 is divided by 266?",
      "options": ['8', '6', '1', '9'],
      "answer_index": 0,
    },
    {
      "id": 12,
      "question": "The product of 277 and 323 is : ",
      "options": ['89471', '88471', '91371', '89391'],
      "answer_index": 0,
    },
    {
      "id": 13,
      "question":
          "The sum of the two number is 98.the difference between the two number is 28.find one of the two numbers.",
      "options": ['32', '62', '58', '35'],
      "answer_index": 3,
    },
    {
      "id": 14,
      "question":
          "Which of the numbers 9592450, 9592330, 9592885, 9592741 is divisible by 11 ?",
      "options": ['9592885', '9592741', '9592450', '9592330'],
      "answer_index": 3,
    },
    {
      "id": 15,
      "question":
          "What is the number of common tangents that can be drawn to two circle that touch each other externally ? ",
      "options": ['2', '4', '3', '1'],
      "answer_index": 2,
    },
  ];

  List<Map> reasoning = [
    {
      "id": 1,
      "question":
          "Ganesh was taking a walk with his mother's brother's father's granddaughter. Who was he walking with ?",
      "options": ['Daughter', 'Mother', 'Cousin', 'Granddaughter'],
      "answer_index": 2,
    },
    {
      "id": 2,
      "question":
          "Which of the following letter-clusters will replace the question mark (?) in the given series ? UV, OY, IB, EE ?",
      "options": ['ZK', 'AH', 'BI', 'BH'],
      "answer_index": 1,
    },
    {
      "id": 3,
      "question":
          "The second number in the given number-pairs is obtained by performing certain mathematical operation(s) on the first number. The same operation(s) is/are followed in all the number-pairs except one. Find that odd number-pair.",
      "options": ['20:11', '6:4', '15:9', '12:7'],
      "answer_index": 2,
    },
    {
      "id": 4,
      "question":
          "Four letter-clusters have been given, out of which three are alike in some manner and one is different. Select the odd letter-cluster.",
      "options": ['BFJN', 'DHLP', 'HJKP', 'JNRV'],
      "answer_index": 2,
    },
    {
      "id": 5,
      "question":
          "Which of the following numbers will replace the question mark (?) in the given series? 8, 15, 26, ? , 56, 75",
      "options": ['39', '41', '35', '43'],
      "answer_index": 0,
    },
    {
      "id": 6,
      "question":
          "In a certain code language, 'ASK' is written as '62' and 'BYE' is written as '64'. How will 'CRY' be written in that language ?",
      "options": ['68', '72', '86', '92'],
      "answer_index": 3,
    },
    {
      "id": 7,
      "question":
          "Select the correct combination of mathematical signs that can sequentially replace the * signs and balance the given equation.256 * 4 * 9 * 3 * 14 = 51",
      "options": ['*+-/', '/*-+', '*/+-', '/-*+'],
      "answer_index": 3,
    },
    {
      "id": 8,
      "question":
          "In a certain code language, 'TABLE' is coded as ELEAT and 'SWING' is coded as GNLWS. How will 'FRAME' be coded in the same language ?",
      "options": ['EMERF', 'EMDRF', 'ERMDF', 'MEDFR'],
      "answer_index": 1,
    },
    {
      "id": 9,
      "question":
          "Which two signs should be interchanged to make the given equation correct ? 588 ÷ 28 * 32 + 72 - 160 = 760",
      "options": ['- and +', '/ and -', '+ and *', '/ and +'],
      "answer_index": 0,
    },
    {
      "id": 10,
      "question":
          "Looking at the family picture, Sneha said, She is my brother's wife's son's father's mother-in-law's only daughter.how is the girl in the photo related to sneha ?",
      "options": ['Daughter-in-law', 'Brother wife', 'Mother', 'Sister'],
      "answer_index": 1,
    },
    {
      "id": 11,
      "question":
          "In a certain code language, 'BOOK' is written as '325', 'READ' is written as '400'. How will 'ABLE' be written in that language ?",
      "options": ['445', '440', '442', '438'],
      "answer_index": 1,
    },
    {
      "id": 12,
      "question":
          "Select the option that is related to the third term in the same way as the second term is related to the first term and sixth term is related to the fifth term. ",
      "options": ['248', '284', '244', '288'],
      "answer_index": 0,
    },
    {
      "id": 13,
      "question":
          "Amil points towards to a girl and says she is his only daughter's father's paternal grandmother's granddaughter.Amil's father has no sibilings.How is the girl related to Amil ?",
      "options": ['Granddaughter', 'Sister', 'Paternal Grandmother', 'Mother'],
      "answer_index": 1,
    },
    {
      "id": 14,
      "question":
          "In a certain code language,'BREAD' is coded as RBBDA and 'FLOUR' is coded as LFLRU.How will 'PAINT' be coded in the same language ?",
      "options": ['AFPTN', 'APLTN', 'NTFAP', 'APFTN'],
      "answer_index": 3,
    },
    {
      "id": 15,
      "question":
          "which two signs should be interchanged to make the given equation correct ?",
      "options": ['+ and +', '/ and -', '+ and *', '- and +'],
      "answer_index": 0,
    },
  ];

  List<Map> english = [
    {
      "id": 1,
      "question":
          "The following sentence has been split into four segments. Identify the segment that contains an error.Neetu have been / waiting for me / since 10 o'clock / in the morning.",
      "options": [
        'Neetu have been',
        'in the morning',
        'since 10 oclock',
        'waiting for me'
      ],
      "answer_index": 0,
    },
    {
      "id": 2,
      "question":
          "Select the most appropriate ANTONYM of the underlined word.Her dog can climb under the fence.",
      "options": ['Over', 'Sink', 'Behind', 'Beneath'],
      "answer_index": 0,
    },
    {
      "id": 3,
      "question":
          "Select the option that can be used as a one-word substitute for the given group of words.A thing fit to eat.",
      "options": ['Eligible', 'Digestible', 'Curable', 'Edible'],
      "answer_index": 3,
    },
    {
      "id": 4,
      "question":
          "Select the most appropriate meaning of the given idiom. Zealous",
      "options": ['Enthusiastic', 'Detached', 'Apathetic', 'Indifferent'],
      "answer_index": 0,
    },
    {
      "id": 5,
      "question":
          "Select the most appropriate synonym of the given word. Feeble",
      "options": ['Unheedful', 'Strong', 'Weak', 'Baneful'],
      "answer_index": 2,
    },
    {
      "id": 6,
      "question":
          "Select the correct spelling of the single quoted word.They denied having any 'associasion' with the terrorists.",
      "options": ['asociation', 'asocciation', 'assosiation', 'association'],
      "answer_index": 3,
    },
    {
      "id": 7,
      "question":
          "Select the most appropriate option to fill in the blank.She is _________ a peacock in the blue satin saree.",
      "options": [
        'very beautiful as',
        'so beautiful as',
        'as beautiful as',
        'as beautiful as'
      ],
      "answer_index": 2,
    },
    {
      "id": 8,
      "question": "Select the INCORRECTLY spelt word.",
      "options": ['Aristocrate', 'Advertise', 'Occurence', 'Preference'],
      "answer_index": 0,
    },
    {
      "id": 9,
      "question": "Select the misspelt word.",
      "options": ['foreiner', 'conjure', 'summon', 'intrigue'],
      "answer_index": 0,
    },
    {
      "id": 10,
      "question":
          "Select the most appropriate one-word substitution for the given words.A close-fitting cover for a sword.",
      "options": ['Shank', 'Sheath', 'Quiver', 'Dagger'],
      "answer_index": 2,
    },
    {
      "id": 11,
      "question":
          "Select the most appropriate option to fill in the blank.______ you mind lending me your book for a day?",
      "options": ['Would', 'Need', 'May', 'Could'],
      "answer_index": 0,
    },
    {
      "id": 12,
      "question":
          "Select the most appropriate one-word substitution for the given words.A government by the nobles",
      "options": ['Monarchy', 'Democracy', 'Oligarchy', 'Aristocracy'],
      "answer_index": 3,
    },
    {
      "id": 13,
      "question":
          "The petition before the court prayed for ____________ the appointment orders issued by the management.",
      "options": ['removing', 'granting', 'posting', 'quashing'],
      "answer_index": 3,
    },
    {
      "id": 14,
      "question": "The long list of words for any language is termed as:",
      "options": ['Morpheme', 'Phoneme', 'Lexicon', 'Pragmatics'],
      "answer_index": 3,
    },
    {
      "id": 15,
      "question":
          "'Study of human development'.Select the word which means the same as the group of words given.",
      "options": ['Philology', 'Theology', 'Acoustics', 'Anthropology'],
      "answer_index": 3,
    },
  ];

  List<Map> gk = [
    {
      "id": 1,
      "question": "The first mid-term elections for Lok Sabha were held in - ",
      "options": ['1971', '1975', '1976', '1985'],
      "answer_index": 0,
    },
    {
      "id": 2,
      "question": "Finance bill of Indian Government is presented in -",
      "options": ['Upper House', 'Middle House', 'Lower House', 'Raw House'],
      "answer_index": 2,
    },
    {
      "id": 3,
      "question": "The first British viceroy of India -",
      "options": ['Lord Kargen', 'Lord Irvin', 'Lord Cannon', 'Lord Tom'],
      "answer_index": 2,
    },
    {
      "id": 4,
      "question": "Father of Indian space program ?",
      "options": [
        'Rajesh Sharma',
        'Ashutosh Verma',
        'Vikram Sarabhai',
        'Mohan Pandey'
      ],
      "answer_index": 2,
    },
    {
      "id": 5,
      "question": "City of festivals ?",
      "options": ['Madurai', 'Varanasi', 'Jaipur', 'Nagpur'],
      "answer_index": 0,
    },
    {
      "id": 6,
      "question": "Study of insects is known as -",
      "options": ['Astrology', 'Emetology', 'Entomology', 'Geology'],
      "answer_index": 2,
    },
    {
      "id": 7,
      "question": "'AFP' is the news agency of ____.",
      "options": ['UK', 'USA', 'Germany', 'None of these'],
      "answer_index": 3,
    },
    {
      "id": 8,
      "question":
          "Which of the following represents the year in which Alexander invaded India ?",
      "options": ['323 BC', '324 BC', '326 BC', '328 BC'],
      "answer_index": 2,
    },
    {
      "id": 9,
      "question": "The highest producer of milk in the world is _____.",
      "options": ['USA', 'China', 'India', 'Germany'],
      "answer_index": 2,
    },
    {
      "id": 10,
      "question": "Bleaching powder is used in drinking water as a/an -",
      "options": ['Coagulant', 'Disinfectant', 'Anticeptic', 'Antibiotic'],
      "answer_index": 1,
    },
    {
      "id": 11,
      "question": "What is the ratio of RBC to WBC -",
      "options": ['1:600', '600:1', '1:900', '500:1'],
      "answer_index": 1,
    },
    {
      "id": 12,
      "question": "Which city is known as the Silicon valley of India ?",
      "options": ['Mumbai', 'Delhi', 'Hyderabad', 'Bengaluru'],
      "answer_index": 3,
    },
    {
      "id": 13,
      "question": "Which disease is caused by the bite of a mad dog ?",
      "options": ['Lukoderma', 'Hydrophobia', 'Hypertension', 'Arthritis'],
      "answer_index": 1,
    },
    {
      "id": 14,
      "question": "Which planet is known as the Earth's twin ?",
      "options": ['Jupiter', 'Mars', 'Venus', 'Saturn'],
      "answer_index": 2,
    },
    {
      "id": 15,
      "question":
          "Which article is related to the special status of Jammu and Kashmir ?",
      "options": ['370', '300', '110', '470'],
      "answer_index": 0,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Text("MOCK TEST",
            style: TextStyle(
                fontFamily: "poppins",
                fontSize: 20.sp,
                fontWeight: FontWeight.bold)),
      ),
      body: WillPopScope(
        onWillPop: () => OnBackPressed(),
        child: Column(
          children: [
            SizedBox(
              height: 10.h,
            ),
            IconTextContainer(
              "LogoImages/maths.png",
              "Mathematics",
              () {
                Get.offAll(QuizScreen(maths));
              },
            ),
            IconTextContainer(
              "LogoImages/problem-solving.png",
              "Reasoning",
              () {
                Get.offAll(QuizScreen(reasoning));
              },
            ),
            IconTextContainer(
              "LogoImages/eng.png",
              "English",
              () {
                Get.offAll(QuizScreen(english));
              },
            ),
            IconTextContainer(
              "LogoImages/book.png",
              "GS / GK",
              () {
                Get.offAll(QuizScreen(english));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget IconTextContainer(String img, String text, Function() onpress) {
    return Container(
      height: 95.h,
      child: GestureDetector(
        onTap: () {
          onpress();
        },
        child: Card(
          semanticContainer: true,
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: Row(
            children: [
              SizedBox(
                width: 20.w,
              ),
              Container(
                width: 50.w,
                height: 50.h,
                decoration: BoxDecoration(
                    image: DecorationImage(image: AssetImage(img))),
              ),
              SizedBox(
                width: 25.w,
              ),
              Text(
                text,
                style: TextStyle(
                    fontWeight: FontWeight.w500,
                    fontSize: 24.sp,
                    fontFamily: "poppins"),
              )
            ],
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: EdgeInsets.all(10),
        ),
      ),
    );
  }

  OnBackPressed() {
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => BottomNavigationPage(),));
  }
}