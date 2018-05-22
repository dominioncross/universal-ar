require_dependency "universal_ar/application_controller"

module UniversalAr
  class NotesController < ApplicationController
    before_action :find_subject

    def index
      render json: { notes: notes_json }
    end

    private

    def notes_json
      @subject.notes.map(&:json)
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
