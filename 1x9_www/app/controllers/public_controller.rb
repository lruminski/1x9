require 'cgi'

class PublicController < ApplicationController
  before_filter :get_session
   
  def index

    return seo_request if request.content_type == 'application/x-swfaddress' 

    unless session[:swfaddress].blank?
      swfaddress = session[:swfaddress]
      session[:swfaddress] = nil
    else
      swfaddress = request.env['REQUEST_URI']
      clean_swfaddress(swfaddress)
    end
    
    @swfaddress = CGI.escape(swfaddress)
    @swfaddress_path = swfaddress.split('?')[0]
    title_path =  @swfaddress.scan(/([^\/]+)\//).collect{|word| word[0].titleize}.join(" / ")
    @title = "1X9 " + (swfaddress == "/" ? "" : " / " + title_path)
    @datasource_params = params
  end

  def datasource
    @swfaddress_path = params[:swfaddress]
    render :partial => 'datasource', :content_type => 'text/xml'
  end
  
  private

  def clean_swfaddress(str)
    str = str.sub(/([^\/])(\?|$)/, "\\1/\\2")
  end

  def seo_request
    qs = request.env['QUERY_STRING']
    session[:swfaddress] = qs
    if qs == '/'
      render :nothing => true
    else
      render :text => "location.replace('/##{qs}')"
    end
  end
  
  def get_session
  end

end
