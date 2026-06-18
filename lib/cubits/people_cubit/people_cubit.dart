import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../models/user_profile.dart';
import '../../module/di_root.dart';
import 'people_state.dart';

@injectable
class PeopleCubit extends Cubit<PeopleState> {
  PeopleCubit() : super(const PeopleState());
  QueryDocumentSnapshot<Map<String, dynamic>>? _lastPaginationDoc;

  void loadMoreIfNeeded() async {
    if (state.isLoadingMore || state.isLoading) {
      return;
    }
    final lastPaginationDoc = _lastPaginationDoc;
    if (lastPaginationDoc != null) {
      emit(state.copyWith(isLoadingMore: true));
      final result = await registry
          .get<FirebaseFirestore>()
          .collection('conversations')
          .where('names', arrayContainsAny: [state.searchTerm])
          .limit(25)
          .startAfterDocument(lastPaginationDoc)
          .get();
      _lastPaginationDoc = result.docs.lastOrNull;
      if (result.docs.length < 25) {
        _lastPaginationDoc = null;
      }
      final users = result.docs
          .map((doc) => UserProfile.fromJson({...doc.data(), 'id': doc.id}))
          .toList();

      emit(state.copyWith(users: [...state.users, ...users], isLoadingMore: false));
    }
  }

  // debounce / throttle
  void searchUsers(String text) async {
    emit(state.copyWith(isLoading: true, isLoadingMore: false, searchTerm: text));
    final result = await registry
        .get<FirebaseFirestore>()
        .collection('profiles')
        .where('names', arrayContainsAny: [text])
        .limit(25)
        .get();
    final documents = result.docs;
    _lastPaginationDoc = result.docs.lastOrNull;
    final users = documents
        .map((doc) => UserProfile.fromJson({...doc.data(), 'id': doc.id}))
        .toList();
    if (text == state.searchTerm) {
      emit(state.copyWith(users: users, isLoading: false));
    }
  }
}
