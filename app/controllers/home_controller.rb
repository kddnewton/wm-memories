# typed: strict
# frozen_string_literal: true

class HomeController < ApplicationController
  extend T::Sig

  # GET /about
  sig { returns(NilClass) }
  def about; end
end
