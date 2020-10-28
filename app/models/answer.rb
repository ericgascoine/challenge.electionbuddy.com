class Answer < ApplicationRecord
  include Audit
  belongs_to :question
  delegate :election_id, to: :question
end
