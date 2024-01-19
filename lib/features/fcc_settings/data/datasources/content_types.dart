const List<String> contentTypes = <String>[
  'about_us',
  'rate',
  'terms_and_conditions',
  'license_of_open_source_software',
  'version',
  'privacy_policy',
];

enum ContentTypeEnum {
  aboutUs,
  rate,
  termsAndConditions,
  licenseOfOpenSourceSoftware,
  version,
  privacyPolicy,
}

final Map<String, String> contentList = Map<String, String>.fromIterables(
  ContentTypeEnum.values.map(
    (ContentTypeEnum e) => e.name,
  ),
  contentTypes,
);
