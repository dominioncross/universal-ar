require_dependency "universal_ar/application_controller"

module UniversalAr
  class AttachmentsController <  UniversalAr::ApplicationController
    
    skip_before_action :validate_scope
    before_action :find_subject
    
    def index
      if !@subject.nil?
        if !params[:redactor].blank?
          render json: @subject.attachments.map{|a| {
            title: a.title,
            name: a.file_identifier,
            url: a.file.url,
            id: a.id,
            size: "0Kb"
          }}
        else
          render json: {attachments: @subject.attachments.map{|a| a.to_json}}
        end
      else
        render json: {attachments: []}  
      end
      
    end
    
    def create
      if !@subject.nil?
        if !params[:file].blank?
          att = @subject.attachments.create file: params[:file], scope: @subject.scope, user: current_user
          render json: { url: att.file.url, id: att.id.to_s }
        elsif !params[:files].blank?
          attachments = []
          params[:files].each do |file|
            att = @subject.attachments.create file: file, scope: @subject.scope, name: params[:name], user: current_user
            puts att.errors.to_json
            attachments.push(att)
          end
          render json: {attachments: @subject.attachments.map{|a| a.to_json}}
        end
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