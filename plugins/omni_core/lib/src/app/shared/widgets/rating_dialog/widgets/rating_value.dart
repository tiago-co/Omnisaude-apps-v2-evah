import 'package:flutter/material.dart';
import 'package:flutter_triple/flutter_triple.dart';
import 'package:omni_core/src/app/core/models/rating_form_model.dart';
import 'package:omni_core/src/app/shared/widgets/rating_dialog/store/rating_store.dart';

class RatingValue extends StatefulWidget {
  const RatingValue({Key? key, required this.store}) : super(key: key);

  final RatingStore store;
  @override
  State<RatingValue> createState() => _RatingValueState();
}

class _RatingValueState extends State<RatingValue> {
  bool selected = false;
  late RatingStore store;
  @override
  void initState() {
    store = widget.store;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return TripleBuilder<RatingStore, Exception, RatingFormModel>(
      store: store,
      builder: (_, triple) => StatefulBuilder(
        builder: (context, setState) {
          return ListView.builder(
            scrollDirection: Axis.horizontal,
            shrinkWrap: true,
            itemCount: 10,
            itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  setState(() {
                    store.changeValue(index + 1);
                  });
                },
                child: Container(
                  width: 30,
                  height: 30,
                  padding: const EdgeInsets.only(top: 6),
                  margin: const EdgeInsets.symmetric(horizontal: 2),
                  decoration: BoxDecoration(
                    color: store.state.ratingValue == index + 1
                        ? Theme.of(context).primaryColor
                        : Colors.white,
                    border: Border.all(
                      color: Theme.of(context).primaryColor,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    '${index + 1}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: store.state.ratingValue == index + 1
                          ? Colors.white
                          : Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
