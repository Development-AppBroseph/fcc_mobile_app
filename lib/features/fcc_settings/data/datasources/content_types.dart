const contentTypes = [
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

final contentList = Map.fromIterables(
  ContentTypeEnum.values.map(
    (e) => e.name,
  ),
  contentTypes,
);
