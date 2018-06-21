require_dependency "universal_ar/application_controller"

module UniversalAr
  class LogsController < ApplicationController
    before_action :find_subject

    def index
      render json: { logs: logs_json }
    end

    private

    def logs_json
      if @subject
        logs = @subject.logs
      elsif current_user
        logs = current_user.created_logs
      end
      logs.decorate.map(&:json)
    end

    def find_subject
      return if (params[:subject_type].blank? ||
                    params[:subject_type] == 'undefined') &&
                    (params[:subject_id].blank? ||
                    params[:subject_id] == 'undefined')
      params[:subject_type].classify.constantize.find(params[:subject_id])
    end
  end
end
