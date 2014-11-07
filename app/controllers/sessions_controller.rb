class SessionsController < ApplicationController

  before_filter :set_dbs, :except => :destroy

  def new
  end

  def create
    begin
      QueryManager.create_for(
        session[:session_id],
        params[:name],
        params[:password],
        params[:db]
      )
      # if creating a query manager is OK, then we're ok with this user even if new

      user = User.find_by_name(params[:name])
      if user.nil?
        user = User.create(name: params[:name])
      end

      session[:user_id] = user.id
      redirect_to '/user/query'
    rescue => e
      flash[:error] = e.message
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => 'Logged out'
  end

  def set_dbs
    @dbs = QueryManager.dbs
  end
end
