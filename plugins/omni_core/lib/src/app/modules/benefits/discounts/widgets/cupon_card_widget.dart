// import 'package:benefits_labels/labels.dart';
// import 'package:dashed_rect/dashed_rect.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_modular/flutter_modular.dart';
// import 'package:omni_core/src/app/modules/benefits/discounts/stores/coupon_details_store.dart';
// import 'package:omni_general/omni_general.dart';

// class CuponCardWidget extends StatefulWidget {
//   final CupomModel model;
//   final String coverImage;
//   const CuponCardWidget({
//     Key? key,
//     required this.model,
//     required this.coverImage,
//   }) : super(key: key);

//   @override
//   State<CuponCardWidget> createState() => _CuponCardWidgetState();
// }

// class _CuponCardWidgetState extends State<CuponCardWidget> {
//   @override
//   void initState() {
//     super.initState();
//     store.getCouponDetails(
//       organizationId: widget.model.organizationId!,
//       couponId: widget.model.id!,
//     );
//   }

//   final CouponDetailsStore store = Modular.get();

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         Modular.to.pushNamed('coupon_details', arguments: 'Cupom');
//       },
//       child: Container(
//         padding: const EdgeInsets.all(15),
//         decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(15),
//           color: Theme.of(context).primaryColor.withOpacity(0.07),
//         ),
//         child: Container(
//           padding: const EdgeInsets.all(5),
//           child: DashedRect(
//             color: Theme.of(context).primaryColor,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 ClipRRect(
//                   borderRadius: BorderRadius.circular(50),
//                   child: ImageWidget(
//                     // asset: 'assets/test/test.svg',
//                     url: widget.coverImage,
//                     // package: 'omni_general',
//                     width: 80,
//                     height: 80,
//                   ),
//                 ),
//                 Container(
//                   padding: const EdgeInsets.all(10),
//                   child: Column(
//                     children: [
//                       Column(
//                         children: [
//                           Align(
//                             child: Text(
//                               'Até ${widget.model.discount}%',
//                               textAlign: TextAlign.center,
//                               style: Theme.of(context).textTheme.headlineMedium!.copyWith(
//                                     fontSize: 26,
//                                     fontWeight: FontWeight.bold,
//                                     color: Theme.of(context).primaryColor,
//                                   ),
//                             ),
//                           ),
//                           Align(
//                             child: SingleChildScrollView(
//                               scrollDirection: Axis.horizontal,
//                               child: Text(
//                                 'de desconto',
//                                 textAlign: TextAlign.center,
//                                 style: Theme.of(context).textTheme.headlineMedium!.copyWith(
//                                       fontSize: 13,
//                                       fontWeight: FontWeight.bold,
//                                       color: Theme.of(context).primaryColor,
//                                     ),
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                       Align(
//                         child: Container(
//                           padding: const EdgeInsets.all(5),
//                           decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(5),
//                             border: Border.all(
//                               color: Theme.of(context).primaryColor,
//                             ),
//                           ),
//                           child: Row(
//                             children: [
//                               SingleChildScrollView(
//                                 child: Text(
//                                   '${BenefitsLabels.cuponCardUntil} ${widget.model.discount}%',
//                                   textAlign: TextAlign.center,
//                                   maxLines: 4,
//                                   style: Theme.of(context).textTheme.displaySmall!.copyWith(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 13,
//                                         color: Theme.of(context).primaryColor,
//                                       ),
//                                 ),
//                               ),
//                               Align(
//                                 child: SingleChildScrollView(
//                                   scrollDirection: Axis.horizontal,
//                                   child: Text(
//                                     BenefitsLabels.cuponCardDiscount,
//                                     textAlign: TextAlign.center,
//                                     style: Theme.of(context).textTheme.headlineMedium!.copyWith(
//                                           fontSize: 13,
//                                           fontWeight: FontWeight.bold,
//                                           color: Theme.of(context).primaryColor,
//                                         ),
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Align(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             children: [
//                               SingleChildScrollView(
//                                 child: Text(
//                                   BenefitsLabels.cuponCardGetCoupon,
//                                   textAlign: TextAlign.center,
//                                   maxLines: 4,
//                                   style: Theme.of(context).textTheme.displaySmall!.copyWith(
//                                         fontWeight: FontWeight.bold,
//                                         fontSize: 13,
//                                         color: Theme.of(context).primaryColor,
//                                       ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                       Align(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             mainAxisAlignment: MainAxisAlignment.center,
//                             children: [
//                               Text(
//                                 '${BenefitsLabels.cuponCardValidUnitl}: ',
//                                 style: Theme.of(context).textTheme.headlineSmall!.copyWith(
//                                       color: Theme.of(context).cardColor,
//                                       fontSize: 12,
//                                     ),
//                               ),
//                               Text(
//                                 Formaters.dateToStringDate(
//                                   Formaters.stringToDate(
//                                     widget.model.endDate!,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
