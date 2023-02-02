import 'package:bloc/bloc.dart';
import 'package:bmt/source/repository/repository.dart';
import 'package:meta/meta.dart';

part 'receive_pulling_state.dart';

class ReceivePullingCubit extends Cubit<ReceivePullingState> {
  final MyRepository? myRepository;
  ReceivePullingCubit({required this.myRepository}) : super(ReceivePullingInitial());
}
