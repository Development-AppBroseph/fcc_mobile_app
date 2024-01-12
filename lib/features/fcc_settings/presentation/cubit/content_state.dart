part of 'content_cubit.dart';

class ContentState extends Equatable {
  const ContentState(
    this.contents,
  );
  final Map<ContentTypeEnum, String> contents;
  @override
  List<Object> get props => [contents];
}
