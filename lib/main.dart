// ignore_for_file: use_build_context_synchronously, unnecessary_import, unused_import, prefer_typing_uninitialized_variables, avoid_print

import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite_flutter/tflite_flutter.dart'; // ใช้ tflite_flutter แทน flutter_tflite
import 'package:image/image.dart' as img;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'THAIHERB',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/img09.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Image.asset('lib/img01.png',
                    width: 360, height: 160, fit: BoxFit.cover),
                const SizedBox(height: 50),
                SizedBox(
                  width: 150,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green[700], // เปลี่ยนสีปุ่ม
                      padding: const EdgeInsets.symmetric(
                          horizontal: 30, vertical: 15), // ขยายปุ่ม
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10), // มุมโค้งมน
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SecondPage()),
                      );
                    },
                    child: const Text(
                      'Open',
                      style: TextStyle(
                        fontFamily: 'MN Namphrik Long Ruea',
                        fontSize: 18, // เพิ่มขนาดฟอนต์
                        color: Colors.white, // ทำให้สีข้อความดูโดดเด่น
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/img03.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () async {
                    var image = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    if (image != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ResultScreen(imagePath: image.path),
                        ),
                      );
                    }
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        'lib/img05.png',
                        width: 120,
                        height: 120,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () async {
                    var image = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);
                    if (image != null) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ResultScreen(imagePath: image.path),
                        ),
                      );
                    }
                  },
                  child: Column(
                    children: [
                      Image.asset(
                        'lib/img04.png',
                        width: 120,
                        height: 120,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

const Map<String, String> herbDetails = {
  'chaplu': 'สรรพคุณ: ใช้รักษาโรคกระเพาะและช่วยขับลม\n'
      'ช่วยลดอาการเจ็บปวดในช่องท้อง มีฤทธิ์ในการบรรเทาอาการท้องอืดและย่อยอาหารได้ดี',
  'fahthalinejol': 'สรรพคุณ: ช่วยลดอาการอักเสบและมีฤทธิ์ต้านเชื้อแบคทีเรีย\n'
      'นิยมใช้ในการรักษาไข้หวัดและช่วยบรรเทาอาการคัดจมูก',
  'horapa': 'สรรพคุณ: ช่วยลดไข้และแก้อาการท้องอืด\n'
      'มีคุณสมบัติในการบรรเทาอาการเจ็บคอและลดอาการหืดหอบ',
  'krapao': 'สรรพคุณ: ช่วยย่อยอาหารและลดไขมันในเลือด\n'
      'มีสารต้านอนุมูลอิสระที่ช่วยปรับสมดุลในร่างกาย',
  'lemon': 'สรรพคุณ: มีวิตามินซีสูง ช่วยเสริมสร้างภูมิคุ้มกัน\n'
      'ช่วยป้องกันโรคหวัดและบำรุงผิวพรรณให้สดใส',
  'magrud': 'สรรพคุณ: บำรุงผิวพรรณและรักษาอาการปวดเมื่อยกล้ามเนื้อ\n'
      'มีคุณสมบัติช่วยลดความดันโลหิตและบรรเทาอาการเครียด',
  'plu': 'สรรพคุณ: ช่วยขับสารพิษและลดอาการปวดหัว\n'
      'ใช้เป็นส่วนผสมในสมุนไพรไทยหลายชนิดที่ช่วยในการขับสารพิษ',
  'sabtiger': 'สรรพคุณ: ใช้บำรุงสายตาและแก้ไข้\n'
      'ช่วยลดอาการปวดศีรษะและทำให้รู้สึกสดชื่นขึ้น',
  'saranae': 'สรรพคุณ: ช่วยบรรเทาอาการคลื่นไส้และลดความดันโลหิต\n'
      'มีคุณสมบัติช่วยให้รู้สึกผ่อนคลายและลดอาการเครียด',
  'yanang': 'สรรพคุณ: ช่วยดับร้อนและบำรุงหัวใจ\n'
      'มีคุณสมบัติในการบรรเทาอาการเจ็บป่วยจากอากาศร้อน',
};

class ResultScreen extends StatefulWidget {
  final String imagePath;

  const ResultScreen({super.key, required this.imagePath});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String label = '';
  double confidence = 0.0;
  String description = '';

  @override
  void initState() {
    super.initState();
    _runModelOnImage(widget.imagePath);
  }

  Future<void> _runModelOnImage(String imagePath) async {
    File imageFile = File(imagePath);

    // เรียกใช้ฟังก์ชัน classifyImage เพื่อจำแนกสมุนไพร
    List<dynamic> result = await classifyImage(imageFile);
    String predictedLabel = result[0];
    double accuracy = result[1] * 100;

    setState(() {
      label = predictedLabel;
      confidence = accuracy;
      description = herbDetails.containsKey(predictedLabel)
          ? herbDetails[predictedLabel]!
          : 'ไม่พบสรรพคุณสำหรับสมุนไพรชนิดนี้';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'ผลการจำแนก',
          style: TextStyle(
            fontFamily: 'MN Namphrik Long Ruea',
          ),
        ),
      ),
      body: Stack(children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/img08.png'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.file(File(widget.imagePath),
                  height: 300, fit: BoxFit.cover),
              const SizedBox(height: 20),
              Text(
                label.isNotEmpty ? label : 'กำลังจำแนก...',
                style: const TextStyle(
                  fontFamily: 'MN Namphrik Long Ruea',
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              confidence > 0
                  ? confidence >= 80
                      ? Column(
                          children: [
                            Text(
                              "$label\nความแม่นยำ: ${confidence.toStringAsFixed(2)}%",
                              style: TextStyle(
                                fontFamily: 'MN Namphrik Long Ruea',
                                fontSize: 18,
                                color: Colors.green[900],
                              ),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 15),
                            Card(
                              elevation: 6,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              color: Colors.lightGreen[50],
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 16),
                              child: Padding(
                                padding: const EdgeInsets.all(12),
                                child: Text(
                                  description,
                                  style: const TextStyle(
                                    fontFamily: 'MN Namphrik Long Ruea',
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        )
                      : const Text(
                          "ไม่สามารถจำแนกได้",
                          style: TextStyle(
                            fontFamily: 'MN Namphrik Long Ruea',
                            fontSize: 18,
                            color: Colors.red,
                          ),
                        )
                  : const CircularProgressIndicator(),
            ],
          ),
        ),
      ]),
    );
  }
}

Future<List<dynamic>> classifyImage(File image) async {
  final interpreter = await Interpreter.fromAsset('assets/Models.tflite');

  Uint8List imageBytes = image.readAsBytesSync();
  img.Image? imageInput = img.decodeImage(imageBytes);

  // Resize รูปให้ตรงกับขนาดที่โมเดลต้องการ (224x224)
  img.Image resizedImage = img.copyResize(imageInput!, width: 224, height: 224);

  // เตรียม input สำหรับโมเดล
  var input = List.generate(
      1,
      (i) => List.generate(
          224, (j) => List.generate(224, (k) => List.filled(3, 0.0))));
  for (var x = 0; x < 224; x++) {
    for (var y = 0; y < 224; y++) {
      var pixel = resizedImage.getPixel(x, y);
      input[0][x][y][0] = img.getRed(pixel) / 255.0;
      input[0][x][y][1] = img.getGreen(pixel) / 255.0;
      input[0][x][y][2] = img.getBlue(pixel) / 255.0;
    }
  }

  // ประมวลผล
  var output =
      List.filled(1 * 10, 0.0).reshape([1, 10]); // เปลี่ยนจาก 5 เป็น 10
  interpreter.run(input, output);

  // ปิด interpreter
  interpreter.close();

  // แปลงค่าใน output[0] ให้เป็น List
  List<String> labels = [
    'chaplu', // เปลี่ยนชื่อให้ตรงกับสมุนไพรที่แท้จริง
    'fahthalinejol',
    'horapa',
    'krapao',
    'lemon',
    'magrud',
    'plu',
    'sabtiger',
    'saranae',
    'yanang',
  ];
  List<double> probabilities = output[0].cast<double>();

// หาค่าความน่าจะเป็นสูงสุด
  double maxProb =
      probabilities.reduce((curr, next) => curr > next ? curr : next);

// หาตำแหน่งของค่าความน่าจะเป็นสูงสุด
  int maxIndex = probabilities.indexOf(maxProb);

  // ตรวจสอบว่าเปอร์เซ็นต์ความน่าจะเป็นเกิน 90% หรือไม่
  if (maxProb >= 0.80) {
    // แสดงผลลัพธ์
    print('จำแนกสมุนไพร: ${labels[maxIndex]}');
    print('เปอร์เซ็นต์ความน่าจะเป็น: ${(maxProb * 100).toStringAsFixed(2)}%');

    // แสดงเปอร์เซ็นต์ของโรคทั้งหมด
    for (int i = 0; i < labels.length; i++) {
      print('${labels[i]}: ${(output[0][i] * 100).toStringAsFixed(2)}%');
    }

    // คืนค่าผลการจำแนกโรคและเปอร์เซ็นต์
    return [labels[maxIndex], maxProb];
  } else {
    // ถ้าเปอร์เซ็นต์ไม่ถึง 90% แสดงข้อความที่เหมาะสม
    print('ความน่าจะเป็นต่ำเกินไปที่จะจำแนกอย่างมั่นใจ');
    return ['ไม่สามารถจำแนกได้อย่างมั่นใจ', maxProb];
  }
}

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Dropdown with Multiple Input Types</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
  <div class="dropdown">
    <button class="btn btn-primary dropdown-toggle" type="button" id="advancedDropdown" data-bs-toggle="dropdown" aria-expanded="false">
      ตัวเลือกหลายแบบ
    </button>
    <form class="dropdown-menu p-4" style="min-width: 300px;">
      <!-- คำตอบสั้นๆ -->
      <div class="mb-3">
        <label for="shortAnswer" class="form-label">คำตอบสั้นๆ</label>
        <input type="text" class="form-control" id="shortAnswer" placeholder="พิมพ์คำตอบของคุณ">
      </div>
      
      <!-- หลายตัวเลือก -->
      <div class="mb-3">
        <label class="form-label">เลือกหลายตัวเลือก</label>
        <select class="form-select" multiple aria-label="เลือกหลายตัวเลือก">
          <option value="1">ตัวเลือก 1</option>
          <option value="2">ตัวเลือก 2</option>
          <option value="3">ตัวเลือก 3</option>
        </select>
      </div>
      
      <!-- ช่องทำเครื่องหมาย -->
      <div class="mb-3">
        <label class="form-label">เลือกช่องทำเครื่องหมาย</label>
        <div class="form-check">
          <input class="form-check-input" type="checkbox" id="check1">
          <label class="form-check-label" for="check1">ตัวเลือก 1</label>
        </div>
        <div class="form-check">
          <input class="form-check-input" type="checkbox" id="check2">
          <label class="form-check-label" for="check2">ตัวเลือก 2</label>
        </div>
      </div>
      
      <!-- เลือกวันที่ -->
      <div class="mb-3">
        <label for="datePicker" class="form-label">เลือกวันที่</label>
        <input type="date" class="form-control" id="datePicker">
      </div>
      
      <!-- เลือกเวลา -->
      <div class="mb-3">
        <label for="timePicker" class="form-label">เลือกเวลา</label>
        <input type="time" class="form-control" id="timePicker">
      </div>
      
      <!-- ปุ่มยืนยัน -->
      <button type="submit" class="btn btn-success">ยืนยัน</button>
    </form>
  </div>

  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
