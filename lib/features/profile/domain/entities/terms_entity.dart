import '../../../../core/enums/terms_type.dart';
import 'terms_section_entity.dart';

class TermsEntity {
  final TermsType type;
  final String title;
  final List<TermsSectionEntity> content;
  final DateTime lastUpdated;

  const TermsEntity({
    required this.type,
    required this.title,
    required this.content,
    required this.lastUpdated,
  });
}
