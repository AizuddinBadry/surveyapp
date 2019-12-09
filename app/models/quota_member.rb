class QuotaMember < ApplicationRecord
  belongs_to :quota
  belongs_to :question
end
