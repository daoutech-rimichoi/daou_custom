module DaouCustom
  module IssuePatch
    # 담당자, 범주 필수 처리
    def required_attribute?(name)
      return true if name == 'assigned_to_id'
      return true if name == 'category_id'
      
      super
    end
  end
end
