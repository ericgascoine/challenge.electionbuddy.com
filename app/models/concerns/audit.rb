require 'active_support/concern'

module Audit extend ActiveSupport::Concern
  def create_audit
    ElectionAudit.create!(
        election_id: (self.is_a?(Election) ? self.id : (self.respond_to?(:election_id) ? self.election_id : nil)),
        question_id: (self.is_a?(Question) ? self.id : (self.respond_to?(:question_id) ? self.question_id : nil)),
        event_date: Time.now,
        record_type: self.model_name,
        record_id: self.id,
        change_type: self.new_record? ? 'create' : 'update',
        audit_changes: self.new_record? ? self.attributes.to_json : self.changes.to_json
    )

  end

  def create_destroy_audit
    ElectionAudit.create!(election_id: (self.is_a?(Election) ? self.id : (self.respond_to?(:election_id) ? self.election_id : nil)),
                          question_id: (self.is_a?(Question) ? self.id : (self.respond_to?(:question_id) ? self.question_id : nil)),
                          event_date: Time.now,
                          record_type: self.model_name,
                          record_id: self.id,
                          change_type: 'destroy',
                          audit_changes: self.attributes.to_json
    )
  end

  included do
    before_save :create_audit
    before_destroy :create_destroy_audit
  end
end