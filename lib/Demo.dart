// main.dart
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:convert';
import 'dart:math';

void main() {
  runApp(CountryFlagQuizApp());
}

class CountryFlagQuizApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Country Flag Quiz',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Roboto',
      ),
      home: QuizScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

// MODEL
class Country {
  final String name;
  final String flagUrl;

  Country({required this.name, required this.flagUrl});

  factory Country.fromJson(Map<String, dynamic> json) {
    return Country(
      name: json['name'],
      flagUrl: json['flagUrl'],
    );
  }
}

class QuizQuestion {
  final Country correctAnswer;
  final List<Country> options;
  final String flagUrl;

  QuizQuestion({
    required this.correctAnswer,
    required this.options,
    required this.flagUrl,
  });
}

// CONTROLLER
class QuizController {
  List<Country> _countries = [];
  QuizQuestion? _currentQuestion;
  int _score = 0;
  int _questionNumber = 0;
  int _totalQuestions = 10;
  final Random _random = Random();

  // Getters
  List<Country> get countries => _countries;
  QuizQuestion? get currentQuestion => _currentQuestion;
  int get score => _score;
  int get questionNumber => _questionNumber;
  int get totalQuestions => _totalQuestions;
  bool get isQuizComplete => _questionNumber >= _totalQuestions;

