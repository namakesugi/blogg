# coding: utf-8
ActiveAdmin.register Article, :menu_item_name => 'hoge' do
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

  show do |article|
    panel "#{article.title}" do
      table :for => article do
        tr :class => "article_slug" do
          th I18n.t('activerecord.attributes.article.slug')
          td article.slug
        end
        tr :class => "article_category" do
          th I18n.t('activerecord.attributes.article.category_id')
          td article.category ? link_to(article.category.name, admin_category_path(article.category_id)) : I18n.t(:unknown)
        end
        tr :class => "article_content" do
          th I18n.t('activerecord.attributes.article.content')
          td do
            textarea article.content, :style => 'width:100%;height:200px;'
          end
        end
      end
    end
  end

  # custom member action
  member_action :preview do
    @article = Article.find(params[:id])
#    render :layout => 'active_admin' # => error
  end
  action_item :only => :show do
    if controller.action_methods.include?("preview")
      link_to("Preview", preview_admin_article_path(resource))
    end
  end
  action_item :only => :show do
    if controller.action_methods.include?('new')
      link_to("New #{active_admin_config.resource_name}", new_resource_path)
    end
  end
  # index and show sidebar
  sidebar I18n.t(:recent_list), :only => [:index,:show] do
    render('/admin/articles/recent', :articles => ::Article.find(:all, :limit => 5, :order => 'updated_at DESC'))
  end
end
