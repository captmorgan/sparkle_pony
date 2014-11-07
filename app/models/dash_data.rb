class DashData

  def initialize(dq_id)
    @dq = DashboardQuery.where(:dashboard_id => dq_id).first
    @client = Mysql2::Client.new(dbconfig.symbolize_keys)
    @query_data = @client.query(@dq.query)
  end

  def dbconfig
    YAML::load(File.open("#{Rails.root}/config/dashdata.yml"))['dashdata']
  end
  private :dbconfig

  def query(sql)
    [true, @client.query(add_limit(sql, limit))]
  rescue => e
    [false, [:error => e.message]]
  end
  private :query

  def reformat_data
    groups = Hash.new
    output = Array.new

    x_axis = @dq.x_axis
    y_axis = @dq.y_axis
    group  = @dq.group

    if group.nil?
      @query_data.each do |row| 
        groups[row[x_axis]] = row[y_axis]
      end
      return groups, @query_data
    end

    # http://i.imgur.com/EdTjP.jpg
    @query_data.each do |row|
      if !groups.keys.include? row[group] 
         groups[row[group]]=Hash[row[x_axis],row[y_axis]]
      else
        groups[row[group]].merge!Hash[row[x_axis],row[y_axis]]
      end
    end
    
    groups.each do |things|
      data = {:name => things[0], :data => things[1]}
      output.push(data)
    end

    return output, @query_data
  end

end