  // Initialize countries from JSON
  void initializeCountries() {
    const String jsonString = '''
[
  {"name": "Aruba", "flagUrl": "https://flagcdn.com/w320/aw.png"},
  {"name": "Afghanistan", "flagUrl": "https://flagcdn.com/w320/af.png"},
  {"name": "Angola", "flagUrl": "https://flagcdn.com/w320/ao.png"},
  {"name": "Anguilla", "flagUrl": "https://flagcdn.com/w320/ai.png"},
  {"name": "Åland Islands", "flagUrl": "https://flagcdn.com/w320/ax.png"},
  {"name": "Albania", "flagUrl": "https://flagcdn.com/w320/al.png"},
  {"name": "Andorra", "flagUrl": "https://flagcdn.com/w320/ad.png"},
  {"name": "United Arab Emirates", "flagUrl": "https://flagcdn.com/w320/ae.png"},
  {"name": "Argentina", "flagUrl": "https://flagcdn.com/w320/ar.png"},
  {"name": "Armenia", "flagUrl": "https://flagcdn.com/w320/am.png"},
  {"name": "American Samoa", "flagUrl": "https://flagcdn.com/w320/as.png"},
  {"name": "Antarctica", "flagUrl": "https://flagcdn.com/w320/aq.png"},
  {"name": "French Southern Territories", "flagUrl": "https://flagcdn.com/w320/tf.png"},
  {"name": "Antigua and Barbuda", "flagUrl": "https://flagcdn.com/w320/ag.png"},
  {"name": "Australia", "flagUrl": "https://flagcdn.com/w320/au.png"},
  {"name": "Austria", "flagUrl": "https://flagcdn.com/w320/at.png"},
  {"name": "Azerbaijan", "flagUrl": "https://flagcdn.com/w320/az.png"},
  {"name": "Burundi", "flagUrl": "https://flagcdn.com/w320/bi.png"},
  {"name": "Belgium", "flagUrl": "https://flagcdn.com/w320/be.png"},
  {"name": "Benin", "flagUrl": "https://flagcdn.com/w320/bj.png"},
  {"name": "Bonaire, Sint Eustatius and Saba", "flagUrl": "https://flagcdn.com/w320/bq.png"},
  {"name": "Burkina Faso", "flagUrl": "https://flagcdn.com/w320/bf.png"},
  {"name": "Bangladesh", "flagUrl": "https://flagcdn.com/w320/bd.png"},
  {"name": "Bulgaria", "flagUrl": "https://flagcdn.com/w320/bg.png"},
  {"name": "Bahrain", "flagUrl": "https://flagcdn.com/w320/bh.png"},
  {"name": "Bahamas", "flagUrl": "https://flagcdn.com/w320/bs.png"},
  {"name": "Bosnia and Herzegovina", "flagUrl": "https://flagcdn.com/w320/ba.png"},
  {"name": "Saint Barthélemy", "flagUrl": "https://flagcdn.com/w320/bl.png"},
  {"name": "Belarus", "flagUrl": "https://flagcdn.com/w320/by.png"},
  {"name": "Belize", "flagUrl": "https://flagcdn.com/w320/bz.png"},
  {"name": "Bermuda", "flagUrl": "https://flagcdn.com/w320/bm.png"},
  {"name": "Bolivia, Plurinational State of", "flagUrl": "https://flagcdn.com/w320/bo.png"},
  {"name": "Brazil", "flagUrl": "https://flagcdn.com/w320/br.png"},
  {"name": "Barbados", "flagUrl": "https://flagcdn.com/w320/bb.png"},
  {"name": "Brunei Darussalam", "flagUrl": "https://flagcdn.com/w320/bn.png"},
  {"name": "Bhutan", "flagUrl": "https://flagcdn.com/w320/bt.png"},
  {"name": "Bouvet Island", "flagUrl": "https://flagcdn.com/w320/bv.png"},
  {"name": "Botswana", "flagUrl": "https://flagcdn.com/w320/bw.png"},
  {"name": "Central African Republic", "flagUrl": "https://flagcdn.com/w320/cf.png"},
  {"name": "Canada", "flagUrl": "https://flagcdn.com/w320/ca.png"},
  {"name": "Cocos (Keeling) Islands", "flagUrl": "https://flagcdn.com/w320/cc.png"},
  {"name": "Switzerland", "flagUrl": "https://flagcdn.com/w320/ch.png"},
  {"name": "Chile", "flagUrl": "https://flagcdn.com/w320/cl.png"},
  {"name": "China", "flagUrl": "https://flagcdn.com/w320/cn.png"},
  {"name": "Côte d'Ivoire", "flagUrl": "https://flagcdn.com/w320/ci.png"},
  {"name": "Cameroon", "flagUrl": "https://flagcdn.com/w320/cm.png"},
  {"name": "Congo, The Democratic Republic of the", "flagUrl": "https://flagcdn.com/w320/cd.png"},
  {"name": "Congo", "flagUrl": "https://flagcdn.com/w320/cg.png"},
  {"name": "Cook Islands", "flagUrl": "https://flagcdn.com/w320/ck.png"},
  {"name": "Colombia", "flagUrl": "https://flagcdn.com/w320/co.png"},
  {"name": "Comoros", "flagUrl": "https://flagcdn.com/w320/km.png"},
  {"name": "Cabo Verde", "flagUrl": "https://flagcdn.com/w320/cv.png"},
  {"name": "Costa Rica", "flagUrl": "https://flagcdn.com/w320/cr.png"},
  {"name": "Cuba", "flagUrl": "https://flagcdn.com/w320/cu.png"},
  {"name": "Curaçao", "flagUrl": "https://flagcdn.com/w320/cw.png"},
  {"name": "Christmas Island", "flagUrl": "https://flagcdn.com/w320/cx.png"},
  {"name": "Cayman Islands", "flagUrl": "https://flagcdn.com/w320/ky.png"},
  {"name": "Cyprus", "flagUrl": "https://flagcdn.com/w320/cy.png"},
  {"name": "Czechia", "flagUrl": "https://flagcdn.com/w320/cz.png"},
  {"name": "Germany", "flagUrl": "https://flagcdn.com/w320/de.png"},
  {"name": "Djibouti", "flagUrl": "https://flagcdn.com/w320/dj.png"},
  {"name": "Dominica", "flagUrl": "https://flagcdn.com/w320/dm.png"},
  {"name": "Denmark", "flagUrl": "https://flagcdn.com/w320/dk.png"},
  {"name": "Dominican Republic", "flagUrl": "https://flagcdn.com/w320/do.png"},
  {"name": "Algeria", "flagUrl": "https://flagcdn.com/w320/dz.png"},
  {"name": "Ecuador", "flagUrl": "https://flagcdn.com/w320/ec.png"},
  {"name": "Egypt", "flagUrl": "https://flagcdn.com/w320/eg.png"},
  {"name": "Eritrea", "flagUrl": "https://flagcdn.com/w320/er.png"},
  {"name": "Western Sahara", "flagUrl": "https://flagcdn.com/w320/eh.png"},
  {"name": "Spain", "flagUrl": "https://flagcdn.com/w320/es.png"},
  {"name": "Estonia", "flagUrl": "https://flagcdn.com/w320/ee.png"},
  {"name": "Ethiopia", "flagUrl": "https://flagcdn.com/w320/et.png"},
  {"name": "Finland", "flagUrl": "https://flagcdn.com/w320/fi.png"},
  {"name": "Fiji", "flagUrl": "https://flagcdn.com/w320/fj.png"},
  {"name": "Falkland Islands (Malvinas)", "flagUrl": "https://flagcdn.com/w320/fk.png"},
  {"name": "France", "flagUrl": "https://flagcdn.com/w320/fr.png"},
  {"name": "Faroe Islands", "flagUrl": "https://flagcdn.com/w320/fo.png"},
  {"name": "Micronesia, Federated States of", "flagUrl": "https://flagcdn.com/w320/fm.png"},
  {"name": "Gabon", "flagUrl": "https://flagcdn.com/w320/ga.png"},
  {"name": "United Kingdom", "flagUrl": "https://flagcdn.com/w320/gb.png"},
  {"name": "Georgia", "flagUrl": "https://flagcdn.com/w320/ge.png"},
  {"name": "Guernsey", "flagUrl": "https://flagcdn.com/w320/gg.png"},
  {"name": "Ghana", "flagUrl": "https://flagcdn.com/w320/gh.png"},
  {"name": "Gibraltar", "flagUrl": "https://flagcdn.com/w320/gi.png"},
  {"name": "Guinea", "flagUrl": "https://flagcdn.com/w320/gn.png"},
  {"name": "Guadeloupe", "flagUrl": "https://flagcdn.com/w320/gp.png"},
  {"name": "Gambia", "flagUrl": "https://flagcdn.com/w320/gm.png"},
  {"name": "Guinea-Bissau", "flagUrl": "https://flagcdn.com/w320/gw.png"},
  {"name": "Equatorial Guinea", "flagUrl": "https://flagcdn.com/w320/gq.png"},
  {"name": "Greece", "flagUrl": "https://flagcdn.com/w320/gr.png"},
  {"name": "Grenada", "flagUrl": "https://flagcdn.com/w320/gd.png"},
  {"name": "Greenland", "flagUrl": "https://flagcdn.com/w320/gl.png"},
  {"name": "Guatemala", "flagUrl": "https://flagcdn.com/w320/gt.png"},
  {"name": "French Guiana", "flagUrl": "https://flagcdn.com/w320/gf.png"},
  {"name": "Guam", "flagUrl": "https://flagcdn.com/w320/gu.png"},
  {"name": "Guyana", "flagUrl": "https://flagcdn.com/w320/gy.png"},
  {"name": "Hong Kong", "flagUrl": "https://flagcdn.com/w320/hk.png"},
  {"name": "Heard Island and McDonald Islands", "flagUrl": "https://flagcdn.com/w320/hm.png"},
  {"name": "Honduras", "flagUrl": "https://flagcdn.com/w320/hn.png"},
  {"name": "Croatia", "flagUrl": "https://flagcdn.com/w320/hr.png"},
  {"name": "Haiti", "flagUrl": "https://flagcdn.com/w320/ht.png"},
  {"name": "Hungary", "flagUrl": "https://flagcdn.com/w320/hu.png"},
  {"name": "Indonesia", "flagUrl": "https://flagcdn.com/w320/id.png"},
  {"name": "Isle of Man", "flagUrl": "https://flagcdn.com/w320/im.png"},
  {"name": "India", "flagUrl": "https://flagcdn.com/w320/in.png"},
  {"name": "British Indian Ocean Territory", "flagUrl": "https://flagcdn.com/w320/io.png"},
  {"name": "Ireland", "flagUrl": "https://flagcdn.com/w320/ie.png"},
  {"name": "Iran, Islamic Republic of", "flagUrl": "https://flagcdn.com/w320/ir.png"},
  {"name": "Iraq", "flagUrl": "https://flagcdn.com/w320/iq.png"},
  {"name": "Iceland", "flagUrl": "https://flagcdn.com/w320/is.png"},
  {"name": "Israel", "flagUrl": "https://flagcdn.com/w320/il.png"},
  {"name": "Italy", "flagUrl": "https://flagcdn.com/w320/it.png"},
  {"name": "Jamaica", "flagUrl": "https://flagcdn.com/w320/jm.png"},
  {"name": "Jersey", "flagUrl": "https://flagcdn.com/w320/je.png"},
  {"name": "Jordan", "flagUrl": "https://flagcdn.com/w320/jo.png"},
  {"name": "Japan", "flagUrl": "https://flagcdn.com/w320/jp.png"},
  {"name": "Kazakhstan", "flagUrl": "https://flagcdn.com/w320/kz.png"},
  {"name": "Kenya", "flagUrl": "https://flagcdn.com/w320/ke.png"},
  {"name": "Kyrgyzstan", "flagUrl": "https://flagcdn.com/w320/kg.png"},
  {"name": "Cambodia", "flagUrl": "https://flagcdn.com/w320/kh.png"},
  {"name": "Kiribati", "flagUrl": "https://flagcdn.com/w320/ki.png"},
  {"name": "Saint Kitts and Nevis", "flagUrl": "https://flagcdn.com/w320/kn.png"},
  {"name": "Korea, Republic of", "flagUrl": "https://flagcdn.com/w320/kr.png"},
  {"name": "Kuwait", "flagUrl": "https://flagcdn.com/w320/kw.png"},
  {"name": "Lao People's Democratic Republic", "flagUrl": "https://flagcdn.com/w320/la.png"},
  {"name": "Lebanon", "flagUrl": "https://flagcdn.com/w320/lb.png"},
  {"name": "Liberia", "flagUrl": "https://flagcdn.com/w320/lr.png"},
  {"name": "Libya", "flagUrl": "https://flagcdn.com/w320/ly.png"},
  {"name": "Saint Lucia", "flagUrl": "https://flagcdn.com/w320/lc.png"},
  {"name": "Liechtenstein", "flagUrl": "https://flagcdn.com/w320/li.png"},
  {"name": "Sri Lanka", "flagUrl": "https://flagcdn.com/w320/lk.png"},
  {"name": "Lesotho", "flagUrl": "https://flagcdn.com/w320/ls.png"},
  {"name": "Lithuania", "flagUrl": "https://flagcdn.com/w320/lt.png"},
  {"name": "Luxembourg", "flagUrl": "https://flagcdn.com/w320/lu.png"},
  {"name": "Latvia", "flagUrl": "https://flagcdn.com/w320/lv.png"},
  {"name": "Macao", "flagUrl": "https://flagcdn.com/w320/mo.png"},
  {"name": "Saint Martin (French part)", "flagUrl": "https://flagcdn.com/w320/mf.png"},
  {"name": "Morocco", "flagUrl": "https://flagcdn.com/w320/ma.png"},
  {"name": "Monaco", "flagUrl": "https://flagcdn.com/w320/mc.png"},
  {"name": "Moldova, Republic of", "flagUrl": "https://flagcdn.com/w320/md.png"},
  {"name": "Madagascar", "flagUrl": "https://flagcdn.com/w320/mg.png"},
  {"name": "Maldives", "flagUrl": "https://flagcdn.com/w320/mv.png"},
  {"name": "Mexico", "flagUrl": "https://flagcdn.com/w320/mx.png"},
  {"name": "Marshall Islands", "flagUrl": "https://flagcdn.com/w320/mh.png"},
  {"name": "North Macedonia", "flagUrl": "https://flagcdn.com/w320/mk.png"},
  {"name": "Mali", "flagUrl": "https://flagcdn.com/w320/ml.png"},
  {"name": "Malta", "flagUrl": "https://flagcdn.com/w320/mt.png"},
  {"name": "Myanmar", "flagUrl": "https://flagcdn.com/w320/mm.png"},
  {"name": "Montenegro", "flagUrl": "https://flagcdn.com/w320/me.png"},
  {"name": "Mongolia", "flagUrl": "https://flagcdn.com/w320/mn.png"},
  {"name": "Northern Mariana Islands", "flagUrl": "https://flagcdn.com/w320/mp.png"},
  {"name": "Mozambique", "flagUrl": "https://flagcdn.com/w320/mz.png"},
  {"name": "Mauritania", "flagUrl": "https://flagcdn.com/w320/mr.png"},
  {"name": "Montserrat", "flagUrl": "https://flagcdn.com/w320/ms.png"},
  {"name": "Martinique", "flagUrl": "https://flagcdn.com/w320/mq.png"},
  {"name": "Mauritius", "flagUrl": "https://flagcdn.com/w320/mu.png"},
  {"name": "Malawi", "flagUrl": "https://flagcdn.com/w320/mw.png"},
  {"name": "Malaysia", "flagUrl": "https://flagcdn.com/w320/my.png"},
  {"name": "Mayotte", "flagUrl": "https://flagcdn.com/w320/yt.png"},
  {"name": "Namibia", "flagUrl": "https://flagcdn.com/w320/na.png"},
  {"name": "New Caledonia", "flagUrl": "https://flagcdn.com/w320/nc.png"},
  {"name": "Niger", "flagUrl": "https://flagcdn.com/w320/ne.png"},
  {"name": "Norfolk Island", "flagUrl": "https://flagcdn.com/w320/nf.png"},
  {"name": "Nigeria", "flagUrl": "https://flagcdn.com/w320/ng.png"},
  {"name": "Nicaragua", "flagUrl": "https://flagcdn.com/w320/ni.png"},
  {"name": "Niue", "flagUrl": "https://flagcdn.com/w320/nu.png"},
  {"name": "Netherlands", "flagUrl": "https://flagcdn.com/w320/nl.png"},
  {"name": "Norway", "flagUrl": "https://flagcdn.com/w320/no.png"},
  {"name": "Nepal", "flagUrl": "https://flagcdn.com/w320/np.png"},
  {"name": "Nauru", "flagUrl": "https://flagcdn.com/w320/nr.png"},
  {"name": "New Zealand", "flagUrl": "https://flagcdn.com/w320/nz.png"},
  {"name": "Oman", "flagUrl": "https://flagcdn.com/w320/om.png"},
  {"name": "Pakistan", "flagUrl": "https://flagcdn.com/w320/pk.png"},
  {"name": "Panama", "flagUrl": "https://flagcdn.com/w320/pa.png"},
  {"name": "Pitcairn", "flagUrl": "https://flagcdn.com/w320/pn.png"},
  {"name": "Peru", "flagUrl": "https://flagcdn.com/w320/pe.png"},
  {"name": "Philippines", "flagUrl": "https://flagcdn.com/w320/ph.png"},
  {"name": "Palau", "flagUrl": "https://flagcdn.com/w320/pw.png"},
  {"name": "Papua New Guinea", "flagUrl": "https://flagcdn.com/w320/pg.png"},
  {"name": "Poland", "flagUrl": "https://flagcdn.com/w320/pl.png"},
  {"name": "Puerto Rico", "flagUrl": "https://flagcdn.com/w320/pr.png"},
  {"name": "Korea, Democratic People's Republic of", "flagUrl": "https://flagcdn.com/w320/kp.png"},
  {"name": "Portugal", "flagUrl": "https://flagcdn.com/w320/pt.png"},
  {"name": "Paraguay", "flagUrl": "https://flagcdn.com/w320/py.png"},
  {"name": "Palestine, State of", "flagUrl": "https://flagcdn.com/w320/ps.png"},
  {"name": "French Polynesia", "flagUrl": "https://flagcdn.com/w320/pf.png"},
  {"name": "Qatar", "flagUrl": "https://flagcdn.com/w320/qa.png"},
  {"name": "Réunion", "flagUrl": "https://flagcdn.com/w320/re.png"},
  {"name": "Romania", "flagUrl": "https://flagcdn.com/w320/ro.png"},
  {"name": "Russian Federation", "flagUrl": "https://flagcdn.com/w320/ru.png"},
  {"name": "Rwanda", "flagUrl": "https://flagcdn.com/w320/rw.png"},
  {"name": "Saudi Arabia", "flagUrl": "https://flagcdn.com/w320/sa.png"},
  {"name": "Sudan", "flagUrl": "https://flagcdn.com/w320/sd.png"},
  {"name": "Senegal", "flagUrl": "https://flagcdn.com/w320/sn.png"},
  {"name": "Singapore", "flagUrl": "https://flagcdn.com/w320/sg.png"},
  {"name": "South Georgia and the South Sandwich Islands", "flagUrl": "https://flagcdn.com/w320/gs.png"},
  {"name": "Saint Helena, Ascension and Tristan da Cunha", "flagUrl": "https://flagcdn.com/w320/sh.png"},
  {"name": "Svalbard and Jan Mayen", "flagUrl": "https://flagcdn.com/w320/sj.png"},
  {"name": "Solomon Islands", "flagUrl": "https://flagcdn.com/w320/sb.png"},
  {"name": "Sierra Leone", "flagUrl": "https://flagcdn.com/w320/sl.png"},
  {"name": "El Salvador", "flagUrl": "https://flagcdn.com/w320/sv.png"},
  {"name": "San Marino", "flagUrl": "https://flagcdn.com/w320/sm.png"},
  {"name": "Somalia", "flagUrl": "https://flagcdn.com/w320/so.png"},
  {"name": "Saint Pierre and Miquelon", "flagUrl": "https://flagcdn.com/w320/pm.png"},
  {"name": "Serbia", "flagUrl": "https://flagcdn.com/w320/rs.png"},
  {"name": "South Sudan", "flagUrl": "https://flagcdn.com/w320/ss.png"},
  {"name": "Sao Tome and Principe", "flagUrl": "https://flagcdn.com/w320/st.png"},
  {"name": "Suriname", "flagUrl": "https://flagcdn.com/w320/sr.png"},
  {"name": "Slovakia", "flagUrl": "https://flagcdn.com/w320/sk.png"},
  {"name": "Slovenia", "flagUrl": "https://flagcdn.com/w320/si.png"},
  {"name": "Sweden", "flagUrl": "https://flagcdn.com/w320/se.png"},
  {"name": "Eswatini", "flagUrl": "https://flagcdn.com/w320/sz.png"},
  {"name": "Sint Maarten (Dutch part)", "flagUrl": "https://flagcdn.com/w320/sx.png"},
  {"name": "Seychelles", "flagUrl": "https://flagcdn.com/w320/sc.png"},
  {"name": "Syrian Arab Republic", "flagUrl": "https://flagcdn.com/w320/sy.png"},
  {"name": "Turks and Caicos Islands", "flagUrl": "https://flagcdn.com/w320/tc.png"},
  {"name": "Chad", "flagUrl": "https://flagcdn.com/w320/td.png"},
  {"name": "Togo", "flagUrl": "https://flagcdn.com/w320/tg.png"},
  {"name": "Thailand", "flagUrl": "https://flagcdn.com/w320/th.png"},
  {"name": "Tajikistan", "flagUrl": "https://flagcdn.com/w320/tj.png"},
  {"name": "Tokelau", "flagUrl": "https://flagcdn.com/w320/tk.png"},
  {"name": "Turkmenistan", "flagUrl": "https://flagcdn.com/w320/tm.png"},
  {"name": "Timor-Leste", "flagUrl": "https://flagcdn.com/w320/tl.png"},
  {"name": "Tonga", "flagUrl": "https://flagcdn.com/w320/to.png"},
  {"name": "Trinidad and Tobago", "flagUrl": "https://flagcdn.com/w320/tt.png"},
  {"name": "Tunisia", "flagUrl": "https://flagcdn.com/w320/tn.png"},
  {"name": "Turkey", "flagUrl": "https://flagcdn.com/w320/tr.png"},
  {"name": "Tuvalu", "flagUrl": "https://flagcdn.com/w320/tv.png"},
  {"name": "Taiwan, Province of China", "flagUrl": "https://flagcdn.com/w320/tw.png"},
  {"name": "Tanzania, United Republic of", "flagUrl": "https://flagcdn.com/w320/tz.png"},
  {"name": "Uganda", "flagUrl": "https://flagcdn.com/w320/ug.png"},
  {"name": "Ukraine", "flagUrl": "https://flagcdn.com/w320/ua.png"},
  {"name": "United States Minor Outlying Islands", "flagUrl": "https://flagcdn.com/w320/um.png"},
  {"name": "Uruguay", "flagUrl": "https://flagcdn.com/w320/uy.png"},
  {"name": "United States", "flagUrl": "https://flagcdn.com/w320/us.png"},
  {"name": "Uzbekistan", "flagUrl": "https://flagcdn.com/w320/uz.png"},
  {"name": "Holy See (Vatican City State)", "flagUrl": "https://flagcdn.com/w320/va.png"},
  {"name": "Saint Vincent and the Grenadines", "flagUrl": "https://flagcdn.com/w320/vc.png"},
  {"name": "Venezuela, Bolivarian Republic of", "flagUrl": "https://flagcdn.com/w320/ve.png"},
  {"name": "Virgin Islands, British", "flagUrl": "https://flagcdn.com/w320/vg.png"},
  {"name": "Virgin Islands, U.S.", "flagUrl": "https://flagcdn.com/w320/vi.png"},
  {"name": "Viet Nam", "flagUrl": "https://flagcdn.com/w320/vn.png"},
  {"name": "Vanuatu", "flagUrl": "https://flagcdn.com/w320/vu.png"},
  {"name": "Wallis and Futuna", "flagUrl": "https://flagcdn.com/w320/wf.png"},
  {"name": "Samoa", "flagUrl": "https://flagcdn.com/w320/ws.png"},
  {"name": "Yemen", "flagUrl": "https://flagcdn.com/w320/ye.png"},
  {"name": "South Africa", "flagUrl": "https://flagcdn.com/w320/za.png"},
  {"name": "Zambia", "flagUrl": "https://flagcdn.com/w320/zm.png"},
  {"name": "Zimbabwe", "flagUrl": "https://flagcdn.com/w320/zw.png"}
]
    ''';

    List<dynamic> jsonList = json.decode(jsonString);
    _countries = jsonList.map((json) => Country.fromJson(json)).toList();
  }
  // Generate a new quiz question
  QuizQuestion generateQuestion() {
    if (_countries.isEmpty) {
      throw Exception("Countries not initialized");
    }

    // Select a random country as the correct answer
    Country correctAnswer = _countries[_random.nextInt(_countries.length)];

    // Create a list of wrong options
    List<Country> wrongOptions = [];
    List<Country> availableCountries = List.from(_countries);
    availableCountries.remove(correctAnswer);

    // Select 3 random wrong answers
    for (int i = 0; i < 3; i++) {
      if (availableCountries.isNotEmpty) {
        Country wrongOption = availableCountries[_random.nextInt(availableCountries.length)];
        wrongOptions.add(wrongOption);
        availableCountries.remove(wrongOption);
      }
    }

    // Combine correct and wrong options
    List<Country> allOptions = [correctAnswer, ...wrongOptions];

    // Shuffle the options
    allOptions.shuffle(_random);

    _currentQuestion = QuizQuestion(
      correctAnswer: correctAnswer,
      options: allOptions,
      flagUrl: correctAnswer.flagUrl,
    );

    return _currentQuestion!;
  }

