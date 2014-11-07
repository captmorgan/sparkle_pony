class QueryManager

  # class vars/methods for stashing a query manager for each session

  @@dbconfig = nil
  @@query_managers = {}

  def self.create_for(session_id, un, pwd, db)
    @@query_managers[session_id] = QueryManager.new(un, pwd, db)
  end

  def self.for(session_id)
    @@query_managers[session_id]
  end

  def self.dbs
    dbconfig['dbs']
  end

  def self.dbconfig
    @@dbconfig ||= YAML::load(File.open("#{Rails.root}/config/query_database.yml"))[Rails.env]
  end

  # the normal query manager stuff: connect to db and query

  def initialize(un, pwd, db)
    @client = Mysql2::Client.new(
      QueryManager.dbconfig.symbolize_keys.merge({
        :username => un,
        :password => pwd,
        :database => db
      }))
  end

  # stealing a client for async things.
  def get_client
    @client
  end

  def query(sql, limit)
    Rails.logger.debug "query to execute is: #{add_limit(sql, limit)}"
    [true, @client.query(add_limit(sql, limit))]
  rescue => e
    [false, [:error => e.message]]
  end

  def recent_queries(user_id, limit: 25)
    Query.where(:user_id => user_id).limit(limit)
  end

  def add_limit(sql, limit)
    sql = sql.gsub(/[ ]*[;]*[ ]*$/, '')
    unless sql =~ /limit [0-9]*/i
      sql << " limit #{limit}"
    end

    sql
  end
  private :add_limit
end
