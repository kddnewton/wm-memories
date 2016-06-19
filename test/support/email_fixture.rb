# frozen_string_literal: true
class EmailFixture

  attr_reader :text, :html

  # store the text and html
  def initialize(name, current_binding)
    @name = name
    @text = read('text', current_binding)
    @html = read('html', current_binding)
  end

  private

  # read the part from a fixture
  def read(part, current_binding)
    plain = IO.readlines(Rails.root.join('test', 'fixtures', 'moderator_mailer', "#{@name}.#{part}.erb")).join
    ERB.new(plain).result(current_binding)
  end
end
