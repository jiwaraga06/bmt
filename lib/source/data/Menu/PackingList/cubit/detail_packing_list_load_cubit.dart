import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'detail_packing_list_load_state.dart';

class DetailPackingListLoadCubit extends Cubit<DetailPackingListLoadState> {
  DetailPackingListLoadCubit() : super(DetailPackingListLoadInitial());

  void detailLoadFromHeader(doOid, soOid, soPtnridSold) async{
    SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setString('do_oid', doOid);
    pref.setString('so_oid', soOid);
    pref.setString('so_ptnr_id_sold', soPtnridSold);
    // emit(DetailPackingListLoadFromHeader(do_oid: doOid, so_oid: soOid, so_ptnr_id_sold: soPtnridSold));
  }
}
