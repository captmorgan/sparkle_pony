class User::DashboardsController < ApplicationController

  def home
    @dashboards = Dashboard.where(:user_id => session[:user_id]).order("created_at DESC")
  end

  def new
    if QueryManager.for(session[:session_id]).nil?
      redirect_to '/'
    end
  end

  def show
    graph_data = DashData.new(params[:id])
    @gd, @results = graph_data.reformat_data
    @title = Dashboard.find(params[:id]).name
  end

  def edit
    @dboard = Dashboard.find_by_id(params[:id])
    @dq = @dboard.dashboard_queries.first
    @x_axis = @dq.x_axis
    @y_axis = @dq.y_axis
    @group = @dq.group

  end

  def delete
    Dashboard.find_by_id(params[:id]).destroy
    redirect_to user_dashboards_home_path
  end

  def update_name

    dboard = Dashboard.find_by_id(params[:id])
    dboard.update_attributes({:name => params[:dashboard][:name]})
    render :nothing => true
  end

  def update_query
    success, cols = set_col_names(params[:dashboard_query][:query])

    if success
      dq = DashboardQuery.find_by_id(params[:id])

      dq.update_attributes!({:query => params[:dashboard_query][:query]})
      if cols.first.keys.length == 2
        dq.update_attributes({:group => nil})
      end

      respond_to do |format|
        format.json { render :json => cols.first.keys.to_json, :status => 200}
      end

    else
      respond_to do |format|
        # its funny because in this case, they aren't actually cols.
        format.json { render :json => cols.to_json, :status => 500}
      end

    end
  end

  def update_cols
    @dq = DashboardQuery.find_by_id(params[:id])

    @dq.update_attributes({
      :x_axis => params[:x_axis],
      :y_axis => params[:y_axis],
      :group  => params[:group]
      }
    )
    render nothing: true
  end

  def create
    @user = User.find_by_id(session[:user_id])

    dashboard = @user.dashboards.create({
      :name    => params[:name]})
    dashboard.dashboard_queries.create({
      :query  => params[:query],
      :x_axis => params[:x_axis],
      :y_axis => params[:y_axis],
      :group  => params[:group]
      }
    )
      redirect_to dashboard_thing_path(dashboard)
  end

  def get_col_names
    success, cols = set_col_names(params[:query])
    if success
      respond_to do |format|
        format.json { render :json => cols.first.keys.to_json, :status => 200}
      end
    else
      respond_to do |format|
        format.json { render :json => cols.to_json, :status => 500}
      end
    end
  end

  private
  def set_col_names(sql)
    qm = QueryManager.for(session[:session_id])
    success, results = qm.query(sql, 2)
  end
end
