require 'spec_helper'

describe PagesController do

  describe 'GET index' do

    it "renders the index template" do
      get :index
      expect(response).to render_template('index')
    end

  end

  describe 'POST auth' do

    before(:each) {
      post :auth, { token: 'c0d4bc0f8ecade8f868ab1c72cccec12', project_id: '892984' }
    }

    it "stores the token to a session store" do
      session[:token].should_not be_nil
    end

    it "redirects to the stories_path" do
      expect(response).to redirect_to stories_path
    end

    it "returns with the successful message" do
      flash[:notice].should.eql? 'Successfully Connected'
    end

  end

  describe 'GET stories' do

    before(:each) { save_session }

    it "renders the stories template" do
      get :stories
      expect(response).to render_template('stories')
    end

    after(:each) { clear_session }

  end

  describe 'GET convert' do
    before(:each) {
      save_session
      get :convert, id: '55340544'
    }

    it "renders the stories template" do
      expect(response).to render_template('stories')
    end

    it "assigns @story" do
      assigns(:story).should_not be_false
    end

    after(:each) { clear_session }
  end

  describe 'DELETE auth' do
    before(:each) {
      save_session
      delete :clear
    }

    it "redirects to the root_path" do
      expect(response).to redirect_to root_path
    end

    it "returns with a success notice" do
      flash[:notice].should.eql? 'Successfully Cleared'
    end

    it "clears the session store" do
      session[:token].should.eql? ''
    end

  end

  describe 'methods' do

    describe 'check_session' do

      it "redirects to root_path when the session is empty" do
        get :stories
        expect(response).to redirect_to root_path
      end

    end

    describe 'fetch_client' do

      before(:each) {
        save_session
      }

      it "redirects to root_path when the session is invalid" do
        session[:token] = '1231'
        get :stories
        expect(response).to redirect_to root_path
      end

      it "assigns @project" do
        get :stories
        assigns(:project).should_not be_false
      end

      it "renders a success notice" do
        get :stories
        flash[:notice].should.eql? 'Successfully COnnected'
      end

    end

    describe 'build_feature' do

      before(:each) {
        save_session
        get :convert, id: '55340544'
      }

      it "assigns @feature" do
        assigns(:feature).should_not be_false
      end
    end

  end

  def save_session
    session[:token] = 'c0d4bc0f8ecade8f868ab1c72cccec12'
    session[:project_id] = '892984'
  end

  def clear_session
    session[:token] = ''
    session[:project_id] = ''
  end

end
