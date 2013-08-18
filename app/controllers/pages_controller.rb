class PagesController < ApplicationController

  before_filter :check_session, except: [:index, :documentation]

  def index
  end

  def stories
    unless @story.present?
      str = ""
      str += "\nExample Feature File:\n\n"
      str += "Feature:\n"
      str += "\tAs a User\n"
      str += "\tI should be able to Sign in\n"
      str += "\tSo that ....\n\n"
      str += "\t@mango @567\n"
      str += "\tScenario: As a User, I should be able to Sign in\n"
      str += "\t\tGiven I am on the \"Sign In\" page\n"
      str += "\t\tWhen I type my login credentials: |email|password| |user@example.com|defaultpassword123!|\n"
      str += "\t\tAnd I press the \"Sign In\" button\n"
      str += "\t\tAnd I should be on \"Home\" page\n"
      str += "\t\tThen I should be able to Finish this Pivotal Story with ID \"567\""

      @feature = str
    end
  end

  def convert
    @story = @project.stories.find(params[:id])
    build_feature(@story)
    render 'stories'
  end

  def clear
    session[:token] = ''
    session[:project_id] = ''
    redirect_to root_path, notice: 'Successfully Cleared'
  end

  def auth
    check_session
    redirect_to stories_path, notice: 'Successfully Connected'
  end

  def documentation
    @language = "Markdown"
  end

private
  def check_session
    if session[:token].present?
      fetch_client
    else
      redirect_to root_path, alert: 'Error in connection'
    end
  end

  def fetch_client
    PivotalTracker::Client.token = session[:token]
    begin
      @project = PivotalTracker::Project.find(session[:project_id])
      flash[:notice] = 'Successfully Connected'
    rescue
      redirect_to root_path, alert: 'Error in connection'
    end
  end


  def build_feature (story)
    str = ""
    name = story.name.split(',')
    str += "\nFeature:\n"
    str += "\t#{name[0]}\n"
    str += "\t#{name[1].strip}\n"
    str += "\tSo that\n\n"
    str += "\t@mango @#{story.id}\n"
    str += "\tScenario: #{story.name}\n"
    tasks = story.tasks.all
    if tasks.present?
      tasks.each do |task|
        str += "\t\t#{task.description}\n"
      end
    end
    str += "\t\tThen I should be able to Finish this Pivotal Story with ID \"#{story.id}\""

    @feature = str
  end
end
