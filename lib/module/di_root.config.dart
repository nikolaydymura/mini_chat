// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:firebase_analytics/firebase_analytics.dart' as _i398;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:firebase_crashlytics/firebase_crashlytics.dart' as _i141;
import 'package:firebase_storage/firebase_storage.dart' as _i457;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../cubits/dialogs_cubit/dialogs_cubit.dart' as _i899;
import '../cubits/messages_cubit/messages_cubit.dart' as _i442;
import '../cubits/people_cubit/people_cubit.dart' as _i160;
import '../cubits/user_cubit/user_cubit.dart' as _i996;
import '../navigation/app_router.dart' as _i630;
import 'di_root.dart' as _i375;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final appModule = _$AppModule();
    gh.factory<_i442.MessagesCubit>(() => _i442.MessagesCubit());
    gh.factory<_i160.PeopleCubit>(() => _i160.PeopleCubit());
    gh.lazySingleton<_i899.DialogsCubit>(() => _i899.DialogsCubit());
    gh.lazySingleton<_i996.UserCubit>(() => _i996.UserCubit()..load());
    gh.lazySingleton<_i59.FirebaseAuth>(() => appModule.firebaseAuth);
    gh.lazySingleton<_i974.FirebaseFirestore>(
      () => appModule.firebaseFirestore,
    );
    gh.lazySingleton<_i457.FirebaseStorage>(() => appModule.firebaseStorage);
    gh.lazySingleton<_i398.FirebaseAnalytics>(
      () => appModule.firebaseAnalytics,
    );
    gh.lazySingleton<_i141.FirebaseCrashlytics>(
      () => appModule.firebaseCrashlytics,
    );
    gh.lazySingleton<_i630.AppRouter>(() => _i630.AppRouter());
    return this;
  }
}

class _$AppModule extends _i375.AppModule {}
