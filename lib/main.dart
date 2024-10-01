import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              'یہ ایک اردو جملوں پر مشتمل پیراگراف ہے جس میں ہر لفظ خالص اردو زبان میں لکھا گیا ہے۔ اس کا مقصد یہ ہے کہ ہم اپنی زبان کے الفاظ کو محفوظ کریں اور ان کو روزمرہ کی زندگی میں استعمال کریں۔ اردو زبان کی شیرینی اور مٹھاس ہر بولنے والے کو اپنی طرف متوجہ کرتی ہے، اور اس کا استعمال ہمارے ثقافتی ورثے کی حفاظت کے لئے بہت ضروری ہے۔ اس پیراگراف میں کوئی غیر اردو لفظ شامل نہیں کیا گیا تاکہ زبان کی اصل خوبصورتی برقرار رکھی جا سکے--',
            ),
            ElevatedButton(
              onPressed: () {
                createPdfWithUrduText(context);
              },
              child: const Text('Generate PDF'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> createPdfWithUrduText(context) async {
    final text =
        'یہ ایک اردو جملوں   پر مشتمل پیراگراف ہے جس میں ہر لفظ خالص اردو زبان میں لکھا گیا ہے۔ اس کا مقصد یہ ہے کہ ہم اپنی زبان کے الفاظ کو محفوظ کریں اور ان کو روزمرہ کی زندگی میں استعمال کریں۔ اردو زبان کی شیرینی اور مٹھاس ہر بولنے والے کو اپنی طرف متوجہ کرتی ہے، اور اس کا استعمال ہمارے ثقافتی ورثے کی حفاظت کے لئے بہت ضروری   ہے۔ اس پیراگراف  میں کوئی غیر اردو لفظ شامل نہیں کیا گیا تاکہ زبان کی اصل خوبصورتی برقرار رکھی جا سکے';

    final textList = text.split(" ");

    final pdf = pw.Document();
    final font = await rootBundle
        .load("assets/fonts/nastaliq/NotoNastaliqUrdu-Regular.ttf");

    final ttf = pw.Font.ttf(font);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (_) => pw.Directionality(
          textDirection: pw.TextDirection.rtl,
          child: pw.Container(
            // width: MediaQuery.of(context).size.width,
            child: pw.Center(
              child: pw.Column(
                  mainAxisSize: pw.MainAxisSize.min,
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.RichText(
                        text: pw.TextSpan(
                      children: textList
                          .map((e) => pw.TextSpan(
                                text: e,
                                style: pw.TextStyle(
                                    font: ttf, fontSize: 20, wordSpacing: 1),
                              ))
                          .toList(),
                    )),
                    pw.Text(
                      'یہ ایک اردو جملوں   پر مشتمل پیراگراف ہے جس میں ہر لفظ خالص اردو زبان میں لکھا گیا ہے۔ اس کا مقصد یہ ہے کہ ہم اپنی زبان کے الفاظ کو محفوظ کریں اور ان کو روزمرہ کی زندگی میں استعمال کریں۔ اردو زبان کی شیرینی اور مٹھاس ہر بولنے والے کو اپنی طرف متوجہ کرتی ہے، اور اس کا استعمال ہمارے ثقافتی ورثے کی حفاظت کے لئے بہت ضروری   ہے۔ اس پیراگراف  میں کوئی غیر اردو لفظ شامل نہیں کیا گیا تاکہ زبان کی اصل خوبصورتی برقرار رکھی جا سکے',
                      // textDirection: pw.TextDirection.ltr,
                      style:
                          pw.TextStyle(font: ttf, fontSize: 20, wordSpacing: 1),
                      textAlign: pw.TextAlign.justify,
                    )
                  ]),
            ),
          ),
        ),
      ),
    );
    final Uint8List pdfBytes = await pdf.save();

    Printing.layoutPdf(onLayout: (PdfPageFormat format) => pdfBytes);
  }
}
