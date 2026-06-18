import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../models/user_profile.dart';
import '../../module/di_root.dart';
import '../../navigation/app_router.dart';
import 'user_state.dart';

@LazySingleton()
class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserState(isAuthenticated: registry.get<FirebaseAuth>().currentUser != null));

  @postConstruct
  void load() async {
    final firebaseAuth = registry.get<FirebaseAuth>();
    final userId = firebaseAuth.currentUser?.uid;
    if (userId == null) {
      emit(const UserState());
      return;
    }
    final firebaseFirestore = registry.get<FirebaseFirestore>();

    final userDoc = await firebaseFirestore.collection('profiles').doc(userId).get();
    if (userDoc.exists) {
      final userProfile = UserProfile.fromJson(userDoc.data() ?? {});
      emit(state.copyWith(userProfile: userProfile.copyWith(userId: userId)));
    } else {
      emit(state.copyWith(userProfile: UserProfile(userId: userId)));
    }
  }

  Future<void> signIn(String email, String password) async {
    final firebaseAuth = registry.get<FirebaseAuth>();
    await firebaseAuth.signInWithEmailAndPassword(email: email, password: password);
    emit(state.copyWith(isAuthenticated: true));
    load();
  }

  Future<void> signUp(String email, String password) async {
    final firebaseAuth = registry.get<FirebaseAuth>();
    await firebaseAuth.createUserWithEmailAndPassword(email: email, password: password);
    emit(state.copyWith(isAuthenticated: true));
  }

  Future<void> logout() async {
    final firebaseAuth = registry.get<FirebaseAuth>();
    await firebaseAuth.signOut();
    emit(const UserState());
    registry.get<AppRouter>().logout();
  }

  void updateProfile({String? firstName, String? lastName, DateTime? dateOfBirth}) async {
    final user = UserProfile(firstName: firstName, lastName: lastName, dateOfBirth: dateOfBirth);
    final userId = registry.get<FirebaseAuth>().currentUser!.uid;
    await registry.get<FirebaseFirestore>().collection('profiles').doc(userId).set({
      ...user.toJson(),
      'names': [user.firstName?.toLowerCase(), user.lastName?.toLowerCase()].nonNulls.toList(),
    }, SetOptions(merge: true));
    emit(state.copyWith(userProfile: user));
  }

  void updateProfilePhoto(String photoFile) async {
    final userId = registry.get<FirebaseAuth>().currentUser!.uid;
    final task = registry<FirebaseStorage>()
        .ref('profilePhotos')
        .child(userId)
        .putFile(File(photoFile), SettableMetadata());
    await task.resume();
  }
}
