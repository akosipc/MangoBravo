class ApplicationController < ActionController::Base
  require 'markdown_handler'
  protect_from_forgery with: :exception

  before_filter :persist_token

  def persist_token
    session[:token] = params[:token] if params[:token].present?
    session[:project_id] = params[:project_id] if params[:project_id].present?
  end
end
