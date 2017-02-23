class MatchesController < ApplicationController
  before_filter :set_matcher

  def create
    @match = @matcher.matches.build(match_params)

    if @match.valid? && @matcher.deactivate!
      @match.save!
      flash[:success] = "Match successfully saved"
      redirect_to @matcher.path
    else
      flash[:error] = "Uh oh! Something went wrong. Please try again later."
      redirect_to @matcher.path
    end
  end

  private

  def match_params
    params.require('match').permit(:matched_with)
  end

  def set_matcher
    @matcher = matchable_type.find(matchable_id)
  end

  def matchable_type
    @matchable_type ||= params[:matchable_type].constantize
  end

  def matchable_id
    @matchable_id ||= params[:matchable_id]
  end
end
