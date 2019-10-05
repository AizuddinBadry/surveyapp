class Company < ApplicationRecord
    include ImageUploader.attachment(:image)
    has_many :users
end
