import '../../../../core/enums/terms_type.dart';
import '../../domain/entities/terms_entity.dart';
import '../../domain/entities/terms_section_entity.dart';
import '../models/terms_model.dart';
import '../models/terms_section.dart';

extension TermsSectionMapper on TermsSectionModel {
  TermsSectionEntity toEntity() =>
      TermsSectionEntity(section: section, text: text);
}

extension TermsMapper on TermsModel {
  TermsEntity toEntity() => TermsEntity(
    type: TermsType.fromString(type),
    title: title,
    content: content.map((e) => e.toEntity()).toList(),
    lastUpdated: lastUpdated,
  );
}
