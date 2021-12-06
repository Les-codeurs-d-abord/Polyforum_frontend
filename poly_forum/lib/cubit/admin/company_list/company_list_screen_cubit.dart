import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:poly_forum/resources/repository.dart';

part 'company_list_screen_state.dart';

class CompanyListScreenCubit extends Cubit<CompanyListScreenState> {
  final Repository _repository;

  CompanyListScreenCubit(this._repository) : super(CompanyListScreenInitial());
}
