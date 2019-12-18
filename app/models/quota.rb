class Quota < ApplicationRecord
  belongs_to :survey
  has_many :quota_members, dependent: :delete_all
end
