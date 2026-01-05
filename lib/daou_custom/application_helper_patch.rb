module DaouCustom
  module ApplicationHelperPatch
    # 프로젝트명 클릭 시 이슈 목록으로 이동하는 링크 생성
    def link_to_project(project, options={}, html_options=nil)
      if project.archived?
        h(project.name)
      else
        link_to project.name,
                project_issues_path(project, {:only_path => true}.merge(options)),
                html_options
      end
    end
  end
end