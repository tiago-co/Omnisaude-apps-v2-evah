import 'package:flutter/material.dart';
import 'package:omni_core/src/app/modules/new_diagnosis/widgets/diagnosis_item.dart';
import 'package:omni_core/src/app/modules/new_diagnosis/widgets/document_widget.dart';

class DiagnosisContent extends StatelessWidget {
  const DiagnosisContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double baseWidth = 375;
    double fem = MediaQuery.of(context).size.width / baseWidth;
    double ffem = fem * 0.97;
    return TabBarView(children: [
      Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        const SizedBox(
          height: 28,
        ),
        Text(
          'August',
          style: TextStyle(
            fontSize: 16 * ffem,
            fontWeight: FontWeight.w400,
            height: 1.6000000238 * ffem / fem,
            color: Color(0xff52576a),
          ),
        ),
        const SizedBox(
          height: 12,
        ),
        DocumentWidget()
        // DiagnosisItem(),
      ]),
      Container(
        // frame625xKZ (5103:27842)
        margin: EdgeInsets.fromLTRB(0 * fem, 0 * fem, 0 * fem, 16 * fem),
        padding: EdgeInsets.fromLTRB(16 * fem, 16 * fem, 16 * fem, 16 * fem),
        width: double.infinity,
        decoration: BoxDecoration(
          border: Border.all(color: Color(0xfff1f8fd)),
          color: Color(0xffffffff),
          borderRadius: BorderRadius.circular(12 * fem),
        ),
        child: Center(
          child: Text('Nenhum documento encontrado!'),
        ),
      ),
    ]);
  }
}
