Redmine::Plugin.register :daou_custom do
  name 'Daoutech Custom Plugin'
  author 'rimichoi'
  description 'Custom hooks for Daoutech Redmine'
  version '0.0.3'
  requires_redmine :version_or_higher => '6.0.0'
  url 'https://github.com/daoutech-rimichoi/daou_custom'
  author_url 'mailto:rimichoi@daou.co.kr'

  settings default: {
    'git_base_url' => 'https://repo.daou.co.kr'
  }, partial: 'settings/daou_custom'
end

# Rails 초기화 및 리로드(개발 모드) 시 실행
Rails.configuration.to_prepare do
  # 1. 뷰 훅 로드 (상수 참조로 오토로딩 트리거)
  DaouCustom::ViewHook

  # 2. 코어 클래스 패치 (Prepend)
  # ApplicationHelper 패치
  ApplicationHelper.prepend(DaouCustom::ApplicationHelperPatch) unless ApplicationHelper.ancestors.include?(DaouCustom::ApplicationHelperPatch)

  # Issue 모델 패치
  Issue.prepend(DaouCustom::IssuePatch) unless Issue.ancestors.include?(DaouCustom::IssuePatch)

  # IssuesHelper 패치
  IssuesHelper.prepend(DaouCustom::IssuesHelperPatch) unless IssuesHelper.ancestors.include?(DaouCustom::IssuesHelperPatch)

  # QueriesHelper 패치
  QueriesHelper.prepend(DaouCustom::QueriesHelperPatch) unless QueriesHelper.ancestors.include?(DaouCustom::QueriesHelperPatch)

  # Project 모델 패치
  Project.prepend(DaouCustom::ProjectPatch) unless Project.ancestors.include?(DaouCustom::ProjectPatch)

  # ProjectsHelper 패치
  ProjectsHelper.prepend(DaouCustom::ProjectsHelperPatch) unless ProjectsHelper.ancestors.include?(DaouCustom::ProjectsHelperPatch)

  # IssuesHelper::IssueFieldsRows 패치 (내부 클래스/모듈 존재 여부 확인 후 적용)
  if defined?(IssuesHelper::IssueFieldsRows) && !IssuesHelper::IssueFieldsRows.ancestors.include?(DaouCustom::IssueFieldsRowsPatch)
    IssuesHelper::IssueFieldsRows.prepend(DaouCustom::IssueFieldsRowsPatch)
  end
end