# typed: strict
# frozen_string_literal: true

class EmailFixture
  extend T::Sig

  DIRECTORY =
    T.let(
      -T.must(Rails.root).join('test', 'fixtures', 'moderator_mailer').to_s,
      String
    )

  sig { returns(String) }
  attr_reader :text

  sig { returns(String) }
  attr_reader :html

  # store the text and html
  sig { params(name: String, current_binding: Binding).void }
  def initialize(name, current_binding)
    @name = T.let(name, String)
    @text = T.let(read('text', current_binding), String)
    @html = T.let(read('html', current_binding), String)
  end

  private

  # read the part from a fixture
  sig { params(part: String, current_binding: Binding).returns(String) }
  def read(part, current_binding)
    plain = IO.readlines(File.join(DIRECTORY, "#{@name}.#{part}.erb")).join
    ERB.new(plain).result(current_binding)
  end
end
