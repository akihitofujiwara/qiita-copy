module ResourcesSetter
  extend ActiveSupport::Concern

  class_methods do
    def method_missing(method, *args)
      case method
      when /^(before|after|around)_(.+)$/
        _.("#{$1}_action").(*args, only: $2.split("_or_").map(&:to_sym))
      end
    end
  end

  protected
    def method_missing(method, *args)
      case method
      when /^set_(.+)_by_params_from_(.+)$/ then $1.split("_and_").each &-> name { set_by_params_from_parent name, $2 }
      when /^set_(.+)_by_params$/ then $1.split("_and_").each &_.set_by_params
      when /^set_new_(.+)_from_current_user$/ then $1.split("_and_").each &_.set_new_from_current_user
      when /^set_new_(.+)$/ then $1.split("_and_").each &_.set_new
      when /^set_(.+)$/ then $1.split("_and_").each &_.set_all
      end
    end

  private
    def set_all(name)
      instance_variable_set "@#{name}", model(name).all
    end

    def set_by_params(name)
      if (id = id_in_params name).present?
        instance_variable_set "@#{name}", model(name).find(id)
      end
    end

    def set_by_params_from_parent(name, parent_name)
      if (id = id_in_params name).present?
        instance_variable_set "@#{name}",
          (instance_variable_get("@#{parent_name}") || send(parent_name))
            .send(name.tableize)
            .find(id)
      end
    end

    def set_new(name)
      instance_variable_set "@#{name}", model(name).new
    end

    def set_new_from_current_user(name)
      instance_variable_set "@#{name}", current_user.send(name.tableize).build
    end

    def model(name)
      name.classify.constantize
    end

    def subject_name
      self.class.name.match(/(\w+)Controller/)[1].singularize.underscore
    end

    def id_in_params(name)
      params[name == subject_name ? :id : "#{name}_id".to_sym]
    end
end

