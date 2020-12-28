# We need this monkey-patch in order to run on Ruby 3 because of the separation
# of keyword arguments.
class Paperclip::Validators::AttachmentContentTypeValidator
  def mark_invalid(record, attribute, types)
    record.errors.add(attribute, :invalid, **options.merge(types: types.join(', ')))
  end
end
