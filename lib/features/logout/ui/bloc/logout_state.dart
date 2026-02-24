import 'package:equatable/equatable.dart';
import 'package:montebit/core/domain/enums/fetching_status.dart';

class LogoutState extends Equatable {
  const LogoutState({required this.logoutStatus});

  final FetchingStatus logoutStatus;

  factory LogoutState.initial() =>
      const LogoutState(logoutStatus: FetchingStatus.initial);

  LogoutState copyWith({FetchingStatus? logoutStatus}) {
    return LogoutState(logoutStatus: logoutStatus ?? this.logoutStatus);
  }

  @override
  List<Object> get props => [logoutStatus];
}
