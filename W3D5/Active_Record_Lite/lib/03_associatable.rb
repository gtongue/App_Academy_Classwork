require_relative '02_searchable'
require 'active_support/inflector'
require 'byebug'

# Phase IIIa
class AssocOptions
  attr_accessor(
    :foreign_key,
    :class_name,
    :primary_key
  )

  def model_class
    @class_name.constantize
  end

  def table_name
    model_class.table_name
  end
end

class BelongsToOptions < AssocOptions
  def initialize(name, options = {})
    @foreign_key = options[:foreign_key] ? options[:foreign_key] : (name.to_s+"_id").to_sym
    @class_name = options[:class_name] ? options[:class_name] : name.to_s.camelcase
    @primary_key = options[:primary_key] ? options[:primary_key] : :id
  end
end


class HasManyOptions < AssocOptions
  def initialize(name, self_class_name, options = {})
    @foreign_key = options[:foreign_key] ? options[:foreign_key] : (self_class_name.downcase+"_id").to_sym
    @class_name = options[:class_name] ? options[:class_name] : name.to_s.singularize.camelcase
    @primary_key = options[:primary_key] ? options[:primary_key] : :id
  end
end

module Associatable
  def belongs_to(name, options = {})

    define_method(name) do 
      assoc_option = BelongsToOptions.new(name, options)      
      foreign_key = self.send(assoc_option.foreign_key)
      primary_key = assoc_option.primary_key
      assoc_option
        .model_class
        .where(primary_key => foreign_key)
        .first
    end
  end

  def has_many(name, options = {})
    define_method(name) do 
      # byebug
      assoc_option = HasManyOptions.new(name, self.class.name, options)      
      primary_key = self.send(assoc_option.primary_key)
      foreign_key = assoc_option.foreign_key
      assoc_option
        .model_class
        .where(foreign_key => primary_key)
    end
  end

  def assoc_options
    # Wait to implement this in Phase IVa. Modify `belongs_to`, too.
  end
end

class SQLObject
  # Mixin Associatable here...
  extend Associatable
end
