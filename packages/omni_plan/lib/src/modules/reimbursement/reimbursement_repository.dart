import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:omni_general/omni_general.dart';
import 'package:omni_plan/src/core/models/bank_model.dart';
import 'package:omni_plan/src/core/models/new_reimbursement_model.dart';
import 'package:omni_plan/src/core/models/reimbursement_details_model.dart';
import 'package:omni_plan/src/core/models/reimbursements_results_model.dart';

class ReimbursementRepository extends Disposable {
  final DioHttpClientImpl client;
  final _firestore = FirebaseFirestore.instance;
  ReimbursementRepository(
    this.client,
  );

  // Future<BanksListResultsModel> getAvaliableBanks(
  //   QueryParamsModel params,
  // ) async {
  //   try {
  //     final Response response = await client.get(
  //       path: '/mobile/omni/banco/',
  //       queryParameters: params.toJson(),
  //     );
  //     return BanksListResultsModel.fromMap(response.data);
  //   } catch (e) {
  //     log(e.toString());
  //     rethrow;
  //   }
  // }

  Future<BanksListResultsModel> getAvaliableBanks(
    QueryParamsModel params,
  ) async {
    try {
      final BanksListResultsModel banks = BanksListResultsModel(results: []);
      _firestore.collection('banks').snapshots().listen((event) {
        event.docs.forEach((element) {
          banks.results!.add(BankModel.fromMap(element.data()));
        });
      });
      return banks;
    } catch (e) {
      log(e.toString());
      rethrow;
    }
  }

  Future<ReimbursementListResultsModel> getReimbursements() async {
    try {
      final Response response = await client.get(
        path: '/mobile/omni/reembolso/',
      );
      return ReimbursementListResultsModel.fromMap(response.data);
    } catch (e) {
      rethrow;
    }
  }

  Future<void> createReimbursementSolicitation(
    NewReimbursementModel data,
  ) async {
    try {
      await client.post(
        path: '/mobile/omni/reembolso/',
        data: data.toMap(),
      );
    } catch (e) {
      rethrow;
    }
  }

  Future<ReimbursementDetailsModel> getReimbursementDetails(String id) async {
    try {
      final Response response = await client.get(
        path: '/mobile/omni/reembolso/$id',
      );

      return ReimbursementDetailsModel.fromMap(response.data);
    } catch (e) {
      rethrow;
    }
  }

  @override
  void dispose() {}
}
