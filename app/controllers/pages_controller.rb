class PagesController < ApplicationController

  def index
    if params[:token].present? && params[:project_id].present?
      PivotalTracker::Client.token = params[:token]
      @project = PivotalTracker::Project.find(params[:project_id])
    end
  end
end
