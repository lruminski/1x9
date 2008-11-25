class Application 
  def record(params)
    params.symbolize_keys!;
    
    if params[:id] == -1
      params.delete_if {|key, value| key == :id }
    end
    
    return params
  end
end
