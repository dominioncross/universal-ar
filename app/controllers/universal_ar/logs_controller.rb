require_dependency "universal_ar/application_controller"

module UniversalAr
  class LogsController < ApplicationController
    before_action :find_subject

    def index
      render json: { logs: logs_json }
    end

    private

    def logs_json
      @subject.logs.map(&:json)
    end

    def find_subject
      @subject = if (params[:subject_type].blank? ||
                    params[:subject_type] == 'undefined') &&
                    (params[:subject_id].blank? ||
                    params[:subject_id] == 'undefined')
                   current_user
                 else
                   params[:subject_type].classify.constantize.find(params[:subject_id])
                 end
    end
  end
end
