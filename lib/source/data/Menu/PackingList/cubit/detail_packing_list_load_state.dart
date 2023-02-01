part of 'detail_packing_list_load_cubit.dart';

@immutable
abstract class DetailPackingListLoadState {}

class DetailPackingListLoadInitial extends DetailPackingListLoadState {}

class DetailPackingListLoadFromHeader extends DetailPackingListLoadState {
  final String? do_oid;
  final String? so_oid;
  final String? so_ptnr_id_sold;

  DetailPackingListLoadFromHeader({this.do_oid, this.so_oid, this.so_ptnr_id_sold});
}
