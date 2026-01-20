# frozen_string_literal: true

Redmine::Plugin.register :daou_view_custom do
  name 'Daoutech View Custom Plugin'
  author 'rimichoi'
  description 'Custom view hooks and patches for Daoutech Redmine'
  version '0.0.3'
  requires_redmine :version_or_higher => '6.0.0'
  url 'https://github.com/daoutech-rimichoi/daou_view_custom'
  author_url 'mailto:rimichoi@daou.co.kr'
end

# Rails 초기화 및 리로드(개발 모드) 시 실행
Rails.configuration.to_prepare do
  # ApplicationHelper 패치
  unless ApplicationHelper.ancestors.include?(DaouViewCustom::ApplicationHelperPatch)
    ApplicationHelper.prepend(DaouViewCustom::ApplicationHelperPatch)
  end

  # Issue 모델 패치
  unless Issue.ancestors.include?(DaouViewCustom::IssuePatch)
    Issue.prepend(DaouViewCustom::IssuePatch)
  end

  # QueriesHelper 패치
  unless QueriesHelper.ancestors.include?(DaouViewCustom::QueriesHelperPatch)
    QueriesHelper.prepend(DaouViewCustom::QueriesHelperPatch)
  end

  # Project 모델 패치
  unless Project.ancestors.include?(DaouViewCustom::ProjectPatch)
    Project.prepend(DaouViewCustom::ProjectPatch)
  end

  # ProjectsHelper 패치
  unless ProjectsHelper.ancestors.include?(DaouViewCustom::ProjectsHelperPatch)
    ProjectsHelper.prepend(DaouViewCustom::ProjectsHelperPatch)
  end

  # IssuesHelper::IssueFieldsRows 패치
  if defined?(IssuesHelper::IssueFieldsRows)
    unless IssuesHelper::IssueFieldsRows.ancestors.include?(DaouViewCustom::IssueFieldsRowsPatch)
      IssuesHelper::IssueFieldsRows.prepend(DaouViewCustom::IssueFieldsRowsPatch)
    end
  end
end