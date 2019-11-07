# typed: false
# frozen_string_literal: true

class Photo < ApplicationRecord
  has_attached_file :attachment,
                    styles: { thumbnail: '140x140#', modal: '440x>' }

  validates_attachment :attachment,
                       presence: true,
                       content_type: { content_type: %r{\Aimage/.*\z} }

  belongs_to :story
end
