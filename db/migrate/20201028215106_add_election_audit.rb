# This is a horrible simple mechanism to have an audit component in place.
class AddElectionAudit < ActiveRecord::Migration[6.0]
  def change
    create_table :election_audits do |t|
      t.references :election, nil: false, index: true
      t.references :question, nil: true, index: true
      t.timestamp :event_date, nil: false
      t.string :record_type, nil: false
      t.bigint :record_id, nil: false
      t.string :change_type, nil: false
      t.string :audit_changes, nil: false
      # Changed by ... Not really required at this time
      t.integer :changed_by_id, nil: true
    end
  end
end
