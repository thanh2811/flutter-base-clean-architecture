import 'dart:async';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../data/model/api/base_response.dart';
import '../../../../data/model/public_api/location.dart';
import '../../../../data/repository/remote/utility_repository.dart';

part 'address_event.dart';

part 'address_state.dart';

class AddressBloc extends Bloc<AddressEvent, AddressState> {
  final UtilityRepository utilityRepository;

  var _currentProvinceSelectedId = -1;
  var _currentDistrictSelectedId = -1;
  var _currentWardSelectedId = -1;
  final List<Province> _provinceList = [];
  final List<District> _districtList = [];
  final List<Ward> _wardsList = [];

  AddressBloc({required this.utilityRepository}) : super(AddressInitial()) {
    on<AddressGetProvinceListEvent>(_onGetProvince);
    on<AddressGetDistrictListEvent>(_onGetDistrict);
    on<AddressGetWardListEvent>(_onGetWard);
    on<AddressHandleSelectedEvent>(_onHandleChosen);
  }

  FutureOr<void> _onGetProvince(
      AddressGetProvinceListEvent event, Emitter<AddressState> emit) async {
    log('get address: ${event.initialProvince}');
    final response = await utilityRepository.getProvincesList();
    if (response.status == ResponseStatus.success) {
      _provinceList.clear();
      _provinceList.addAll(response.data as List<Province>);

      // get current address information
      if ((event.initialProvince ?? '').isNotEmpty &&
          _provinceList.isNotEmpty) {
        try {
          _currentProvinceSelectedId = _provinceList
              .where((element) => element.name == event.initialProvince)
              .first
              .code!;

          if (_currentProvinceSelectedId != -1) {
            // get district
            final response = await utilityRepository.getDistrictsList(
                code: _currentProvinceSelectedId);
            if (response.status == ResponseStatus.success) {
              _districtList.clear();
              _districtList.addAll(response.data as List<District>);
              try {
                _currentDistrictSelectedId = _districtList
                    .where((element) => element.name == event.initialDistrict)
                    .first
                    .code!;
              } catch (e) {
                _currentDistrictSelectedId = -1;
              }
            }

            // get ward
            if (_currentDistrictSelectedId != -1) {
              final response = await utilityRepository.getCommunesList(
                provinceCode: _currentProvinceSelectedId,
                districtId: _currentDistrictSelectedId,
              );
              if (response.status == ResponseStatus.success) {
                _wardsList.clear();
                _wardsList.addAll(response.data as List<Ward>);
                // emit something to notify ui that data is loaded
              }
            }
          }

          // newCustomerBloc.add(GetDistrictListEvent(
          //     provinceId: _currentProvinceSelectedId));
          // ignore: empty_catches
        } catch (e) {}
      }
    }
  }

  FutureOr<void> _onGetDistrict(
      AddressGetDistrictListEvent event, Emitter<AddressState> emit) async {
    final response = await utilityRepository.getDistrictsList(
        code: _currentProvinceSelectedId);
    if (response.status == ResponseStatus.success) {
      _districtList.clear();
      _districtList.addAll(response.data as List<District>);
      // emit something to notify ui that data is loaded
    }
  }

  FutureOr<void> _onGetWard(
      AddressGetWardListEvent event, Emitter<AddressState> emit) async {
    final response = await utilityRepository.getCommunesList(
      provinceCode: _currentProvinceSelectedId,
      districtId: _currentDistrictSelectedId,
    );
    if (response.status == ResponseStatus.success) {
      _wardsList.clear();
      _wardsList.addAll(response.data as List<Ward>);
      // emit something to notify ui that data is loaded
    }
  }

  set currentProvinceSelectedId(value) {
    _currentProvinceSelectedId = value;
  }

  int get currentProvinceSelectedId => _currentProvinceSelectedId;

  set currentDistrictSelectedId(value) {
    _currentDistrictSelectedId = value;
  }

  int get currentDistrictSelectedId => _currentDistrictSelectedId;

  // set provinceList(value) {
  //   _provinceList = value;
  // }

  List<Province> get provinceList => _provinceList;

  // set districtList(value) {
  //   _districtList = value;
  // }

  List<District> get districtList => _districtList;

  // set wardsList(value) {
  //   _wardsList = value;
  // }

  List<Ward> get wardsList => _wardsList;

  FutureOr<void> _onHandleChosen(
      AddressHandleSelectedEvent event, Emitter<AddressState> emit) {
    if (event.selected == null) {
      return null;
    }

    if (event.selected is Province) {
      final Province provinceSelected = event.selected;
      if (provinceSelected.code == _currentProvinceSelectedId) {
        return null;
      }
      _currentProvinceSelectedId = provinceSelected.code!;
      _districtList.clear();
      _wardsList.clear();
      _currentDistrictSelectedId = -1;
      emit(AddressSelectProvince(provinceName: provinceSelected.name ?? ''));
    }

    if (event.selected is District) {
      final District districtSelected = event.selected;
      if (districtSelected.code == _currentDistrictSelectedId) {
        return null;
      }
      _currentDistrictSelectedId = districtSelected.code ?? -1;
      _currentWardSelectedId = -1;
      wardsList.clear();
      emit(AddressSelectDistrict(districtName: districtSelected.name ?? ''));
    }

    if (event.selected is Ward) {
      final Ward wardSelected = event.selected;
      if (wardSelected.code == _currentWardSelectedId) {
        return null;
      }
      _currentWardSelectedId = wardSelected.code ?? -1;
      emit(AddressSelectWard(wardName: wardSelected.name ?? ''));
    }
  }
}
