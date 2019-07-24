class Like < ApplicationRecord
  belongs_to :photo,optional: true
  belongs_to :user
end
