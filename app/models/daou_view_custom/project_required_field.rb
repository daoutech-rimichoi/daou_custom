# frozen_string_literal: true

module DaouViewCustom
  class ProjectRequiredField < ActiveRecord::Base
    belongs_to :project

    validates :field_name, presence: true
    validates :field_name, uniqueness: { scope: :project_id }
  end
end
