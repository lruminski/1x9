class UsersController < Application
  
  # Authenticate the session
  def authenticate
    
    # Generate server the client will use for future communication
    #token = Kernel.rand(999_999_999_999).to_s

    result = {
      #:token => token,
      :token => @session.session_id,
      :id => @session.session_id
    }
    
    return result
  end


end
