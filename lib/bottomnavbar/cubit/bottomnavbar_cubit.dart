import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'bottomnavbar_state.dart';

class BottomnavbarCubit extends Cubit<BottomnavbarState> {
  BottomnavbarCubit() : super(BottomnavbarInitial()) {}
  int selectedIndex = 0;
  updateIndex(int index) {
    selectedIndex = index;
  }
}
