class Users::SessionsController < Devise::SessionsController
  skip_before_filter :keep_flash
  respond_to :json, :only => :current

  def show
    @user = User.where(:email => params[:id]).first
    if @user.nil?
      render :file => "#{Rails.public_path}/404.html" , :status => :not_found, :layout => false
      log "USER NOT FOUND #{params[:id]}"
      return
    end
    @articles = @user.articles.order_by(:updated_at.desc).limit(5).all
  end

  def current
    request.format = :json # force for mobile apps too. Hack/TODO
    respond_with({
      user: (user_signed_in? ? current_user : nil),
      flash: (flash.empty? ? nil : flash),
      show: [
        can?(:manage, Page.first(conditions: {id: params[:page_id]})) ? '#edit_page_link' : nil
      ].compact
    })
  end
end
