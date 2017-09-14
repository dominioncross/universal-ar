require_dependency "universal_ar/application_controller"

module UniversalAr
  class AttachmentsController <  UniversalAr::ApplicationController
    
    skip_before_action :validate_scope
    before_action :find_subject
    
    def index
      if !@subject.nil?
        render json: {attachments: @subject.attachments.map{|a| a.to_json}}
      else
        render json: {attachments: []}  
      end
      
    end
    
    def create
      if !@subject.nil?
        attachments = []
        params[:files].each do |file|
          att = @subject.attachments.create file: file, scope: @subject.scope, name: params[:name], user: current_user
          puts att.errors.to_json
          attachments.push(att)
        end
        render json: {attachments: @subject.attachments.map{|a| a.to_json}}
      end
    end
   
    def destroy
      @attachment = UniversalAr::Attachment.find(params[:id])
      @subject = @attachment.subject
      @attachment.destroy
      render json: {attachments: @subject.attachments.map{|a| a.to_json}}
    end
   
    private
    def find_subject
      if !params[:subject_type].blank? and params[:subject_type] != 'undefined' and !params[:subject_id].blank? and params[:subject_id] != 'undefined'
        @subject = params[:subject_type].classify.constantize.find(params[:subject_id])
      end      
    end
    
  end
end