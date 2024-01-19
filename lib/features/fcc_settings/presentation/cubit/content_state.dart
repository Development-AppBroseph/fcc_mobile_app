part of 'content_cubit.dart';

@immutable
class ContentState extends Equatable {
  const ContentState(
    this.contents,
  );
  final Map<ContentTypeEnum, String> contents;
  @override
  List<Object> get props => <Object>[
        contents,
      ];
}
