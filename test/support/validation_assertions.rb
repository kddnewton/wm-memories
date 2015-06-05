module ValidationAssertions

  private

    # assert that the given klass has a validator on the given attribute
    def assert_has_validator(klass, attribute, validator)
      assert_includes klass.validators_on(attribute).map(&:class), validator
    end

    # assert that the given klass validates the format of the given attributes
    def assert_validates_format_of(klass, *attributes, value, message: I18n.t('errors.messages.invalid'))
      attributes.each do |attribute|
        instance = klass.new(attribute => value)
        assert_not instance.save
        assert_includes instance.errors[attribute], message
        assert_has_validator klass, attribute, ActiveModel::Validations::FormatValidator
      end
    end

    # assert that the given klass validates the inclusion of the given attributes
    def assert_validates_inclusion_of(klass, *attributes, value, message: I18n.t('errors.messages.inclusion'))
      attributes.each do |attribute|
        instance = klass.new(attribute => value)
        assert_not instance.save
        assert_includes instance.errors[attribute], message
        assert_has_validator klass, attribute, ActiveModel::Validations::InclusionValidator
      end
    end

    # assert that the given klass validates presence of the given attributes
    def assert_validates_presence_of(klass, *attributes, message: I18n.t('errors.messages.blank'))
      attributes.each do |attribute|
        instance = klass.new(attribute => nil)
        assert_not instance.save
        assert_includes instance.errors[attribute], message
        assert_has_validator klass, attribute, ActiveRecord::Validations::PresenceValidator
      end
    end

    # assert that the given klass validates uniqueness of the given attributes
    def assert_validates_uniqueness_of(klass, *attributes, message: I18n.t('errors.messages.taken'))
      attributes.each do |attribute|
        instance = klass.new(attribute => klass.first.send(attribute))
        assert_not instance.save
        assert_includes instance.errors[attribute], message
        assert_has_validator klass, attribute, ActiveRecord::Validations::UniquenessValidator
      end
    end

end
