class Question < ApplicationRecord
  include Audit

  belongs_to :election
  has_many :answers
end
