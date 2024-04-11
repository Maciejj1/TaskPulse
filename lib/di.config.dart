// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import 'features/dashboard/data/datasources/dashboard_remote_datasource.dart'
    as _i3;
import 'features/dashboard/data/repositories/dashboard_repository.dart' as _i4;
import 'features/dashboard/presentation/cubit/dashboard_cubit.dart' as _i13;
import 'features/dashboard/presentation/widgets/dashboard_current_city/cubit/current_city_cubit.dart'
    as _i12;
import 'features/dashboard/presentation/widgets/dashboard_profile/cubit/profile_cubit.dart'
    as _i6;
import 'features/dashboard/presentation/widgets/dashboard_weather/cubit/weather_cubit.dart'
    as _i11;
import 'features/settings/data/datasources/settings_datasource.dart' as _i7;
import 'features/settings/data/repositories/settings_repository.dart' as _i8;
import 'features/settings/widgets/cubit/settings_cubit.dart' as _i14;
import 'features/tasks/datasources/task_datasource.dart' as _i9;
import 'features/tasks/repositories/task_repository.dart' as _i10;
import 'features/tasks/widgets/edit_task/cubit/edit_task_cubit.dart' as _i5;
import 'features/tasks/widgets/task_details/cubit/task_cubit_cubit.dart'
    as _i15;

extension GetItInjectableX on _i1.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i1.GetIt init({
    String? environment,
    _i2.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i2.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.lazySingleton<_i3.DashboardRemoteDatasourceImpl>(
        () => _i3.DashboardRemoteDatasourceImpl());
    gh.lazySingleton<_i4.DashboardRepository>(
        () => _i4.DashboardRepository(gh<_i3.DashboardRemoteDatasourceImpl>()));
    gh.factory<_i5.EditTaskCubit>(
        () => _i5.EditTaskCubit(gh<_i4.DashboardRepository>()));
    gh.factory<_i6.ProfileCubit>(
        () => _i6.ProfileCubit(gh<_i4.DashboardRepository>()));
    gh.lazySingleton<_i7.SettingsRemoteDatasourceImpl>(
        () => _i7.SettingsRemoteDatasourceImpl());
    gh.lazySingleton<_i8.SettingsRepository>(
        () => _i8.SettingsRepository(gh<_i7.SettingsRemoteDatasourceImpl>()));
    gh.lazySingleton<_i9.TaskRemoteDatasourceImpl>(
        () => _i9.TaskRemoteDatasourceImpl());
    gh.lazySingleton<_i10.TaskRepository>(
        () => _i10.TaskRepository(gh<_i9.TaskRemoteDatasourceImpl>()));
    gh.factory<_i11.WeatherCubit>(
        () => _i11.WeatherCubit(gh<_i4.DashboardRepository>()));
    gh.factory<_i12.CurrentCityCubit>(
        () => _i12.CurrentCityCubit(gh<_i4.DashboardRepository>()));
    gh.factory<_i13.DashboardCubit>(
        () => _i13.DashboardCubit(gh<_i10.TaskRepository>()));
    gh.factory<_i14.SettingsCubit>(
        () => _i14.SettingsCubit(gh<_i8.SettingsRepository>()));
    gh.factory<_i15.TaskCubit>(() => _i15.TaskCubit(gh<_i10.TaskRepository>()));
    return this;
  }
}
