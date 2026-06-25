enum TermsType {
  termsOfService,
  privacyPolicy;

  static TermsType fromString(String value) => switch (value) {
    'terms-of-service' => TermsType.termsOfService,
    'privacy-policy' => TermsType.privacyPolicy,
    _ => throw ArgumentError('Unknown TermsType: $value'),
  };

  String toJson() => switch (this) {
    TermsType.termsOfService => 'terms-of-service',
    TermsType.privacyPolicy => 'privacy-policy',
  };
}
