class PagesController < ApplicationController

  before_filter :check_session, except: [:index]

  def index
  end

  def stories
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
    str = ''
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
        if task.description.include? ':'
          description = task.description.split(':')
          str += "\t\t#{description[0]}\n"
          if description[1].include? '||'
            data = description[1].split('||')
            str += "\t\t\t#{data[0]}|\n"
            str += "\t\t\t|#{data[1]}\n"
          else
            str += "\t\t\t#{description[1]}\n"
          end
        else
          str += "\t\t#{task.description}\n"
        end
      end
    end

    @feature = str
  end
end
