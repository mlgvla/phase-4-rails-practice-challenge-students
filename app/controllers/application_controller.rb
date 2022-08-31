class ApplicationController < ActionController::API
    wrap_parameters format: []
    rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_record_response
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

    private

    def render_invalid_record_response(invalid)
        render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
    end

    def render_not_found_response(not_found)
        render json: { errors:["Couldn't find #{not_found.model} with 'id'=#{not_found.id}"]}, status: :not_found
    end    
end
