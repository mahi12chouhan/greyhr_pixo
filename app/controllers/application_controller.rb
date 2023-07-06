class ApplicationController < ActionController::Base

  def not_found
    render json: { error: 'not_found' }
  end


  # def authorize_request
  #   header = request.headers['Authorization']
  #   header = header.split(' ').last if header
  #   begin
  #     @decoded = JsonWebToken.decode(header)
  #     @current_user = User.find(@decoded[:user_id])
  #   rescue ActiveRecord::RecordNotFound => e
  #     render json: { errors: e.message }, status: :unauthorized
  #   rescue JWT::DecodeError => e
  #     render json: { errors: e.message }, status: :unauthorized
  #   end
  # end

  def authenticate_employee
    token = request.headers['Authorization']&.split(' ')&.last
    return head :unauthorized unless token && TokenService.verify_token(token)

    @current_employee = find_employee_from_token(token)
  end

  def find_employee_from_token(token)
    payload = TokenService.verify_token(token)
    Employee.find(payload['employee_id'])
  end

end