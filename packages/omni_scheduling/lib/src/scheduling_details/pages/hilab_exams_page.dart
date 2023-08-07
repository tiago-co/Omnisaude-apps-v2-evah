import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_scheduling/src/core/enums/hilab_exam_status.dart';
import 'package:omni_scheduling/src/core/models/hilab_exams_model.dart';
import 'package:omni_scheduling_labels/labels.dart';

class HilabExamsPage extends StatelessWidget {
  final List<HilabExamsModel> hilabExams;
  const HilabExamsPage({
    Key? key,
    required this.hilabExams,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const NavBarWidget(
        title: SchedulingLabels.hilabExamsTitle,
      ).build(context) as AppBar,
      body: ListView.separated(
        itemCount: hilabExams.length,
        padding: const EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 20,
        ),
        separatorBuilder: (_, index) => const Divider(),
        itemBuilder: (_, index) {
          return _buildExamsListItem(hilabExams[index], context);
        },
      ),
    );
  }

  Future<void> openPdf(String archive, BuildContext context) async {
    final PdfViewService service = PdfViewService();
    final PdfViewStore pdfStore = PdfViewStore();
    if (archive.contains('image/png') ||
        archive.contains('image/jpg') ||
        archive.contains('image/jpeg')) {
      final String filename = archive.hashCode.toString();
      final String newB64 = archive.replaceAll('\n', '').split(',').last;
      final bytes = base64Decode(newB64);
      final file = File('${await PathUtils().localPath}/$filename');
      await file.writeAsBytes(bytes.buffer.asUint8List());
      Modular.to.pushNamed(
        'reportPage',
        arguments: {
          'imageArchive': file,
          'pdfViewStore': pdfStore,
        },
      );
    } else if (archive.contains('application/pdf')) {
      const String filename = 'PDF.pdf';
      final String newB64 = archive.replaceAll('\n', '').split(',').last;
      final bytes = base64Decode(newB64);
      final file = File('${await PathUtils().localPath}/$filename');
      await file.writeAsBytes(bytes.buffer.asUint8List());
      await pdfStore
          .loadPDF(
        service,
        PDFDocumentType.file,
        file: file,
      )
          .then(
        (value) {
          Modular.to.pushNamed(
            'reportPage',
            arguments: {
              'service': service,
              'pdfViewStore': pdfStore,
            },
          );
        },
      );
    } else {
      Helpers.showDialog(
        context,
        RequestErrorWidget(
          buttonText: SchedulingLabels.close,
          message: SchedulingLabels.hilabExamsInvalidFormat,
          onPressed: () => Modular.to.pop(),
        ),
      );
    }
  }

  Widget _buildExamsListItem(HilabExamsModel exam, BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: Theme.of(context).cardColor.withOpacity(0.5),
          width: 0.5,
        ),
        color: Theme.of(context).colorScheme.background,
      ),
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                exam.name ?? SchedulingLabels.hilabExamsNoName,
                style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).primaryColor,
                    ),
              ),
              Text(
                exam.examStatus?.label ?? SchedulingLabels.hilabExamsNoStatus,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
              ),
            ],
          ),
          if (exam.reportFile != null)
            GestureDetector(
              onTap: () {
                openPdf(exam.reportFile!, context);
              },
              child: Text(
                SchedulingLabels.hilabExamsSeeReport,
                style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              ),
            ),
          if (exam.reportFile == null)
            Text(
              SchedulingLabels.hilabExamsNoReport,
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                    color: Theme.of(context).cardColor,
                  ),
            ),
        ],
      ),
    );
  }
}
