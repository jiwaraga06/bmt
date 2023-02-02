import 'package:bloc/bloc.dart';
import 'package:bmt/source/repository/repository.dart';
import 'package:meta/meta.dart';

part 'receive_pulling_insert_state.dart';

class ReceivePullingInsertCubit extends Cubit<ReceivePullingInsertState> {
  final MyRepository? myRepository;
  ReceivePullingInsertCubit({required this.myRepository}) : super(ReceivePullingInsertInitial());
}
