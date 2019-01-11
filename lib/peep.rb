require_relative 'database_connection'
require 'pg'

class Peep

  attr_reader :id, :content, :date

  def initialize(id:, content:, date:)
    @id = id
    @content = content
    @date = date
  end

  def self.all 
    result = DatabaseConnection.query('SELECT * FROM peeps ORDER BY date DESC')
    result.map { |peep| Peep.new(
      id: peep['id'],
      content: peep['content'],
      date: peep['date'])
    }
  end

  def self.create(content:)
    result = DatabaseConnection.query("INSERT INTO peeps (content) VALUES( '#{content}' ) RETURNING id, content, date")
  end


end