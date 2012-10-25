
#Used to validate whether the type attribute of a polymorphic association corresponds
#to a valid class which implements the polymorphic association.
#Code taken from: http://stackoverflow.com/questions/10410201/validating-polymorphic-association-type-in-rails
class OnlyPolymorphicValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    polymorphic_type = attribute.to_s.sub('_type', '').to_sym
    specified_class = value.constantize rescue nil
    this_association = record.class.to_s.underscore.pluralize.to_sym

    unless(specified_class.reflect_on_association(this_association).options[:as] == polymorphic_type rescue false)
      record.errors[attribute] << (options[:message] ||
                                   "#{value} isn't a valid type for #{attribute}")
    end
  end
end
