class Users::SessionsController < Devise::SessionsController
  respond_to :json, :only => :current

  def show
    @user = User.where(:email => params[:id]).first
    @articles = @user.articles.order_by(:updated_at.desc).limit(5)
  end

  def current
    resp = {
      :user => (user_signed_in? ? current_user : nil),
      :flash => (flash.empty? ? nil : flash)
    }
    begin
      respond_with resp
    rescue ActionView::MissingTemplate => e
      log "#{e.to_s.split[0..2].join(' ')} | #{request.referrer} | #{request.user_agent} | #{request.ip} | #{request.accept}"
    end
  end
end
