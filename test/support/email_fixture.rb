# typed: true
# frozen_string_literal: true

class EmailFixture
  directory = T.must(Rails.root).join('test', 'fixtures', 'moderator_mailer')
  DIRECTORY = directory.to_s.freeze

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
    plain = IO.readlines(File.join(DIRECTORY, "#{@name}.#{part}.erb")).join
    ERB.new(plain).result(current_binding)
  end
end