  // Check if the selected answer is correct
  bool checkAnswer(Country selectedCountry) {
    return selectedCountry.name == _currentQuestion?.correctAnswer.name;
  }

  // Move to next question
  void nextQuestion() {
    _questionNumber++;
    if (!isQuizComplete) {
      generateQuestion();
    }
  }

  // Update score
  void incrementScore() {
    _score++;
  }

  // Reset quiz
  void resetQuiz() {
    _score = 0;
    _questionNumber = 0;
    _currentQuestion = null;
  }

  // Start new quiz
  void startQuiz() {
    resetQuiz();
    generateQuestion();
  }
}

// VIEW
class QuizScreen extends StatefulWidget {
  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  final QuizController _controller = QuizController();
  bool _isLoading = true;
  String? _selectedAnswer;
  bool _showResult = false;
  bool _isCorrect = false;

  @override
  void initState() {
    super.initState();
    _initializeQuiz();
  }

  void _initializeQuiz() {
    setState(() {
      _isLoading = true;
    });

    _controller.initializeCountries();
    _controller.startQuiz();

    setState(() {
      _isLoading = false;
    });
  }

  void _onAnswerSelected(Country selectedCountry) {
    if (_showResult) return;

    setState(() {
      _selectedAnswer = selectedCountry.name;
      _isCorrect = _controller.checkAnswer(selectedCountry);
      _showResult = true;
    });

    if (_isCorrect) {
      _controller.incrementScore();
    }

    // Auto move to next question after 2 seconds
    Future.delayed(Duration(seconds: 2), () {
      _nextQuestion();
    });
  }

