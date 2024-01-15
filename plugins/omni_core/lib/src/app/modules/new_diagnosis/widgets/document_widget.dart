import 'package:flutter/material.dart';

class DocumentWidget extends StatelessWidget {
  const DocumentWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Row(children: [
      Expanded(
        flex: 2,
        child: SizedBox(
          width: double.maxFinite,
          height: 78,
          child: Card(
            color: Colors.amber,
          ),
        ),
      ),
      SizedBox(
        width: 12,
      ),
      Expanded(
        flex: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Prescrição: Escitalopram',
              style: TextStyle(
                fontSize: 16,
              ),
            ),
            Text(
              'Ago 8, 2023',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Color(0xff878DA1),
              ),
            ),
            Text(
              'Ativo',
              style: TextStyle(
                fontSize: 14,
                color: Color(0xff48BEC2),
              ),
            )
          ],
        ),
      ),
      Expanded(
        child: Icon(
          Icons.file_download_outlined,
          color: Colors.black54,
        ),
      ),
    ]);
  }
}
