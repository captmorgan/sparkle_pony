class User::QueryController < ApplicationController

  require 'csv'

  before_filter :check_session_variables

  def consolidated
    set_recent_queries(@user.id)

  end

  def history
    @name = @user.name
    set_recent_queries(@user.id, limit: 100)
  end

  def update_history
    user_id = User.find_by_name(params[:name]).id
    set_recent_queries(user_id, limit: 100)
    respond_to do |format|
      format.html { render :partial => "queryhistory" }
    end

  end

  def create
    @success, @results = @query_manager.query(@query, 1000)
    update_query_history

    if @success && params[:csv] == 'true'
      send_data(
        convert_to_csv(@results),
        {
          :filename => "pony_express_#{Time.now.to_i}.csv",
          :disposition => "inline",
          :type => "text/csv"
        }
      )
    else
      respond_to do |format|
        format.html { render :partial => "queryoutput" }
      end
    end

  end

  def show
    @query = Query.find_by_id(params[:id])
  end


  def check_session_variables
    @user = User.find_by_id(session[:user_id])
    @query_manager = QueryManager.for(session[:session_id])

    if @user.nil? || @query_manager.nil?
      return redirect_to '/'
    end
    @query = params[:query]
    @limit = params[:limit]
    return true
  end
  private :check_session_variables

  def update_query_history
    output = @success ? "#{@results.count} rows" : @results.first[:error]
    if query = @user.queries.find_by_input(@query)
      query.update_attributes! :output => output, :updated_at => Time.now
    else
      @user.queries.create({
        :input => @query,
        :rows => @success ? @results.count : nil,
        :output => output
      })
    end
  end
  private :update_query_history

  def set_recent_queries(user_id, limit: 25)
    @queries = @query_manager.recent_queries(user_id, limit: limit)
  end
  private :set_recent_queries

  def convert_to_csv(results)
    csv_string = CSV.generate do |csv|
      header_printed = false
      results.each do |result|
        unless header_printed
          csv << result.keys
          header_printed = true
        end
        csv << result.values
      end
    end

    csv_string
  end
  private :convert_to_csv

  def render_history
    set_recent_queries(@user.id)
    render :partial => "queryhistory"
  end


end
