class ConditionLink < ApplicationRecord
  belongs_to :question
  belongs_to :condition
  belongs_to :other_condition, class_name: "Condition", foreign_key: 'other_condition_id'
end
