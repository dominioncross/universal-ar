module UniversalAr
  class LogDecorator < ApplicationDecorator
    delegate_all

    def json
      {
        id: id.to_s,
        code: code,
        message: message,
        date: l(created_at, format: :long),
        time_ago: [h.time_ago_in_words(created_at), 'ago'].join(' '),
        user_id: user_id.to_s,
        user_name: user.nil? ? nil : user.name
      }
    end

    def message
      I18n.t  "logs.#{subject_type.underscore.downcase}.#{code}",
              subject_name: subject.name,
              name: user.name,
              value: value
    end
  end
end
