import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gitser/core/resources/data_state.dart';
import 'package:flutter_gitser/features/gitser/domain/usecases/detail_user_usecase.dart';
import 'package:flutter_gitser/features/gitser/presentation/bloc/detail/detail_event.dart';
import 'package:flutter_gitser/features/gitser/presentation/bloc/detail/detail_state.dart';

class DetailBloc extends Bloc<DetailEvent, DetailState> {
  final DetailUserUseCase detailUserUseCase;

  DetailBloc(this.detailUserUseCase) : super(const DetailLoadingState()) {
    on<GetDetailUserEvent>(onGetDetailUserEvent);
  }

  void onGetDetailUserEvent(
    GetDetailUserEvent event,
    Emitter<DetailState> emit,
  ) async {
    final state = await detailUserUseCase(
      params: DetailUserParams(event.username!),
    );

    if (state is DataSuccess) {
      emit(DetailSuccessState(state.data!));
    }

    if (state is DataError) {
      emit(DetailErrorState(state.error!));
    }
  }
}
