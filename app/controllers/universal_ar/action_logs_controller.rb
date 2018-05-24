require_dependency "universal_ar/application_controller"

module UniversalAr
  class ActionLogsController < ApplicationController
    before_action :find_subject

    def index
      render json: { action_logs: action_logs_json }
    end

    private

    def action_logs_json
      @subject.action_logs.map(&:json)
    end

    def find_subject
      return nil if params[:subject_type].blank? ||
                    params[:subject_type] == 'undefined' ||
                    params[:subject_id].blank? ||
                    params[:subject_id] == 'undefined'
      @subject = params[:subject_type].classify.constantize.find(params[:subject_id])
    end
  end
end
