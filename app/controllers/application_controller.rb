class ApplicationController < ActionController::API
    include JsonWebToken
    
    before_action :authenticate_request

    private
        def authenticate_request
            begin
                header = request.headers['Authorization']
                header = header.split(" ").last if header
                decoded = jwt_decode(header)
                @current_user = User.find(decoded[:user_id])
            rescue
                render json: { errors: "Unauthorized" }, status: :unauthorized
            end
        end

        def admin_authenticate_request
            authenticate_request()
            if !@current_user.is_admin
                render json: { errors: "Unauthorized" }, status: :unauthorized
            end
        end

end
