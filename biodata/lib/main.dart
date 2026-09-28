import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Biodata',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(fontFamily: 'Times New Roman'),
      home: const BioDataPage(),
    );
  }
}


const personalDetails = <String, String>{
  'Name': 'Mark Lorenz S. Almocera',
  'Mobile No': '+639628429433',
  'Email ID': 'l.almocera23@gmail.com',
  'Gender': 'Male',
  'Date of birth': 'November 23, 1997',
  'Nationality': 'Filipino',
  'Religion': 'Roman Catholic',
  "Father's name": 'Franco P. Almocera',
  "Mother's name": 'Cristiline S. Almocera',
  'Languages Known': 'English, Filipino, Hinigaynon',
  'Hobbies': 'Reading, Basketball, E-Games, Chess, Computer Games',
  'Address': 'Blk 30 lot 6 Daisy St. NBBS Proper, Navotas city, Metro Manila',
};

/// (level, school, year of passing)
const education = <(String, String, String)>[
  ('Elementary', 'North Bay Boulevard South Elementary School', '2003-2008'),
  ('Junior High School', 'Kaunlaran Junior High School', '2014-2022'),
  ('Senior High School', 'Kaunlaran Junior High School', '2022-2024'),
  ('College', 'Global Reciprocal Colleges', '2024 up to present'),
];

/// (company name, position, work period)
const workExperience = <(String, String, String)>[
  ('Burger King', 'Super Visor', '2020 - 2022'),
  ('Burger King', 'Team Member', '2016 - 2020'),
];

const place = 'Navotas city';
const date = 'September 28, 2026';

// ---------------------------------------------------------------------------

const _ink = Color(0xFF000000);
const _bold = TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: _ink);
const _normal = TextStyle(fontSize: 14, color: _ink);

class BioDataPage extends StatelessWidget {
  const BioDataPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE9E9E9),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 760),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(40, 40, 40, 48),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    _Title(),
                    SizedBox(height: 32),
                    _PersonalSection(),
                    SizedBox(height: 40),
                    _SectionHeading('EDUCATIONAL BACKGROUND'),
                    _EducationTable(),
                    SizedBox(height: 40),
                    _SectionHeading('WORK EXPERIENCE'),
                    _WorkTable(),
                    SizedBox(height: 32),
                    _Footer(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Title extends StatelessWidget {
  const _Title();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'BIO-DATA',
        style: TextStyle(
          fontSize: 32,
          color: Color(0xFF4472C4),
          decoration: TextDecoration.underline,
          decorationColor: Color(0xFF4472C4),
        ),
      ),
    );
  }
}

class _PersonalSection extends StatelessWidget {
  const _PersonalSection();

  @override
  Widget build(BuildContext context) {
    final table = Table(
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: FixedColumnWidth(24),
        2: FlexColumnWidth(),
      },
      children: personalDetails.entries.map((e) {
        return TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 16, bottom: 4),
              child: Text(e.key, style: _bold),
            ),
            const Text(':', style: _bold),
            Text(e.value, style: _normal),
          ],
        );
      }).toList(),
    );

    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 480) {
          return Column(
            children: [const _PhotoBox(), const SizedBox(height: 20), table],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(child: table),
            const SizedBox(width: 24),
            const _PhotoBox(),
          ],
        );
      },
    );
  }
}

/// Passport-style photo. Replace `assets/photo.jpg` to change it.
class _PhotoBox extends StatelessWidget {
  const _PhotoBox();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 120,
      height: 160,
      decoration: BoxDecoration(
        color: const Color(0xFFEFEFEF),
        border: Border.all(color: const Color(0xFFBDBDBD)),
      ),
      child: Image.asset(
        'assets/photo.jpg',
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => const Center(
          child: Text(
            'PHOTO',
            style: TextStyle(fontSize: 11, color: Color(0xFFAAAAAA)),
          ),
        ),
      ),
    );
  }
}

class _SectionHeading extends StatelessWidget {
  const _SectionHeading(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 17,
          color: _ink,
          decoration: TextDecoration.underline,
        ),
      ),
    );
  }
}

class _EducationTable extends StatelessWidget {
  const _EducationTable();

  @override
  Widget build(BuildContext context) {
    return Table(
      columnWidths: const {
        0: IntrinsicColumnWidth(),
        1: FixedColumnWidth(24),
        2: FlexColumnWidth(3),
        3: FlexColumnWidth(2),
      },
      children: education.map((e) {
        final (level, school, year) = e;
        return TableRow(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: 8, bottom: 6),
              child: Text(level, style: _normal),
            ),
            const Text(':', style: _normal),
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Text(school, style: _normal),
            ),
            Text('Year of passing: $year', style: _normal),
          ],
        );
      }).toList(),
    );
  }
}

class _WorkTable extends StatelessWidget {
  const _WorkTable();

  @override
  Widget build(BuildContext context) {
    TableRow row(List<String> cells, TextStyle style) => TableRow(
          children: cells
              .map((c) => Padding(
                    padding: const EdgeInsets.only(right: 12, bottom: 6),
                    child: Text(c, style: style),
                  ))
              .toList(),
        );

    return Table(
      columnWidths: const {
        0: FlexColumnWidth(3),
        1: FlexColumnWidth(2.5),
        2: FlexColumnWidth(2),
      },
      children: [
        row(['Company Name', 'Position', 'Work Period'], _bold),
        for (var i = 0; i < workExperience.length; i++)
          row([
            '${i + 1}. ${workExperience[i].$1}',
            workExperience[i].$2,
            workExperience[i].$3,
          ], _normal),
      ],
    );
  }
}

class _Footer extends StatelessWidget {
  const _Footer();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(TextSpan(children: [
          TextSpan(text: 'Place: ', style: _bold),
          TextSpan(text: place, style: _normal),
        ])),
        SizedBox(height: 28),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(
              child: Text.rich(TextSpan(children: [
                TextSpan(text: 'Date: ', style: _bold),
                TextSpan(text: date, style: _normal),
              ])),
            ),
            Column(
              children: [
                SizedBox(
                  width: 140,
                  child: Divider(color: _ink, thickness: 1, height: 1),
                ),
                SizedBox(height: 4),
                Text('Signature', style: _bold),
              ],
            ),
          ],
        ),
      ],
    );
  }
}