  void _nextQuestion() {
    _controller.nextQuestion();

    if (_controller.isQuizComplete) {
      _showQuizResults();
    } else {
      setState(() {
        _selectedAnswer = null;
        _showResult = false;
        _isCorrect = false;
      });
    }
  }

  void _showQuizResults() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Quiz Complete!'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Your Score: ${_controller.score}/${_controller.totalQuestions}',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 10),
              Text(_getScoreMessage()),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _restartQuiz();
              },
              child: Text('Play Again'),
            ),
          ],
        );
      },
    );
  }

  String _getScoreMessage() {
    double percentage = (_controller.score / _controller.totalQuestions) * 100;
    if (percentage >= 80) return 'Excellent! 🎉';
    if (percentage >= 60) return 'Good job! 👍';
    if (percentage >= 40) return 'Not bad! 🙂';
    return 'Keep practicing! 💪';
  }

  void _restartQuiz() {
    setState(() {
      _selectedAnswer = null;
      _showResult = false;
      _isCorrect = false;
    });
    _controller.startQuiz();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text('Country Flag Quiz'),
        backgroundColor: Colors.blue[600],
        elevation: 0,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Progress indicator
            Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 5,
                  ),
                ],
              ),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Question ${_controller.questionNumber + 1}/${_controller.totalQuestions}',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                      Text(
                        'Score: ${_controller.score}',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  LinearProgressIndicator(
                    value: (_controller.questionNumber + 1) / _controller.totalQuestions,
                    backgroundColor: Colors.grey[300],
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24),

            // Question section
            Expanded(
              child: Column(
                children: [
                  Text(
                    'Which country does this flag belong to?',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey[800],
                    ),
                    textAlign: TextAlign.center,
                  ),

                  SizedBox(height: 24),

                  // Flag image
                  Container(
                    height: 200,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 2,
                          blurRadius: 8,
                        ),
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        _controller.currentQuestion!.flagUrl,
                        fit: BoxFit.cover,
                        loadingBuilder: (context, child, loadingProgress) {
                          if (loadingProgress == null) return child;
                          return Center(
                            child: CircularProgressIndicator(
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                                  : null,
                            ),
                          );
                        },
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            color: Colors.grey[300],
                            child: Icon(Icons.error, size: 50),
                          );
                        },
                      ),
                    ),
                  ),

                  SizedBox(height: 32),

                  // Answer options
                  Expanded(
                    child: GridView.builder(
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        childAspectRatio: 3,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                      ),
                      itemCount: _controller.currentQuestion!.options.length,
                      itemBuilder: (context, index) {
                        Country option = _controller.currentQuestion!.options[index];
                        bool isSelected = _selectedAnswer == option.name;
                        bool isCorrect = option.name == _controller.currentQuestion!.correctAnswer.name;

                        Color buttonColor = Colors.white;
                        Color textColor = Colors.grey[800]!;
                        Color borderColor = Colors.grey[300]!;

                        if (_showResult && isSelected) {
                          if (isCorrect) {
                            buttonColor = Colors.green[100]!;
                            borderColor = Colors.green;
                            textColor = Colors.green[800]!;
                          } else {
                            buttonColor = Colors.red[100]!;
                            borderColor = Colors.red;
                            textColor = Colors.red[800]!;
                          }
                        } else if (_showResult && isCorrect) {
                          buttonColor = Colors.green[100]!;
                          borderColor = Colors.green;
                          textColor = Colors.green[800]!;
                        }

                        return Material(
                          color: buttonColor,
                          borderRadius: BorderRadius.circular(8),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(8),
                            onTap: () => _onAnswerSelected(option),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: borderColor, width: 2),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(
                                    option.name,
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500,
                                      color: textColor,
                                    ),
                                    textAlign: TextAlign.center,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
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
}