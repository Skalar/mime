class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'

  before_filter :set_locale, :keep_flash, :handle_mobile

  rescue_from CanCan::AccessDenied do |exception|
    respond_to do |format|
      format.html { redirect_to root_url, :alert => exception.message }
      format.json { render nothing: true, status: :forbidden }
    end
  end

  helper_method :is_mobile_view?
  
  def is_mobile_view?
    (!cookies[:mobile_view].present? && request.subdomain.to_s == 'mobil') || cookies[:mobile_view] == true
  end
  
  protected

  def enable_mobile_view
    cookies.permanent[:mobile_view] = true
  end
  
  def disable_mobile_view
    cookies.permanent[:mobile_view] = false
  end
  
  private

  def prevent_anonymous
    unless user_signed_in?
      flash.alert = t('articles.login_teaser_html', :login_link => self.class.helpers.link_to(t('articles.login_link'), user_omniauth_authorize_path(:facebook)))
      set_user_return_to(url_for(params.slice(:id, :controller, :action)))
      redirect_to(request.env["HTTP_REFERER"] || root_path)
    end
  end
  
  def handle_mobile
    request.format = :mobile if is_mobile_view?
  end
  
  def keep_flash
    flash.keep
  end

  def find_page
    id = params[:page_id].present? ? params[:page_id] : params[:id]
    @page = Page.find(id)
  end

  def find_article
    @slug = if !params[:slug].blank?
      params[:slug]
    elsif !params[:article_id].blank?
      params[:article_id]
    else
      params[:id]
    end
    return unless @slug
    @article = Article.where(:headword => /^#{Regexp.escape(deparameterize(@slug))}$/i).first
    # Try to find an earlier version with the slug as headword
    unless @article
      @article = Article.where(:'versions.headword' => /^#{Regexp.escape(deparameterize(@slug))}$/i).first
    end
  end

  def article_not_found
    if @article.nil?
      respond_to do |format|
        format.any(:html, :mobile) { render :file => "#{Rails.public_path}/404.html" , :status => :not_found, :layout => false }
        format.json { render :status => :not_found, :text => ''}
      end
      log "404 NOT FOUND #{params[:slug]}"
      return false
    end
  end

  def deparameterize(thing)
    thing.gsub(/%2F/, '/').gsub(/_/, ' ')
  end

  def set_user_return_to(path)
    session[:user_return_to] = path
  end

  def set_locale
    I18n.locale = :'no-NB'
    WillPaginate::ViewHelpers.pagination_options[:previous_label] = I18n.t('will_paginate.previous')
    WillPaginate::ViewHelpers.pagination_options[:next_label] = I18n.t('will_paginate.next')
  end

  def request_info
    " | #{request.referrer} | #{request.user_agent} | #{request.ip}"
  end

  def log(message)
    message = message.to_s
    message += request_info if request
    Rails.env.production? ? puts(message) : Rails.logger.debug(message)
  end

  def action_not_found
    render :file => "#{Rails.public_path}/404.html", :status => :not_found, :layout => false
    log "ACTION NOT FOUND #{controller_name}##{action_name}"
  end
end
