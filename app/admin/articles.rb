# coding: utf-8
ActiveAdmin.register Article do
  # filter setting
  filter :title, :html => "class='hoge'"
  filter :category, :as => :check_boxes
  filter :created_at

  # index action
  index do
    column I18n.t('activerecord.attributes.article.title'), :sortable => :title do |f|
      link_to f.title, admin_article_path(f)
    end
    column I18n.t('activerecord.attributes.article.slug'), :slug
    column I18n.t('activerecord.attributes.article.category_id'), :sortable => :category_id do |f|
      f.category ? link_to(f.category.name, admin_category_path(f.category_id)) : I18n.t(:unknown)
    end
    column I18n.t('activerecord.attributes.article.updated_at'), :updated_at
    column '', do |f|
      links = link_to I18n.t(:edit_link), edit_admin_article_path(f), :class => "edit_link"
      links += link_to I18n.t(:destory_link), admin_article_path(f), :method => :delete, :confirm => I18n.t(:destroy_confirm), :class => "delete_link"
      links
    end
  end

  # index and show sidebar
  sidebar I18n.t(:recent_list), :only => [:index,:show] do
    render('/admin/articles/recent', :articles => ::Article.find(:all, :limit => 5, :order => 'updated_at DESC'))
  end
  # Abbreviation
#  sidebar :recent
end
