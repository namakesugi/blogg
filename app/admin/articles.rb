ActiveAdmin.register Article do
## if you use grid
#  index :as => :grid, :columns => 2 do |article|
#    div do
#      span { link_to article.title, admin_article_path(article) }
#      br
#      span(:class => 'article_category') { article.category ? link_to(article.category.name, admin_category_path(article.category_id)) : I18n.t(:unknown) }
#    end
#  end
## default is table
  index do
    column I18n.t('activerecord.attributes.article.title'), :sortable => :title do |f|
      link_to f.title, admin_article_path(f)
    end
    column I18n.t('activerecord.attributes.article.slug'), :slug
#    column I18n.t('activerecord.attributes.article.category_id'), :category, :sortable => :category_id
    column I18n.t('activerecord.attributes.article.category_id'), :sortable => :category_id do |f|
      f.category ? link_to(f.category.name, admin_category_path(f.category_id)) : I18n.t(:unknown)
    end
    column I18n.t('activerecord.attributes.article.updated_at'), :updated_at
    column '', do |f|
      links = link_to I18n.t(:edit_link), edit_admin_article_path(f), :class => "edit_link"
      links += link_to I18n.t(:destory_link), admin_article_path(f), :method => :delete, :confirm => I18n.t(:destroy_confirm), :class => "delete_link"
      links
    end
#    default_actions :name => 'hoge' # if you use default action
  end
end
