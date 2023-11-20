import 'package:driving_school_scheduler_panel/example/lib/models/instructor.dart';
import 'package:driving_school_scheduler_panel/example/lib/models/lesson.dart';
import 'package:driving_school_scheduler_panel/models/data_point.dart';
import 'package:driving_school_scheduler_panel/models/setup.dart';
import 'package:driving_school_scheduler_panel/widgets/driving_school_scheduler_panel_widget.dart';
import 'package:flutter/material.dart';

class InstructorProvider {
  List<Instructor> _instructors = [];
  final List<String> _instructorNames = [
    "John Mathews",
    "Thabo Gumede",
    "Nicole Nyaba",
    "Themba Shange",
    "David Mtungwa",
    "Mike Rogger",
    "Robert Moodley",
    "Thobeka Ngidi",
    "Ruyan Smith"
  ];
  InstructorProvider() {
    for (var i = 0; i < _instructorNames.length; i++) {
      _instructors.add(new Instructor(_instructorNames[i], i, getLessons(i)));
    }
  }

  List<Lesson> getLessons(i) {
    final List<List<Lesson>> lessonGroups = [
      [
        Lesson(DateTime(20201, 07, 30, 7), DateTime(20201, 07, 30, 8), 'Jonathan Mathews'),
        Lesson(DateTime(20201, 07, 30, 8), DateTime(20201, 07, 30, 9), 'Jonathan Mkhize'),
        Lesson(DateTime(20201, 07, 30, 12), DateTime(20201, 07, 30, 13), 'Sabelo Moloi'),
      ],
      [
        Lesson(DateTime(20201, 07, 30, 11), DateTime(20201, 07, 30, 12), 'Tony Smith'),
        Lesson(DateTime(20201, 07, 30, 12), DateTime(20201, 07, 30, 13), 'Nothando Ndlovu'),
      ],
      [
        Lesson(DateTime(20201, 07, 30, 9), DateTime(20201, 07, 30, 11), 'Bongani Gumede'),
        Lesson(DateTime(20201, 07, 30, 14), DateTime(20201, 07, 30, 17), 'Thabani Sokhela'),
      ],
      [
        Lesson(DateTime(20201, 07, 30, 7), DateTime(20201, 07, 30, 9), 'Bongani Gumede'),
        Lesson(DateTime(20201, 07, 30, 11), DateTime(20201, 07, 30, 12), 'Qiniso Smelane'),
      ],
      [],
      [],
      [],
      [Lesson(DateTime(20201, 07, 30, 7), DateTime(20201, 07, 30, 9), 'Thabani Smelane')],
      []
    ];

    return lessonGroups[i];
  }

  List<Instructor> getAll() => _instructors;
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a blue toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    var instructorTestData = InstructorProvider();

    var _dataPoints = instructorTestData
        .getAll()
        .map((data) => DataPoint(
              data.name,
              data.image,
              data.lessons.map((l) => SchedulerCard(l.start, l.endTime, l.name)).toList(),
            ))
        .toList();
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Container(
        color: Colors.lightGreen,
        padding: const EdgeInsets.all(20),
        child: SchedulerWidget(
          setup: SchedulerSetup(
            blockSize: const Size(140, 100),
            dataPoints: _dataPoints,
            maxHourCount: 9,
            startHour: 7,
          ),
        ),
      ),
    );
  }
}
