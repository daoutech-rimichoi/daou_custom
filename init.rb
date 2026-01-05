require File.expand_path('../lib/daou_custom/application_helper_patch', __FILE__)
require File.expand_path('../lib/daou_custom/issue_patch', __FILE__)
require File.expand_path('../lib/daou_custom/queries_helper_patch', __FILE__)

Rails.application.config.after_initialize do
  unless ApplicationHelper.ancestors.include?(DaouCustom::ApplicationHelperPatch)
    ApplicationHelper.prepend(DaouCustom::ApplicationHelperPatch)
  end

  unless Issue.ancestors.include?(DaouCustom::IssuePatch)
    Issue.prepend(DaouCustom::IssuePatch)
  end

  unless QueriesHelper.ancestors.include?(DaouCustom::QueriesHelperPatch)
    QueriesHelper.prepend(DaouCustom::QueriesHelperPatch)
  end
end

Redmine::Plugin.register :daou_custom do
  name 'Daoutech Custom Plugin'
  author 'Daoutech'
  description 'Custom hooks for Daou Redmine'
  version '0.0.1'
  url 'https://www.daou.co.kr/'
  author_url 'https://www.daou.co.kr/'
end
