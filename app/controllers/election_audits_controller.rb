class ElectionAuditsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_election, only: [:index]

  # GET /questions
  # GET /questions.json
  def index
    @election_audits = ElectionAudit.where(election_id: @election.id).order(:election_id, :question_id, :record_id)
  end

  private
  # Use callbacks to share common setup or constraints between actions.

  def set_election
    @election = Election.find(params[:election_id])
  end
end
