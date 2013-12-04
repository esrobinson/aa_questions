class Table
  def save
    tables = {
      User => 'users',
      Question => 'questions',
      Reply => 'replies'
    }

    options = {}
    self.instance_variables[1..-1].each do |var|
      key = var.to_s.delete("@").to_sym
      options[key] = self.send(key)
    end

    if self.id.nil?
      $db.execute(<<-SQL, options)
      INSERT INTO
        #{tables[self.class]}(
        #{ options.map{ |key, value| "#{key}"}.join(',')})
      VALUES
        (#{ options.map{ |key, value| ":#{key}"}.join(',')})
      SQL

      self.id = $db.last_insert_row_id
    else
      $db.execute(<<-SQL, options, :id => self.id)
      UPDATE
        #{tables[self.class]}
      SET
        #{options.map{ |key, value| "#{key} = :#{key}"}.join(',')}
      WHERE
        id = :id
      SQL
    end
  end

end