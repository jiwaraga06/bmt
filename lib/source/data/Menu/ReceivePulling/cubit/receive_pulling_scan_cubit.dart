import 'package:bloc/bloc.dart';
import 'package:bmt/source/repository/repository.dart';
import 'package:meta/meta.dart';

part 'receive_pulling_scan_state.dart';

class ReceivePullingScanCubit extends Cubit<ReceivePullingScanState> {
  final MyRepository? myRepository;
  ReceivePullingScanCubit({required this.myRepository}) : super(ReceivePullingScanInitial());
}
