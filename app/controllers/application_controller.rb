class ApplicationController < ActionController::Base
  protect_from_forgery
  layout 'application'

  # WillPaginate::ViewHelpers.pagination_options[:previous_label] = I18n.t('will_paginate.previous')
  # WillPaginate::ViewHelpers.pagination_options[:next_label] = I18n.t('will_paginate.next')

  private

  def find_article
    @slug = if !params[:slug].blank?
      params[:slug]
    elsif !params[:article_id].blank?
      params[:article_id]
    else
      params[:id]
    end
    @article = Article.where(:headword => /^#{Regexp.escape(deparameterize(@slug))}$/i).first
  end

  def deparameterize(thing)
    thing.gsub(/%2F/, '/').gsub(/_/, ' ')
  end

  def set_user_return_to(path)
    session[:user_return_to] = path
  end
end
