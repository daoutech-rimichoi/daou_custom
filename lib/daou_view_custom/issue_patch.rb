# frozen_string_literal: true

module DaouViewCustom
  module IssuePatch
    # 프로젝트별 필수 필드 설정을 반영하여 필수 속성 목록을 반환
    def required_attribute_names(user=nil)
      names = super(user)
      if project
        additional_names = project.project_required_fields.pluck(:field_name).map do |name|
          # 'custom_field_12' -> '12', 'category_id' -> 'category_id'
          name.to_s.sub(/^custom_field_/, '') 
        end
        names += additional_names
      end
      names.uniq
    end
  end
end
