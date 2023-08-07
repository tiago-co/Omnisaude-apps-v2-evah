import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_triple/flutter_triple.dart';

import 'package:omni_plan/src/core/models/guide_providers_params_model.dart';
import 'package:omni_plan/src/core/models/plan_provider_model.dart';
import 'package:omni_plan/src/modules/guide_providers/guide_providers_repository.dart';

// ignore: must_be_immutable
class GuideProvidersStore
    extends NotifierStore<DioError, PlanProviderResultsModel> with Disposable {
  final GuideRepositoryRepository _repository = Modular.get();
  final GuideProvidersParamsModel params = GuideProvidersParamsModel();

  GuideProvidersStore() : super(PlanProviderResultsModel(results: []));

  Timer? _debounce;

  Future<void> getPlanProviders(GuideProvidersParamsModel params) async {
    setLoading(true);
    await _repository.getPlanProviders(params).then(
      (providers) {
        update(providers);
        setLoading(false);
      },
    ).catchError(
      (onError) {
        setLoading(false);
        setError(onError);
      },
    );
  }

  Future<void> setFavoriteProvider(PlanProviderModel model) async {
    setLoading(true);
    model.isFavorite = !model.isFavorite!;
    await _repository.setFavoriteProvider(model).then(
      (providers) async {
        await _repository.getPlanProviders(params).then(
          (providers) {
            update(providers);
            setLoading(false);
          },
        ).catchError(
          (onError) {
            setLoading(false);
            setError(onError);
          },
        );
        setLoading(false);
      },
    ).catchError(
      (onError) async {
        model.isFavorite = !model.isFavorite!;

        await _repository.getPlanProviders(params).then(
          (providers) {
            update(providers);
            setLoading(false);
          },
        ).catchError(
          (onError) {
            setLoading(false);
            setError(onError);
          },
        );

        setLoading(false);
        throw onError;
      },
    );
  }

  Future<void> getProvidersByNameTest(
    String name,
    GuideProvidersParamsModel params,
  ) async {
    params.name = name;
    await getPlanProviders(params);
  }

  Future<void> getProvidersBySpecialty(
    String specialty,
    GuideProvidersParamsModel params,
  ) async {
    params.specialty = specialty;
    await getPlanProviders(params);
  }

  Future<void> getProvidersByAddress(
    String address,
    GuideProvidersParamsModel params,
  ) async {
    params.address = address;
    await getPlanProviders(params);
  }

  Future<void> getProvidersByName(
    String? name,
    GuideProvidersParamsModel params,
  ) async {
    setLoading(true);
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () async {
      params.name = name;
      await getPlanProviders(params);
      setLoading(false);
    });
  }

  @override
  void dispose() {
    _debounce?.cancel();
    _repository.dispose();
  }
}
