class Quota < ApplicationRecord
  belongs_to :survey
  has_many :quota_members
end
